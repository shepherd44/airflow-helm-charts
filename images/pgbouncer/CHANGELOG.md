# Changelog
All notable changes to the image will be documented in this file.

## [1.25.2-patch.0] - 2026-08-13

> This is the first release of the image from the [`shepherd44/airflow-helm-charts`](https://github.com/shepherd44/airflow-helm-charts) fork.
> It is published to `ghcr.io/shepherd44/pgbouncer`, because the upstream image has not been rebuilt since 2024-04-24.

### Changed

- Updated PgBouncer to version `1.25.2`, which picks up the following security fixes:
  - `1.24.1` — [CVE-2025-2291](https://www.pgbouncer.org/changelog.html) (password validity was not checked)
  - `1.25.1` — [CVE-2025-12819](https://www.pgbouncer.org/changelog.html) (`search_path` handling)
  - `1.25.2` — [CVE-2026-6664, CVE-2026-6665, CVE-2026-6666, CVE-2026-6667](https://www.pgbouncer.org/changelog.html)
- Updated Alpine Linux to `3.22` branch
- Replaced the `libressl` runtime package with `openssl`, as alpine no longer ships `libressl`

### Added

- Added `pandoc-cli` to the builder stage, because PgBouncer >=1.24 builds its man page during `make`

## [1.22.1-patch.0] - 2024-04-24

### Changed

- Updated PgBouncer to version `1.22.1`
- Updated Alpine Linux to `3.19` branch

## [1.18.0-patch.1] - 2023-04-06

### Added

- Added `openssl` to image (for generating self-signed certificates)

## [1.18.0-patch.0] - 2023-04-05

### Changed

- Updated PgBouncer to version `1.18.0`
- Updated Alpine Linux to `3.15` branch

## [1.17.0-patch.0] - 2022-03-28

### Added
- Build images for `linux/arm64` (in addition to `linux/amd64`)

### Changed
- Updated PgBouncer to version `1.17.0`
- Updated Alpine Linux to `3.14` branch

## [1.15.0-patch.0] - 2021-07-27

### Added
- Initial release of Dockerfile with PgBouncer version `1.15.0`

[1.25.2-patch.0]: https://github.com/shepherd44/airflow-helm-charts/tree/images/pgbouncer-1.25.2-patch.0/images/pgbouncer
[1.22.1-patch.0]: https://github.com/airflow-helm/charts/tree/images/pgbouncer-1.22.1-patch.0/images/pgbouncer
[1.18.0-patch.1]: https://github.com/airflow-helm/charts/tree/images/pgbouncer-1.18.0-patch.1/images/pgbouncer
[1.18.0-patch.0]: https://github.com/airflow-helm/charts/tree/images/pgbouncer-1.18.0-patch.0/images/pgbouncer
[1.17.0-patch.0]: https://github.com/airflow-helm/charts/tree/images/pgbouncer-1.17.0-patch.0/images/pgbouncer
[1.15.0-patch.0]: https://github.com/airflow-helm/charts/tree/images/pgbouncer-1.15.0-patch.0/images/pgbouncer