# Kubernetes namespace initialization

Example values.yaml:

```
serviceAccounts:
  - name: my-service-account

roles:
  - name: taito-restricted-pod # Pod Security Policy
    subjects:
      - sa:default
      - sa:my-service-account
  - name: taito-developer
    subjects:
      - user:jane.doe@mydomain.com
```
