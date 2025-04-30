#
# Script to run any action for the Terraform deployment
#

# params
param ($env,$action)

# validate params
if ($env -notin('dev')) {
    return "Error: parameter 'env' not defined or invalid. Accepted values : dev"
}

if ($action -notin('validate','plan','apply','destroy')) {
    return "Error: parameter 'action' not defined or invalid. Accepted values : validate|plan|apply|destroy"
}

# start
$backend_varfile = './environments/' + $env + '/terraform_backend.tfvars'
$varfile = './environments/' + $env + '/terraform.tfvars'
Write-Host "Action: $action" -ForegroundColor Yellow
Write-Host "Environment: $env" -ForegroundColor Yellow
Write-Host "Backend tfvars file: $backend_varfile" -ForegroundColor Yellow
Write-Host "tfvars file: $varfile" -ForegroundColor Yellow

try {
    # init
    Write-Host "Executing: Terraform $action"
    terraform init --backend-config=$backend_varfile 
    if ($? -ne "true") {
        throw 
    }

    # format
    Write-Host "Executing: Terraform fmt"
    terraform fmt --recursive
    if ($? -ne "true") {
        throw 
    }

    # get
    Write-Host "Executing: Terraform get"
    terraform get
    if ($? -ne "true") {
        throw 
    }

    # validate
    Write-Host "Executing: Terraform validate"
    terraform validate   
    if ($? -ne "true") {
        throw 
    } 

    if ($action -eq 'validate') {
        return "Done."
    }

    # execute action
    Write-Host "Executing: Terraform $action"
    terraform $action --var-file=$varfile 
    if ($? -ne "true") {
        throw 
    }
}
catch {
    return "Done."
}

