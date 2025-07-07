resource "humanitec_resource_definition" "httproute" {
  driver_type = "humanitec/template"
  id          = "httproute"
  name        = "httproute"
  type        = "ingress"

  driver_inputs = {
    values_string = jsonencode({
      "host"          = "$${resources['${var.org_id}/dns'].outputs.host}"
      "routePaths"    = "$${resources['${var.org_id}/dns<route'].outputs.path}"
      "routePorts"    = "$${resources['${var.org_id}/dns<route'].outputs.port}"
      "routeServices" = "$${resources['${var.org_id}/dns<route'].outputs.service}"
      "templates" = {
        "manifests" = <<END_OF_TEXT
{{- if gt (len .driver.values.routePaths) 0 -}}
httproute.yaml:
  location: namespace
  data:
    apiVersion: gateway.networking.k8s.io/v1
    kind: HTTPRoute
    metadata:
      name: {{ .id }}-route
    spec:
      parentRefs:
      - kind: Gateway
        name: gke-gateway
        namespace: gke-gateway
      hostnames:
      - {{ .driver.values.host | toRawJson }}
      rules:
      {{- range $index, $path := .driver.values.routePaths }}
      - matches:
        - path:
            type: PathPrefix
            value: {{ $path | toRawJson }}
        backendRefs:
        - name: {{ index $.driver.values.routeServices $index | toRawJson }}
          port: {{ index $.driver.values.routePorts $index }}
      {{- end }}
{{- end -}}
END_OF_TEXT
        "outputs"   = <<END_OF_TEXT
id: {{ .id }}-route
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "httproute" {
  resource_definition_id = humanitec_resource_definition.httproute.id
  force_delete           = true
}