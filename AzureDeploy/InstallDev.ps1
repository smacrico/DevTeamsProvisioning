# Provision storage and function app
.\Deploy-AzureResourceGroup.ps1 `
    -ResourceGroupLocation westeurope `
    -ResourceGroupName devteamstorage `
    -TemplateParametersFile prod.parameters.json

# Ensure storage queues are in place
$storageAccount = Get-AzureRmStorageAccount | Where-Object ResourceGroupName -eq "devteamstorage"
$storageContext = $storageAccount.Context
New-AzureStorageQueue -Name "create-team-request-stmaqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "create-team-completion-stmaqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-request-stmaqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-completion-stmaqueue" -Context $storageContext -ErrorAction Ignore