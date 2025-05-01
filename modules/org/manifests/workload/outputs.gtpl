update:
  - op: add
    path: /spec/serviceAccountName
    value: ${resources.k8s-service-account.outputs.name}