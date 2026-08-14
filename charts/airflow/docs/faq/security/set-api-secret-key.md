[🔗 Return to `Table of Contents` for more FAQ topics 🔗](https://github.com/airflow-helm/charts/tree/main/charts/airflow#frequently-asked-questions)

> Note, this page was written for the [`User-Community Airflow Helm Chart`](https://github.com/airflow-helm/charts/tree/main/charts/airflow)

# Set Airflow Webserver Secret Key

## Option 1 - using the value

### Airflow 2.X

> 🟥 __Warning__ 🟥
>
> We strongly recommend that you DO NOT USE the default `airflow.apiSecretKey` in production.

You may set the api-server secret_key using the `airflow.apiSecretKey` value, which sets the `AIRFLOW__API__SECRET_KEY` environment variable.

For example, to define the secret_key with `airflow.apiSecretKey`:

```yaml
aiflow:
  apiSecretKey: "THIS IS UNSAFE!"
```

### Airflow 3.X

> 🟥 __Warning__ 🟥
>
> We strongly recommend that you DO NOT USE the default `airflow.apiSecretKey` in production.

You may set the API secret_key using the `airflow.apiSecretKey` value, which sets the `AIRFLOW__API__SECRET_KEY` environment variable.

For example, to define the secret_key with `airflow.apiSecretKey`:

```yaml
aiflow:
  apiSecretKey: "THIS IS UNSAFE!"
```

## Option 2 - using a secret (recommended)

### Airflow 2.X

You may set the api-server secret_key from a Kubernetes Secret by referencing it with the `airflow.extraEnv` value.

For example, to use the `value` key from the existing Secret called `airflow-api-secret-key`:

```yaml
airflow:
  extraEnv:
    - name: AIRFLOW__API__SECRET_KEY
      valueFrom:
        secretKeyRef:
          name: airflow-api-secret-key
          key: value
```

### Airflow 3.X

You may set the API secret_key from a Kubernetes Secret by referencing it with the `airflow.extraEnv` value.

For example, to use the `value` key from the existing Secret called `airflow-api-secret-key`:

```yaml
airflow:
  extraEnv:
    - name: AIRFLOW__API__SECRET_KEY
      valueFrom:
        secretKeyRef:
          name: airflow-api-secret-key
          key: value
```

## Option 3 - using `_CMD` or `_SECRET` configs

### Airflow 2.X

You may also set the webserver secret key by specifying either the `AIRFLOW__API__SECRET_KEY_CMD` or `AIRFLOW__API__SECRET_KEY_SECRET` environment variables.
Read about how the `_CMD` or `_SECRET` configs work in the ["Setting Configuration Options"](https://airflow.apache.org/docs/apache-airflow/stable/howto/set-config.html) section of the Airflow documentation.

For example, to use `AIRFLOW__API__SECRET_KEY_CMD`:

```yaml
airflow:
  ## WARNING: you must set `apiSecretKey` to "", otherwise it will take precedence
  apiSecretKey: ""

  ## NOTE: this is only an example, if your value lives in a Secret, you probably want to use "Option 2" above
  config:
    AIRFLOW__API__SECRET_KEY_CMD: "cat /opt/airflow/api-secret-key/value"
      
  extraVolumeMounts:
    - name: api-secret-key
      mountPath: /opt/airflow/api-secret-key
      readOnly: true
      
  extraVolumes:
    - name: api-secret-key
      secret:
        secretName: airflow-api-secret-key
```

### Airflow 3.X

You may also set the API secret key by specifying either the `AIRFLOW__API__SECRET_KEY_CMD` or `AIRFLOW__API__SECRET_KEY_SECRET` environment variables.
Read about how the `_CMD` or `_SECRET` configs work in the ["Setting Configuration Options"](https://airflow.apache.org/docs/apache-airflow/stable/howto/set-config.html) section of the Airflow documentation.

For example, to use `AIRFLOW__API__SECRET_KEY_CMD`:

```yaml
airflow:
  ## WARNING: you must set `apiSecretKey` to "", otherwise it will take precedence
  apiSecretKey: ""

  ## NOTE: this is only an example, if your value lives in a Secret, you probably want to use "Option 2" above
  config:
    AIRFLOW__API__SECRET_KEY_CMD: "cat /opt/airflow/api-secret-key/value"
      
  extraVolumeMounts:
    - name: api-secret-key
      mountPath: /opt/airflow/api-secret-key
      readOnly: true
      
  extraVolumes:
    - name: api-secret-key
      secret:
        secretName: airflow-api-secret-key
```

## Note on Airflow 3

In Airflow 3 this key lives under `[api] secret_key` rather than `[webserver] secret_key`.
It signs the api-server's session cookies AND authorises the log-fetch requests that the
api-server makes to celery workers, so it must be identical in every component.

It is a **different key** from the Task Execution API signing key -- see
[set-jwt-secret.md](set-jwt-secret.md). You need both.
