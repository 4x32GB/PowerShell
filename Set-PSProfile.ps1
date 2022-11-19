<#
    .SYNOPSIS
        Checks if their is currently a PowerShell profile in the default path.

#>

process
{
    Write-Host 
    " ___  ___  ________   ___  __    ________   ________  ___       __   ________      
    |\  \|\  \|\   ___  \|\  \|\  \ |\   ___  \|\   __  \|\  \     |\  \|\   ___  \    
    \ \  \\\  \ \  \\ \  \ \  \/  /|\ \  \\ \  \ \  \|\  \ \  \    \ \  \ \  \\ \  \   
     \ \  \\\  \ \  \\ \  \ \   ___  \ \  \\ \  \ \  \\\  \ \  \  __\ \  \ \  \\ \  \  
      \ \  \\\  \ \  \\ \  \ \  \\ \  \ \  \\ \  \ \  \\\  \ \  \|\__\_\  \ \  \\ \  \ 
       \ \_______\ \__\\ \__\ \__\\ \__\ \__\\ \__\ \_______\ \____________\ \__\\ \__\
        \|_______|\|__| \|__|\|__| \|__|\|__| \|__|\|_______|\|____________|\|__| \|__|

                Professional PowerShell Scripts from a Professional Source
    ___________________________________________________________________________________
    "
    
    
    $path = @(
    "C:\Users\x22\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    )

    # Check if a PowerShell Profile Already Exists

    if((Test-Path -Path $path) -eq $false)
    {
        Write-Host 'A PowerShell Profile is required to preload modules, customizations, and fields. Do you want to install it?' -ForegroundColor Yellow
        $check = Read-Host Would you like to create a PowerShell Profile? [Y] Yes [N] No
        if($check -like "[Yy]")
        {
            for($i = 1; $i -le 100; $i++)
            {
                Write-Progress -Activity "Creating PowerShell Profile..." -Status "$i% Complete:" -PercentComplete $i 
                Start-Sleep -Milliseconds 1
            }
            New-Item -Path C:\Users\x22\Documents\PowerShell\ -ItemType File -Name Microsoft.PowerShell_profile.ps1
            Write-Host 'Profile created...' -ForegroundColor Cyan
        }
        else
        {
            Write-Host 'A PowerShell Profile is handy to have, please create one.' -ForegroundColor Red
        }
    }
    
    Read-Host 'Press ENTER to Exit...'
    # Stop-Process -Id $PID
}

