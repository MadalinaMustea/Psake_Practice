Properties {
    $build_dir = Split-Path $psake.build_script_file
    $build_artifacts_dir = "$build_dir\..\BuildArtifacts\"
   # $code_dir = "$build_dir\..\"
}

Task Default -Depends RunHelloWorld

Task RunHelloWorld -Depends Clean, Build{
    Write-Host "Running ...." -ForegroundColor Green
    $output=Exec{"$build_dir\bin\HelloWorld.exe"}
    Write-Host $output -ForegroundColor Blue
}

Task Build -Depends Clean {
    Write-Host "Building ...." -ForegroundColor Green
    Exec { msbuild "$build_dir\HelloWorld.csproj" /t:Build /p:Configuration=Release /v:quiet /p:OutDir=$build_artifacts_dir }
}

Task Clean {
    Write-Host "Creating BuildArtifacts directory" -ForegroundColor Green
    
    if (Test-Path $build_artifacts_dir)
    {
        rd $build_artifacts_dir -rec -force | out-null
    }

    mkdir $build_artifacts_dir | out-null

    Write-Host "Cleaning ...." -ForegroundColor Green
    Exec { msbuild "$build_dir\HelloWorld.csproj" /t:Clean /p:Configuration=Release /v:quiet }
}