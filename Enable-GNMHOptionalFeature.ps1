function Enable-GNMHOptionalFeature
{
    [CmdletBinding()]
    param (

        [Parameter(Mandatory=$true,
        HelpMessage="Name of a Windows Optional Feature.",
        ValueFromPipeline)]
        [string]$OptionalFeature
    )

    Process{
        try {
            $getOptionalFeature = (Get-WindowsOptionalFeature -Online -FeatureName $OptionalFeature)
    
            if(($getOptionalFeature.State) -eq "Enabled")
            {
                Disable-WindowsOptionalFeature -Online -FeatureName $getOptionalFeature.FeatureName
                Write-Host "$($getOptionalFeature.FeatureName) has been disabled." -ForegroundColor Cyan 
    
            }
            elseif (($getOptionalFeature.State) -eq "Disabled") 
            {
                Enable-WindowsOptionalFeature -Online -FeatureName $getOptionalFeature.FeatureName
                Write-Host "$($getOptionalFeature.FeatureName) has been enabled." -ForegroundColor Cyan 
            }
        }
        catch {
            {Please enter a valid optional feature.}
        }
    }

}