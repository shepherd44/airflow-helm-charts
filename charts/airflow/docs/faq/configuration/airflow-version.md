[🔗 Return to `Table of Contents` for more FAQ topics 🔗](https://github.com/airflow-helm/charts/tree/main/charts/airflow#frequently-asked-questions)

> Note, this page was written for the [`User-Community Airflow Helm Chart`](https://github.com/airflow-helm/charts/tree/main/charts/airflow)

# Set Airflow Version

> 🟦 __Tip__ 🟦
>
> There is a default version of airflow shipped with each version of the chart, see the [default `values.yaml`](../../../values.yaml) for the current one.
>
> Many versions of airflow versions are supported by the chart, please see the [Airflow Version Support](../../../README.md#airflow-version-support) matrix.

## Airflow 2.X

For example, to use airflow `2.1.4`, with python `3.7`:

```yaml
airflow:
  image:
    repository: apache/airflow
    tag: 2.1.4-python3.7
```

## Airflow 1.10

> 🟥 __Warning__ 🟥
>
> This chart supports Apache Airflow 3.0.0 and above only. To run Airflow 2, use the `10.X.X` releases of this chart.

For example, to use airflow `1.10.15`, with python `3.8`:

```yaml
airflow:
  # WARNING: this must be "true" for airflow 1.10
  
  image:
    repository: apache/airflow
    tag: 1.10.15-python3.8
```

## Building a Custom Image

Airflow provides documentation on [building custom docker images](https://airflow.apache.org/docs/docker-stack/build.html), you may follow this process to create a custom image.

For example, after building and tagging your Dockerfile as `MY_REPO:MY_TAG`, you may use it with the chart by specifying `airflow.image.*`:

```yaml
airflow:
  # WARNING: this must be "true" for airflow 1.10
  
  image:
    repository: MY_REPO
    tag: MY_TAG

    ## WARNING: even if set to "Always" do not reuse tag names, as containers only pull the latest image when restarting
    pullPolicy: IfNotPresent

    ## sets first element of `spec.imagePullSecrets` on Pod templates (for access to private container registry)
    pullSecret: ""
```
