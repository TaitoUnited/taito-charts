{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "myname" -}}
{{- default .Values.global.project.name .Values.nameOverride | trunc 53 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "myfullname" -}}
{{- $name := default .Values.global.project.name .Values.nameOverride -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Render a volumeMount block for secret.
Usage:
  {{ include "fullstack.secretVolumeMount" (dict "name" $name "value" $value "prefix" "sidecar-") }}
*/}}
{{- define "fullstack.secretVolumeMount" -}}
{{- if .value }}

{{- $target := "" }}
{{- if eq (kindOf .value) "map" }}
  {{- $target = .value.target }}
{{- else }}
  {{- $target = (printf "/run/secrets/%s" .name) }}
{{- end }}

- name: {{ .prefix }}{{ lower .name | replace "_" "-" }}
  mountPath: {{ $target }}
  subPath: {{ .name }}
  readOnly: true

{{- end }}
{{- end }}

{{/*
Render a volume block for secret.
Usage:
  {{ include "fullstack.secretVolume" (dict "name" $name "value" $value "prefix" "sidecar-") }}
*/}}
{{- define "fullstack.secretVolume" -}}
{{- if .value }}

{{- $source := "" }}
{{- if eq (kindOf .value) "map" }}
  {{- $source = .value.source }}
{{- else }}
  {{- $source = .value }}
{{- end }}

- name: {{ .prefix }}{{ lower .name | replace "_" "-" }}
  secret:
    secretName: {{ regexReplaceAll "\\.[.a-zA-Z0-9]*$" $source "" }}
    items:
    - key: {{ regexFind "\\.[.a-zA-Z0-9]*$" $source | substr 1 -1 }}
      path: {{ .name }}

{{- end }}
{{- end }}
