resource "humanitec_pipeline" "wait_for_readiness" {
  app_id     = humanitec_application.app.id
  definition = <<EOT
name: Wait for Workloads readiness
on:
  deployment_request: {}
concurrency:
  group: default-deploy-$${{ inputs.env_id }}
jobs:
  deploy:
    name: Deploy
    steps:
    - if: $${{ ! inputs.set_id }}
      name: Create Deployment Set
      id: create-deployment-set
      uses: actions/humanitec/apply@v1
      with:
        delta_id: $${{ inputs.delta_id }}
        env_id: $${{ inputs.env_id }}
    - name: "Deploy Set To Environment"
      uses: actions/humanitec/deploy@v1
      with:
        set_id: $${{ inputs.set_id || steps.create-deployment-set.outputs.set_id }}
        value_set_version_id: $${{ inputs.value_set_version_id }}
        env_id: $${{ inputs.env_id }}
        message: $${{ inputs.comment }}
    - name: "Wait for Workload readiness"
      continue-on-error: true
      id: wait-for-workload-readiness
      uses: native://actions/humanitec/wait-for-readiness@v1
      with:
        env_id: $${{ inputs.env_id }}
    - name: Fail if Workloads readiness failed
      if: $${{ steps.wait-for-workload-readiness.status == 'failed' }}
      uses: native://actions/humanitec/fail@v1
      with:
        message: Workloads readiness failed.
EOT
}

resource "humanitec_pipeline_criteria" "wait_for_readiness" {
  /* Iterating through each env_type to avoid the conflict with the default pipeline with app_id in criteria. */
  for_each = { for env_type in var.env_types : env_type.id => env_type }

  app_id      = humanitec_application.app.id
  pipeline_id = humanitec_pipeline.wait_for_readiness.id

  deployment_request = {
    env_type = each.value.id
  }
}
