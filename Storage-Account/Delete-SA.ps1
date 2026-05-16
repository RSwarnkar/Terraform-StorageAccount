param(
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$StorageAccountName
)

$ErrorActionPreference = "Stop"

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

    Write-Host "Storage Account deletion initiated."
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

    Write-Host "Resource Group deletion initiated."
}
else {
    Write-Host "Resource Group does not exist. Skipping."
}

Write-Host "Cleanup completed."