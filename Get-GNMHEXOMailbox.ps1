function Get-GNMHEXOMailbox 
{

    [CmdletBinding()]
    param (
        [Parameter(
        Mandatory=$true,
        ValueFromPipeline,
        HelpMessage="Enter the username of an employee. Ex: jdoe")]
        [string]$GNMHUsername,
        [Parameter(
        Mandatory=$true,
        HelpMessage="Enter the username of an employee. Ex: jdoe")]
        [string]$UPN
    )

    Process 
    {

        $ConnectionArgs = @{
            UserPrincipalName = $UPN
            ShowBanner = $false
            ShowProgress = $true
        }

        # Check if `Exchange Online Management` module has been installed
        $getEXOModule = Get-InstalledModule -Name "ExchangeOnlineManagement" -ErrorAction SilentlyContinue
        if (-not $getEXOModule) {
            Write-Host "The module 'Exchange Online Management' is missing. To continue, it will need to be installed." -ForegroundColor Yellow
            $installEXOManagement = Read-Host Do you want to install ExchangeOnlineManagement? [Y] Yes [N] No
            if ($installEXOManagement -like "[Yy]")
            {
                Install-Module -Name "ExchangeOnlineManagement" -Repository PSGallery -AllowClobber -Force
                Write-Host "Exchange Online Management has been successfully installed." -ForegroundColor Cyan
            }
            else 
            {
                Write-Host "The 'Exchange Online Management' module is necessary to query user mailboxes. Please install it now." -ForegroundColor Red
                $lastchance = Read-Host Do you want to install it now? [Y] Yes [N] No
                if ($lastchance -like "[Yy]")
                {
                    Install-Module -Name "ExchangeOnlineManagement" -Repository PSGallery -AllowClobber -Force
                    Write-Host "Exchange Online Management has been successfully installed." -ForegroundColor Cyan
                }
                else {
                    Stop-Process -ID $PID
                }
            }
            
        }

        # Check if the service `WinRM or Windows Remote Management` is running
        $getWinRM = Get-Service -Name "WinRM"
        if (($getWinRM.Status) -eq "Stopped")
        {
            Start-Service -InputObject $getWinRM
            Write-Host "$($getWinRM.Name) has been started." -ForegroundColor Cyan
        }

        # Connect to 'Exchange Online'
        $connectEXO = Connect-ExchangeOnline @ConnectionArgs

        # Get all properties related to the user
        Get-ExoMailbox -Identity $GNMHUsername -PropertySets All
    }

}
