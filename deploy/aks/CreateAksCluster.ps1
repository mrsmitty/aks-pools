<#
.SYNOPSIS
.PARAMETER winpassword
.LINK
#>

param (
    [securestring] $winPassword,
    [string] $resourceGroup = "paul-rg-aue-akspools"
)
az group create --name $resourceGroup --location australiaeast

az aks create `
    --resource-group $resourceGroup `
    --name myAKSCluster `
    --node-count 1 `
    --enable-addons monitoring `
    --kubernetes-version 1.14.0 `
    --generate-ssh-keys `
    --windows-admin-password $winPassword `
    --windows-admin-username azureuser `
    --enable-vmss `
    --network-plugin azure