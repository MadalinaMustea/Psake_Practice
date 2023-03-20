Task Default -Depends Run

Task Run{
    Invoke-Psake .\dotnetcore-httprequest\BuildAspNetCore.ps1  -parameters @{ Version = "1.0.1" }
}