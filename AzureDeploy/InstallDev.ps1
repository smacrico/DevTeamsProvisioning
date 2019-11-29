# Provision storage and function app
.\Deploy-AzureResourceGroup.ps1 `
    -ResourceGroupLocation westeurope `
    -ResourceGroupName pvteamsresourcegroup `
    -TemplateParametersFile prod.parameters.json

# Ensure storage queues are in place
$storageAccount = Get-AzureRmStorageAccount | Where-Object ResourceGroupName -eq "pvteamsresourcegroup"
$storageContext = $storageAccount.Context
New-AzureStorageQueue -Name "create-team-request-pvqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "create-team-completion-pvqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-request-pvqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-completion-pvqueue" -Context $storageContext -ErrorAction Ignore