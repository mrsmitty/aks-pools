<#
.SYNOPSIS
.PARAMETER winpassword
.NOTES
.NOTES
Create a valid windows password using the following
^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%\\^&\\*\\(\\)])[a-zA-Z\\d!@#$%\\^&\\*\\(\\)]{12,123}$
https://www.browserling.com/tools/text-from-regex
#>

param (
    [string] $winPassword,
    [string] $resourceGroup = "paul-rg-aue-akspools",
    [string] $clusterName = "paul-aks-aue-winpool"
)
az group create --name $resourceGroup --location australiaeast

az aks create `
    --resource-group $resourceGroup `
    --name $clusterName `
    --node-count 1 `
    --enable-addons monitoring `
    --kubernetes-version 1.14.0 `
    --generate-ssh-keys `
    --windows-admin-password $winPassword `
    --windows-admin-username azureuser `
    --enable-vmss `
    --network-plugin azure

    az aks nodepool add `
    --resource-group $resourceGroup `
    --cluster-name $clusterName `
    --os-type Windows `
    --name npwin `
    --node-count 1 `
    --kubernetes-version 1.14.0

    # only run if kubectl is not installed
    #az aks install-cli

    az aks get-credentials --resource-group $resourceGroup --name $clusterName