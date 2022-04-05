# Helm Chart Repository

## Creating a new chart

```
taito create: my-chart
```

## Making changes to an existing chart

1. Make some changes to the chart. You can test the changes locally by referencing the chart directly.

   Edit `requirements.yaml` of a project:

   ```
   version: N.N.N # Use the same chart version as in full-stack Chart.yaml
   repository: file:///taito-charts/full-stack
   ```

   Run dry-run deployment with a mounted `/taito-charts` directory:

   ```
   taito -m ~/projects/taito-charts:/taito-charts deployment deploy:dev --dry-run
   ```

   Run real deployment with a mounted `/taito-charts` directory:

   ```
   taito -m ~/projects/taito-charts:/taito-charts deployment deploy:dev
   ```

2. Increase chart version number in `Chart.yaml`

3. Create a new package:

   ```
   taito package: full-stack
   ```

4. Publish new chart version by pushing changes to git.

## Conventions

TODO: Use these conventions: [technical-requirements](https://github.com/helm/charts/blob/master/CONTRIBUTING.md#technical-requirements)
asdf
