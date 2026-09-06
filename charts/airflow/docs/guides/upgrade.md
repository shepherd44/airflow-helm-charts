[🔗 Return to `Table of Contents` for more guides 🔗](https://github.com/shepherd44/airflow-helm-charts/tree/main/charts/airflow#guides)

> Note, this page was written for the [`User-Community Airflow Helm Chart`](https://github.com/shepherd44/airflow-helm-charts/tree/main/charts/airflow)

# Upgrade Guide

## Step 1 - Prepare your Changes

This guide is applicable in the following situations:

1. upgrading to newer versions of the chart
2. applying changes made to your `custom-values.yaml` file

## Step 2 - Apply your Changes

```shell
## set the release-name & namespace (must be same as previously installed)
export AIRFLOW_NAME="airflow-cluster"
export AIRFLOW_NAMESPACE="airflow-cluster"

## apply any changed `custom-values.yaml` AND upgrade the chart to version `12.X.X`
helm upgrade \
  "$AIRFLOW_NAME" \
  oci://ghcr.io/shepherd44/charts/airflow \
  --namespace "$AIRFLOW_NAMESPACE" \
  --version "12.X.X" \
  --values ./custom-values.yaml
```

> 🟥 __Warning__ 🟥
>
> Always pin the `--version` so you don't unexpectedly update chart versions!

> 🟥 __Warning__ 🟥
>
> Before upgrading chart versions, always consult [`CHANGELOG.md`](../../CHANGELOG.md)!

> 🟦 __Tip__ 🟦
>
> - find the full list of chart versions in our [CHANGELOG](https://github.com/shepherd44/airflow-helm-charts/blob/main/charts/airflow/CHANGELOG.md)
> - `Watch 👀 on GitHub` to be notified about new chart versions, click "watch" → "custom" → "releases".
