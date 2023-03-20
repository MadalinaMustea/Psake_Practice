Task Default -Depends Run

Task Run{
    Invoke-Psake .\BuildAspNetCore.ps1  -parameters @{ Version = "1.0.1" }
}