param(
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$StorageAccountName,

    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId
)

$ErrorActionPreference = "Stop"

Write-Host "Setting Azure Context..."

Set-AzContext -SubscriptionId $SubscriptionId

Get-AzContext

Write-Host "Checking Storage Account..."

$storageAccount = Get-AzStorageAccount `
    -ResourceGroupName $ResourceGroupName `
    -Name $StorageAccountName `
    -ErrorAction SilentlyContinue

if ($storageAccount) {

    Write-Host "Deleting Storage Account: $StorageAccountName"

    Remove-AzStorageAccount `
        -ResourceGroupName $ResourceGroupName `
        -Name $StorageAccountName `
        -Force
}
else {
    Write-Host "Storage Account does not exist. Skipping."
}

Write-Host "Checking Resource Group..."

$resourceGroup = Get-AzResourceGroup `
    -Name $ResourceGroupName `
    -ErrorAction SilentlyContinue

if ($resourceGroup) {

    Write-Host "Deleting Resource Group: $ResourceGroupName"

    Remove-AzResourceGroup `
        -Name $ResourceGroupName `
        -Force
}
else {
    Write-Host "Resource Group does not exist. Skipping."
}