# Provision storage and function app
.\Deploy-AzureResourceGroup.ps1 `
    -ResourceGroupLocation westeurope `
    -ResourceGroupName pvresgroup `
    -TemplateParametersFile prod.parameters.json

# Ensure storage queues are in place
$storageAccount = Get-AzureRmStorageAccount | Where-Object ResourceGroupName -eq "pvresgroup"
$storageContext = $storageAccount.Context
New-AzureStorageQueue -Name "create-team-request-devqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "create-team-completion-devqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-request-devqueue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-completion-devqueue" -Context $storageContext -ErrorAction Ignore