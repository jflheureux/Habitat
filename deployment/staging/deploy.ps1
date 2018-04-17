function Invoke-SitecorePage($Url, $TaskName) {
    Write-Host "Calling $TaskName..."
    $result = Invoke-WebRequest -Uri $Url -TimeoutSec 600 -OutFile ".\$TaskName-Response.log" -PassThru -UseBasicParsing
    if($result.StatusCode -ne 200) {
        Write-Host "StatusCode: $($result.StatusCode)"
        throw "$TaskName failed."
    }
    Write-Host "$TaskName successful."
}

Invoke-SitecorePage -Url "$env:appveyor_deployment_url/InstallPackage.aspx" -TaskName "InstallPackage"
Invoke-SitecorePage -Url "$env:appveyor_deployment_url/Publish.aspx" -TaskName "Publish"
Invoke-SitecorePage -Url $env:appveyor_instance_url -TaskName "Warmup"

Write-Host "Removing deployment files..."
Remove-Item $env:APPLICATION_PATH\Habitat.update
Remove-Item $env:APPLICATION_PATH\InstallPackage.aspx
Remove-Item $env:APPLICATION_PATH\Publish.aspx
Remove-Item $env:APPLICATION_PATH\deploy.ps1
Write-Host "Removal successful."