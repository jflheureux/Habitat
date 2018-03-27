# Installation
Write-Host "Calling package installer..."
$url = "$env:appveyor_deployment_url/InstallPackage.aspx"
$result = Invoke-WebRequest -Uri $url -TimeoutSec 600 -OutFile ".\InstallPackage-Response.log" -PassThru -UseBasicParsing
if($result.StatusCode -ne 200) {
    Write-Host "StatusCode: $($result.StatusCode)"
    throw "Package install failed."
}
Write-Host "Package install successful."

# Publishing
Write-Host "Calling publisher..."
$url = "$env:appveyor_deployment_url/Publish.aspx"
$result = Invoke-WebRequest -Uri $url -TimeoutSec 600 -OutFile ".\Publish-Response.log" -PassThru -UseBasicParsing
if($result.StatusCode -ne 200) {
    Write-Host "StatusCode: $($result.StatusCode)"
    throw "Publish failed."
}
Write-Host "Publish successful."

# Cleanup
#Write-Host "Removing package files..."
#Remove-Item .\Habitat.update -Force
#Remove-Item ".\InstallPackage.aspx"
#Remove-Item ".\Publish.aspx"
#Write-Host "Removal successful."