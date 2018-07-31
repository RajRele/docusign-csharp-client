try
{
Write-Host "Cleaning DocuSign.eSign!" -ForegroundColor Yellow
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /t:clean /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "`nRestore DocuSign.eSign" -ForegroundColor Yellow
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /t:restore /p:TargetFramework=net45 /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "`nBuilding DocuSign.eSign for Net45" -ForegroundColor Yellow
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /p:TargetFramework=net45 /p:Configuration=Debug /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "Restore DocuSign.eSign for NetStandard2.0" -ForegroundColor Yellow
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /t:restore /p:TargetFramework=netstandard2.0 /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "Building DocuSign.eSign for NetStandard2.0" -ForegroundColor Yellow
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /p:TargetFramework=netstandard2.0 /p:Configuration=Debug /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "Cleaning SdkTests!" -ForegroundColor Yellow
msbuild ./test/SdkTests/SdkTests.csproj /t:clean /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "Re-Building SdkTests for Net45" -ForegroundColor Yellow
nuget install ./test/SdkTests/packages.config -OutputDirectory ./test/packages
msbuild ./test/SdkTests/SdkTests.csproj /t:rebuild /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }
}
catch {
    Write-Host "Something went wrong!"
    Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Red
    Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
