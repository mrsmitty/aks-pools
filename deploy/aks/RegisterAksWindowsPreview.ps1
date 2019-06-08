<#
.SYNOPSIS
Registeres the AKS WindowsPreview, MultiAgentpoolPreview, VMSSPreview features in the Subscription

.LINK
https://docs.microsoft.com/en-us/azure/aks/windows-container-cli
https://docs.microsoft.com/en-au/azure/aks/use-multiple-node-pools
#>

function checkFeature($featureName) {
    do {
        $feature = az feature list -o json --query "[?contains(name, '$featureName')].{Name:name,State:properties.state}" | ConvertFrom-Json
        Write-Host $feature.State
        Start-Sleep -Seconds 5
    } while ($feature.State -ne 'Registered')
}

az extension add --name aks-preview

az feature register --name WindowsPreview --namespace Microsoft.ContainerService
checkFeature('Microsoft.ContainerService/WindowsPreview')
az provider register --namespace Microsoft.ContainerService

az feature register --name MultiAgentpoolPreview --namespace Microsoft.ContainerService
checkFeature('Microsoft.ContainerService/MultiAgentpoolPreview')
az provider register --namespace Microsoft.ContainerService

az feature register --name VMSSPreview --namespace Microsoft.ContainerService
checkFeature('Microsoft.ContainerService/VMSSPreview')
az provider register --namespace Microsoft.ContainerService