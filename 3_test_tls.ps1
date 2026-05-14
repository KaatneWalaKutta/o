# ============================================
# STEP 3: Test TLS Handshake
# Run AFTER creating client.pfx (step 2)
# Usage: .\3_test_tls.ps1
# ============================================

Write-Host "====== TESTING TLS HANDSHAKE ======" -ForegroundColor Cyan

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

Write-Host "`nLoading client.pfx..." -ForegroundColor Yellow
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2(
    (Resolve-Path "client.pfx").Path, "",
    [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::MachineKeySet
)

Write-Host "  Subject:         $($cert.Subject)"
Write-Host "  Issuer:          $($cert.Issuer)"
Write-Host "  Has Private Key: $($cert.HasPrivateKey)"
Write-Host "  Expires:         $($cert.NotAfter)"

Write-Host "`nConnecting to api-extern-mtls-uat.us.kpmg.com:443..." -ForegroundColor Yellow
$tcp = New-Object Net.Sockets.TcpClient

try {
    $tcp.Connect("api-extern-mtls-uat.us.kpmg.com", 443)
    Write-Host "  TCP connected" -ForegroundColor Green

    $ssl = New-Object Net.Security.SslStream($tcp.GetStream(), $false, {$true})
    $certs = New-Object System.Security.Cryptography.X509Certificates.X509CertificateCollection
    $certs.Add($cert) | Out-Null

    Write-Host "  Starting TLS handshake..." -ForegroundColor Yellow
    $ssl.AuthenticateAsClient("api-extern-mtls-uat.us.kpmg.com", $certs, [System.Security.Authentication.SslProtocols]::Tls12, $false)

    Write-Host "`n  TLS HANDSHAKE SUCCEEDED!" -ForegroundColor Green
    Write-Host "  Protocol: $($ssl.SslProtocol)"
    Write-Host "  Cipher:   $($ssl.CipherAlgorithm)"
    Write-Host "`n  You are good to go - proceed with Postman or Step 4." -ForegroundColor Green

    $ssl.Close()
} catch {
    Write-Host "`n  TLS HANDSHAKE FAILED" -ForegroundColor Red
    Write-Host "  Error: $($_.Exception.Message)"
    if ($_.Exception.InnerException) {
        Write-Host "  Inner: $($_.Exception.InnerException.Message)"
    }
    Write-Host "`n  Check: Is the cert expired? Is the network reachable? Is the cert trusted by the server?" -ForegroundColor Yellow
} finally {
    $tcp.Close()
}

Read-Host "`nPress Enter to close"
