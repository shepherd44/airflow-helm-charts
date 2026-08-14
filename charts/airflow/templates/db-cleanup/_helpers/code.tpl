{{/*
The python script which drops archive tables left behind by `airflow db clean`.

`airflow db clean` archives rather than deletes: purged rows are moved into
`_airflow_deleted__<table>__<YYYYMMDDHHMMSS>` tables, so the database does not actually
shrink until those are dropped. `airflow db drop-archived` reclaims the space, but it
takes an explicit table list and there is no "older than N days" flag -- the only
timestamp is in the table NAME. This works out which names are old enough.
*/}}
{{- define "airflow.db_cleanup.drop_archived.py" }}
import re
import sys

from airflow.settings import Session
from sqlalchemy import text

## NOTE: this is admin-side maintenance running in a CronJob, not task code. Airflow 3
##       forbids the metadata DB to task code because workers have no DB connection, but
##       a maintenance job runs with the same access the db-migrations job has.

ARCHIVE_PREFIX = "_airflow_deleted__"

## NOTE: the batch suffix is why this cannot just split on the last "__". With
##       `--batch-size` set, `db clean` names tables `..._<timestamp>__b<N>`, so taking
##       the final segment reads the batch number as the timestamp and nothing is ever
##       dropped -- silently, because the list simply comes back empty.
NAME_RE = re.compile(r"__(\d{14})(?:__b\d+)?$")


def main(cutoff: str) -> None:
    with Session() as session:
        names = session.execute(
            text("SELECT tablename FROM pg_tables WHERE tablename LIKE :pattern"),
            {"pattern": ARCHIVE_PREFIX.replace("_", r"\_") + "%"},
        ).scalars().all()

    old = []
    for name in names:
        match = NAME_RE.search(name)
        if match is None:
            ## an archive table we do not recognise: leave it alone rather than guess
            continue
        if match.group(1) < cutoff:
            old.append(name)

    print(",".join(sorted(old)))


if __name__ == "__main__":
    main(sys.argv[1])
{{- end }}
