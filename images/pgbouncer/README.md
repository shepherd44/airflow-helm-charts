# PgBouncer Docker Image

The Apache Airflow helm chart under [charts/airflow](https://github.com/shepherd44/airflow-helm-charts/tree/main/charts/airflow) uses this docker image to implement [PgBouncer](https://www.pgbouncer.org/) support.

> This image is built by the [`shepherd44/airflow-helm-charts`](https://github.com/shepherd44/airflow-helm-charts) fork.
> The upstream image (`ghcr.io/airflow-helm/pgbouncer`) has not been rebuilt since 2024-04-24, and so is missing several PgBouncer security fixes.

### Important Links:
- The [Dockerfile](https://github.com/shepherd44/airflow-helm-charts/blob/main/images/pgbouncer/Dockerfile) for this image.
- The [CHANGELOG.md](https://github.com/shepherd44/airflow-helm-charts/blob/main/images/pgbouncer/CHANGELOG.md) for this image.

### Pull Locations:
- [GitHub Container Registry](https://ghcr.io/shepherd44/pgbouncer):
  - `docker pull ghcr.io/shepherd44/pgbouncer:latest`
