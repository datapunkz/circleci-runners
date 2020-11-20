# circleci-runners

Example code for CircleCI Runners

[CircleCI Runner Docs](https://circleci.com/docs/2.0/runner-overview/)
[Installing the CircleCI Runner](https://circleci.com/docs/2.0/runner-installation/index.html)

## Create a CircleCI Namespace

Create a [CircleCI Personal API Token](https://circleci.com/docs/2.0/managing-api-tokens/#creating-a-personal-api-token)

# Install circleci cli
```shell
sudo curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | bash
``
# Create a CircleCI namespace you can have only one namespace per Organization
```shell
circleci namespace create ***<Name for namespace>*** github ***<VCS Organization>***
```

# Create a resource class in the CircleCI CLI (eg. namespace/<name for resource-class>)
```shell
circleci runner resource-class create ***namespace/<name for resource-class>*** "digital ocean runner"
```

# Create a token for authenticating the resource-class - Copy the token and save it
```shell
circleci runner token create ***namespace/<resource-class name>*** ***"<description>"***
```

## Terraform execution commands
These are the commands for the terraform execution commands

### Execute Plan
```shell
terraform plan \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_pvt_key=${HOME}/.ssh/id_rsa"
```

### Execute Apply
```shell
terraform apply \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_pvt_key=${HOME}/.ssh/id_rsa"
```

### Execute Apply with --auto-approve
```shell
terraform apply \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_pvt_key=${HOME}/.ssh/id_rsa" \
  -auto-approve
```

### Execute Destroy
```shell
terraform destroy \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_pvt_key=${HOME}/.ssh/id_rsa"
```

### Execute Destroy with --auto-approve
```shell
terraform destroy \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_pvt_key=${HOME}/.ssh/id_rsa" \
  -auto-approve
```