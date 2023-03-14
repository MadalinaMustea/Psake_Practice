Properties {
    $build_dir = Split-Path $psake.build_script_file
    $code_dir = "$build_dir\..\dotnetcore-httprequest\"
    $build_artifacts_dir = "$build_dir\..\BuildArtifacts\"
   
}

Task Default -Depends Run

Task Run -Depends Clean, Restore, Build{
    Write-Host "Running ...." -ForegroundColor Green
    $output=Exec{"$build_dir\bin\DotNetCoreHttpRequest.exe"}
    Write-Host $output -ForegroundColor Blue
}

Task Build -Depends Restore {
    Write-Host "Building ...." -ForegroundColor Green
    Exec { msbuild "$build_dir\DotNetCoreHttpRequest.sln" /t:Build /p:Configuration=Release /v:quiet /p:OutDir=$build_artifacts_dir }
}
Task Restore -Depends Clean{
    Write-Host "Restoring ...." -ForegroundColor Green
    Exec { dotnet restore $code_dir }
    
   
}
Task Clean {
    Write-Host "Creating BuildArtifacts directory" -ForegroundColor Green
    
    if (Test-Path $build_artifacts_dir)
    {
        rd $build_artifacts_dir -rec -force | out-null
    }

    mkdir $build_artifacts_dir | out-null

    Write-Host "Cleaning ...." -ForegroundColor Green
    Exec { msbuild "$build_dir\DotNetCoreHttpRequest.sln" /t:Clean /p:Configuration=Release /v:quiet }
}