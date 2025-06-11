#!/bin/bash
set -o errexit

cd modules/htc-org/manifests/
templates=$(ls .)
for template in $templates;
do
  echo "## Testing ${template}:"
  cp ../../../scripts/test.yaml $template/test.yaml
  cd $template
  
  template=$template yq -i '.entity.type = env(template)' test.yaml
  
  yq -i '.entity.driver_inputs.values = load("definition-values.yaml")' test.yaml
  
  tests=$(ls tests/*-inputs.yaml)
  for test in $tests;
  do
    echo "## ${template} tested with ${test}."
    humctl resources test-definition test.yaml --inputs $test
  done

  rm test.yaml
  cd ..
done