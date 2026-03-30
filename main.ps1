Write-Host "🔥 Welcome to Lucky Tool" -ForegroundColor Cyan

function Show-Menu {
    Clear-Host
    Write-Host "1. Clean Temp Files"
    Write-Host "2. Check System Info"
    Write-Host "3. Exit"
    
    $choice = Read-Host "Select option"

    switch ($choice) {
        1 { Clean-Temp }
        2 { System-Info }
        3 { exit }
        default { Write-Host "Invalid"; pause }
    }

    Show-Menu
}

function Clean-Temp {
    Write-Host "Cleaning temp files..."
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Done!"
    pause
}

function System-Info {
    systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
    pause
}

Show-Menu