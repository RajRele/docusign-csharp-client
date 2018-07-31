try{
Write-Host "Cleaning!"
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /t:clean /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "Restore DocuSign.eSign"
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /t:restore /p:TargetFramework=net45 /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "Building DocuSign.eSign for Net4.5"
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /p:TargetFramework=net45 /p:Configuration=Debug /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "Restore DocuSign.eSign for NetStandard 2.0"
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /t:restore /p:TargetFramework=netstandard2.0 /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "Building DocuSign.eSign for NetStandard2.0"
msbuild ./sdk/src/DocuSign.eSign/DocuSign.eSign.csproj /p:TargetFramework=netstandard2.0 /p:Configuration=Debug /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "Cleaning SdkTests!"
msbuild ./test/SdkTests/SdkTests.csproj /t:clean /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }
    
Write-Host "Restoring and Building SdkTests for Net4.5"
msbuild ./test/SdkTests/SdkTests.csproj /t:restore /p:TargetFramework=net45 /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }

Write-Host "ReBuilding SdkTests for Net4.5"
msbuild ./test/SdkTests/SdkTests.csproj /t:rebuild /verbosity:minimal
if ($lastExitCode -ne 0) { exit $lastExitCode }
}
catch {
    Write-Host "Something went wrong!"
    Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Red
    Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
