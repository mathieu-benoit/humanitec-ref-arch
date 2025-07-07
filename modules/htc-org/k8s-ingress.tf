resource "humanitec_resource_definition" "ingress" {
  driver_type = "humanitec/template"
  id          = "custom-ingress"
  name        = "custom-ingress"
  type        = "ingress"

  driver_inputs = {
    values_string = jsonencode({
      "class"         = "nginx"
      "host"          = "$${resources['${var.org_id}/dns'].outputs.host}"
      "tlsSecretName" = "$${resources.tls-cert.outputs.tls_secret_name}"
      "routePaths"    = "$${resources['${var.org_id}/dns<route'].outputs.path}"
      "routePorts"    = "$${resources['${var.org_id}/dns<route'].outputs.port}"
      "routeServices" = "$${resources['${var.org_id}/dns<route'].outputs.service}"
      "templates" = {
        "manifests" = <<END_OF_TEXT
{{- if gt (len .driver.values.routePaths) 0 -}}
ingress.yaml:
  location: namespace
  data:
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      {{- if hasKey .driver.values "annotations" }}
      annotations: {{ .driver.values.annotations | toRawJson }}
      {{- end}}
      {{- if hasKey .driver.values "labels" }}
      labels: {{ .driver.values.labels | toRawJson }}
      {{- end}}
      name: {{ .id }}-ingress
    spec:
      {{- if .driver.values.class }}
      ingressClassName: {{ .driver.values.class | toRawJson }}
      {{- end }}
      rules:
      - host: {{ .driver.values.host | toRawJson }}
        http:
          paths:
          {{- range $index, $path := .driver.values.routePaths }}
          - path: {{ $path | toRawJson }}
            pathType: {{ $.driver.values.path_type | default "Prefix" | toRawJson }}
            backend:
              service:
                name: {{ index $.driver.values.routeServices $index | toRawJson }}
                port:
                  number: {{ index $.driver.values.routePorts $index }}
          {{- end }}
      tls:
      - hosts:
        - {{ .driver.values.host | toRawJson }}
        secretName: {{ .driver.values.tlsSecretName | toRawJson }}
{{- end -}}
END_OF_TEXT
        "outputs"   = <<END_OF_TEXT
id: {{ .id }}-ingress
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "ingress" {
  resource_definition_id = humanitec_resource_definition.ingress.id
  force_delete           = true
}