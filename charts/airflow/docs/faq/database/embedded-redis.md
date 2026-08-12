[🔗 Return to `Table of Contents` for more FAQ topics 🔗](https://github.com/airflow-helm/charts/tree/main/charts/airflow#frequently-asked-questions)

> Note, this page was written for the [`User-Community Airflow Helm Chart`](https://github.com/airflow-helm/charts/tree/main/charts/airflow)

# Configure Redis (Built-In)

> 🟦 __Tip__ 🟦
>
> You may consider using an [external redis](external-redis.md) rather than the embedded one.

## Use Valkey Instead of Redis

The embedded celery broker runs the official `redis` image by default.
If you would rather run [valkey](https://valkey.io/) — the BSD-3 licensed fork of redis 7.2.4, governed by the Linux Foundation — only the image needs to change:

```yaml
redis:
  image:
    repository: valkey/valkey
    tag: 9.1-trixie
```

Nothing else in the chart changes, because the valkey image ships `redis-server` and `redis-cli` as symlinks to the valkey binaries, so the broker command and the health probes keep working as-is.

> 🟦 __Tip__ 🟦
>
> Valkey reports `redis_version:7.2.4` in `INFO server` (alongside `server_name:valkey` and its own `valkey_version`), which is what keeps redis clients happy.
> Celery/kombu connect over the same `redis://` URL, so `externalRedis.*` also works against a valkey server.

> 🟨 __NOTE__ 🟨
>
> `valkey/valkey` is published by the valkey project rather than being a [Docker Official Image](https://docs.docker.com/trusted-content/official-images/), and it has no `bookworm` tags (use `trixie` or `alpine`).

## Set a Custom Password

The embedded Redis has an insecure password of `airflow` by default which is set by the `redis.password` value.
To improve security, you should generate a custom password and store it in a Kubernetes secret using `redis.existingSecret`.

For example, to use a pre-created Secret called `airflow-redis` that contains a key called `redis-password`:

```yaml
redis:
  existingSecret: airflow-redis
  existingSecretPasswordKey: redis-password
```

> 🟦 __Tip__ 🟦
>
> You may use `kubectl` to create the `airflow-redis` Secret with a random `redis-password` key.
>
> ```shell
> kubectl create secret generic \
>   airflow-redis \
>   --from-literal=redis-password=$(openssl rand -base64 13) \
>   --namespace my-airflow-namespace
> ```