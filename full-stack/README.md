# Full Stack Helm Chart

Helm chart for deploying custom applications to Kubernetes. You can define resources with a developer-friendly YAML that resembles docker-compose.yaml format. See [full-stack-template](https://github.com/TaitoUnited/full-stack-template/) for a working example, and [some configuration examples](https://github.com/TaitoUnited/full-stack-template/blob/dev/scripts/helm/examples.yaml).

Example YAML:

```
full-stack:
  ingress:
    class: nginx
    namespace: nginx-ingress
    tls: true
    domains:
      - name: ${taito_domain}
        altName: ${taito_altdomain}

  services:
    admin:
      paths:
        - path: /admin
      cpuRequest: 2m
      memoryRequest: 2Mi

    client:
      paths:
        - path:
      cpuRequest: 2m
      memoryRequest: 2Mi

    redis:
      image: bitnami/redis:6.0
      replicas: 1
      port: 6379
      livenessCommand:
        - redis-cli
        - ping
      memoryRequest: 10Mi
      secrets:
        REDIS_PASSWORD: ${taito_project}-${taito_env}-redis.password
      env:
        REDIS_PASSWORD_FILE: '/run/secrets/REDIS_PASSWORD'
        REDIS_AOF_ENABLED: 'no'

    server:
      paths:
        - path: /api
      egress:
        - ip: '${db_database_real_host}/32'
        - fullname: ${taito_project}-${taito_env}-redis
      livenessInitialDelay: 120
      secrets:
        DATABASE_SSL_CA: ${db_database_ssl_ca_secret}
        DATABASE_SSL_CERT: ${db_database_ssl_cert_secret}
        DATABASE_SSL_KEY: ${db_database_ssl_key_secret}
        DATABASE_PASSWORD: ${db_database_app_secret}
        REDIS_PASSWORD: ${taito_project}-${taito_env}-redis.password
      env:
        BASE_PATH: /api
        API_PORT: '8080'
        API_BINDADDR: '0.0.0.0'
        DATABASE_HOST: '${db_database_real_host}'
        DATABASE_PORT: '${db_database_real_port}'
        DATABASE_SSL_ENABLED: ${db_database_ssl_enabled}
        DATABASE_SSL_CLIENT_CERT_ENABLED: ${db_database_ssl_client_cert_enabled}
        DATABASE_SSL_SERVER_CERT_ENABLED: ${db_database_ssl_server_cert_enabled}
        DATABASE_NAME: ${db_database_name}
        DATABASE_USER: ${db_database_app_username}
        DATABASE_POOL_MIN: '0'
        DATABASE_POOL_MAX: '5'
        REDIS_HOST: ${taito_project}-${taito_env}-redis
        REDIS_PORT: 6379
```

