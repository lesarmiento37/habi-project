#!/bin/bash
if [ "$DESTROY_INFRA" == "true" ]; then
  echo "DESTROY_INFRA is set to true. Running 'terraform destroy'..."
  terraform destroy -auto-approve
else
  echo "DESTROY_INFRA is not set to true or not exists."
fi
