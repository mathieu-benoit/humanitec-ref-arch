namespace.yaml:
  location: cluster
  data:
    apiVersion: v1
    kind: Namespace
    metadata:
      labels:
        humanitec.io/app: ${context.app.id}
        humanitec.io/env: ${context.env.id}
      name: {{ .init.name }}