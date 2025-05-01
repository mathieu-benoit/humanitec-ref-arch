#!/bin/bash
set -o errexit

cd modules/org/manifests/
templates=$(ls .)
for template in $templates;
do
  echo "## Testing ${template}:"
  cp ../../../scripts/test.yaml $template/test-$template.yaml
  cd $template
  
  template=$template yq -i '.entity.type = env(template)' test-$template.yaml
  
  yq -i '.entity.driver_inputs.values = load("definition-values.yaml")' test-$template.yaml
  
  tests=$(ls tests/*-inputs.yaml)
  for test in $tests;
  do
    echo "## ${template} tested with ${test}."
    humctl resources test-definition test-$template.yaml --inputs $test
  done

  #rm test-$template.yaml
  cd ..
done