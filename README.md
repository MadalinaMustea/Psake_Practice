ASPNetCore application build:
  -In BuildAspNetCore.ps1 I defined the tasks for Clean,Restore,Build,Publish and CreateNugetPackage
  -Inside Param() I initialized the version of NuGet package
  -In RunBuildScript.ps1 we run the BuildAspNetCore.ps1 using Invoke-Psake and sending the version of NuGet package as parameter
          Invoke-Psake .\dotnetcore-httprequest\BuildAspNetCore.ps1  -parameters @{ Version = "1.0.1" }
