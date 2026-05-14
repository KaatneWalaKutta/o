# ============================================
# STEP 1: Validate Certificate
# Run from the folder where cert.pem and private 1.pem are located
# Usage: Right-click > Run with PowerShell
#        OR in PowerShell: .\1_validate_cert.ps1
# ============================================

Write-Host "====== CERTIFICATE DETAILS ======" -ForegroundColor Cyan

# Check dates
Write-Host "`nExpiry dates:" -ForegroundColor Yellow
& openssl x509 -in cert.pem -noout -dates

# Check subject and issuer
Write-Host "`nSubject and Issuer:" -ForegroundColor Yellow
& openssl x509 -in cert.pem -noout -subject -issuer

# Check cert-key match
Write-Host "`nCert modulus MD5:" -ForegroundColor Yellow
$certHash = & openssl x509 -in cert.pem -noout -modulus | & openssl md5
Write-Host $certHash

Write-Host "`nKey modulus MD5:" -ForegroundColor Yellow
$keyHash = & openssl rsa -in "private 1.pem" -noout -modulus 2>$null | & openssl md5
Write-Host $keyHash

if ($certHash -eq $keyHash) {
    Write-Host "`nRESULT: Cert and key MATCH" -ForegroundColor Green
} else {
    Write-Host "`nRESULT: Cert and key DO NOT MATCH - request correct pair!" -ForegroundColor Red
}

# Check if expired
$notAfter = & openssl x509 -in cert.pem -noout -enddate
Write-Host "`n$notAfter" -ForegroundColor Yellow

Write-Host "`n====== DONE ======" -ForegroundColor Cyan
Read-Host "Press Enter to close"
