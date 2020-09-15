# Kubernetes basic definitions and access management

Example values.yaml:

```
provider: gcp
dbProxyNamespace: db-proxy
cicd:
  deployServiceAccount: serviceAccount:0123456789@cloudbuild.gserviceaccount.com
  testingServiceAccount: serviceAccount:cicd-tester@gcloud-temp1.iam.gserviceaccount.com
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
