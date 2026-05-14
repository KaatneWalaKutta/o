# ============================================
# STEP 2: Create PFX bundle
# Run from the folder where cert.pem and private 1.pem are located
# Usage: .\2_create_pfx.ps1
# ============================================

Write-Host "Creating client.pfx from cert.pem and private 1.pem..." -ForegroundColor Cyan
Write-Host "When prompted for Export Password, just press Enter twice for no password.`n" -ForegroundColor Yellow

& openssl pkcs12 -export -out client.pfx -inkey "private 1.pem" -in cert.pem

if (Test-Path "client.pfx") {
    Write-Host "`nclient.pfx created successfully!" -ForegroundColor Green
    Write-Host "File size:" (Get-Item "client.pfx").Length "bytes"
} else {
    Write-Host "`nFailed to create client.pfx" -ForegroundColor Red
}

Read-Host "`nPress Enter to close"
