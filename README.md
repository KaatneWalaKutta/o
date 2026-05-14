pentest-certs/
├── cert.pem              ← from the client
├── private 1.pem         ← from the client
├── 1_validate_cert.ps1   ← downloaded from here
├── 2_create_pfx.ps1
├── 3_test_tls.ps1
├── 4_api_call.ps1


Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass



Quick Start Summary

    Put all 6 files in one folder
    Make sure openssl version works in PowerShell
    Right-click 1_validate_cert.ps1 → Run with PowerShell
    Follow the numbered order: 1 → 2 → 3 → 4
    If step 3 (TLS handshake) fails, don't bother with step 4 — fix the cert issue first

$env:PATH += ";C:\Users\sudeepdwivedi\Desktop\MAAAANIK\OpenSSL-Win64\bin"

1_validate_cert.ps1 — checks expiry, subject, and cert-key match
2_create_pfx.ps1 — bundles cert + key into PFX for Windows
3_test_tls.ps1 — tests just the TLS handshake (catches cert issues before HTTP)
4_api_call.ps1 — makes the actual GET request

