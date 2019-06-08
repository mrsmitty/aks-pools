<#
.SYNOPSIS
Registeres the AKS WindowsPreview features in the Subscription
.LINK
https://docs.microsoft.com/en-us/azure/aks/windows-container-cli
#>

az feature register --name WindowsPreview --namespace Microsoft.ContainerService

do {
    $feature = az feature list -o json --query "[?contains(name, 'Microsoft.ContainerService/WindowsPreview')].{Name:name,State:properties.state}" | ConvertFrom-Json
    Write-Host $feature.State
    Start-Sleep -Seconds 5
} while ($feature.State -ne 'Registered')

az provider register --namespace Microsoft.ContainerService