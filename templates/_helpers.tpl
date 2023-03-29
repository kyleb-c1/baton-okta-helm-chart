{{/*
Expand the name of the chart.
*/}}
{{- define "baton-okta.fullname" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
