# Provision storage and function app
.\Deploy-AzureResourceGroup.ps1 `
    -ResourceGroupLocation westeurope `
    -ResourceGroupName venusdevstoragegroup `
    -TemplateParametersFile dev.parameters.json

# Ensure storage queues are in place
$storageAccount = Get-AzureRmStorageAccount | Where-Object ResourceGroupName -eq "venusdevstoragegroup"
$storageContext = $storageAccount.Context
New-AzureStorageQueue -Name "create-team-request-myqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "create-team-completion-myqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-request-myqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-completion-myqueue" -Context $storageContext -ErrorAction Ignore
