# Basic definitions and access management for Kubernetes cluster

Example values.yaml:

```
provider: gcp
permissions:
  clusterRoles:
    - name: taito-iam-admin
      subjects: [ "group:devops@mydomain.com" ]
    - name: taito-status-viewer
      subjects: [ "group:staff@mydomain.com" ]
  namespaces:
    - name: db-proxy
      clusterRoles:
        - name: taito-pod-portforwarder
          subjects: [ "user:jane.external@anotherdomain.com" ]
    - name: my-namespace
      clusterRoles:
        - name: taito-status-viewer
          subjects: [ "user:jane.external@anotherdomain.com" ]
    - name: another-namespace
      clusterRoles:
        - name: taito-developer
          subjects: [ "user:jane.external@anotherdomain.com" ]
```
