# Kubernetes namespace initialization

Example values.yaml:

```
networkPolicyEnabled: true

serviceAccounts:
  - name: my-service-account

roles:
  - name: taito-restricted-pod # Pod Security Policy
    subjects:
      - sa:my-service-account
  - name: taito-developer
    subjects:
      - user:jane.doe@mydomain.com
  - name: taito-secret-viewer
    id: taito-secret-viewers-for-project-x
    namespace: common
    subjects:
      - user:jane.doe@mydomain.com
```
