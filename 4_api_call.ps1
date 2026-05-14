# ============================================
# STEP 4: Full API Call
# Run AFTER TLS handshake succeeds (step 3)
# Usage: .\4_api_call.ps1
# ============================================

Write-Host "====== MAKING API CALL ======" -ForegroundColor Cyan

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2(
    (Resolve-Path "client.pfx").Path, "",
    [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::MachineKeySet
)

$url = "https://api-extern-mtls-uat.us.kpmg.com/kpmg-nexus-std-gmsimmi-sapi-proxy-uat/gms-immigration/api/v1/case-document?source_system_client_id=f1acadcc-648d-4737-85f8-d3391c7743c0&case_document_id=2046"

Write-Host "`nEndpoint: $url" -ForegroundColor Yellow
Write-Host "Method:   GET`n" -ForegroundColor Yellow

try {
    $request = [Net.HttpWebRequest]::Create($url)
    $request.Method = "GET"
    $request.ClientCertificates.Add($cert) | Out-Null
    $request.Headers.Add("Client_Id", "f8b45a8316ef4d179eee4033d2515a69")
    $request.Headers.Add("client_secret", "FD83fEf1E8234347AaA5EdBA48cfEdba")
    $request.Headers.Add("SourceSystemVendorId", "BDB9269B-3AE0-4A2D-8BA9-B1B047277CCF")

    $response = $request.GetResponse()
    $statusCode = [int]$response.StatusCode

    Write-Host "STATUS: $statusCode $($response.StatusDescription)" -ForegroundColor Green
    Write-Host "Content-Type: $($response.ContentType)`n"

    $reader = New-Object IO.StreamReader($response.GetResponseStream())
    $body = $reader.ReadToEnd()
    $reader.Close()
    $response.Close()

    Write-Host "====== RESPONSE BODY ======" -ForegroundColor Cyan
    Write-Host $body

} catch [System.Net.WebException] {
    $statusCode = [int]$_.Exception.Response.StatusCode
    Write-Host "HTTP ERROR: $statusCode" -ForegroundColor Red

    if ($_.Exception.Response) {
        $reader = New-Object IO.StreamReader($_.Exception.Response.GetResponseStream())
        $errorBody = $reader.ReadToEnd()
        $reader.Close()
        Write-Host $errorBody
    }
} catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.InnerException) {
        Write-Host "INNER: $($_.Exception.InnerException.Message)" -ForegroundColor Red
    }
}

Read-Host "`nPress Enter to close"
