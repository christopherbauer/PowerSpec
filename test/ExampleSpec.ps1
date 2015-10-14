clear-host

Write-Host "Load PowerSpec lib"
. "..\PowerSpec.ps1"

addSpec(IsPowershellMinimum 3)
addSpec(IsPortListening 80)
addSpec(IsInstalled "Microsoft SQL Server 2012 (64 Bit)")
addSpec(IsServiceInstalled "SQLSERVERAGENT")
addSpec(IsServiceRunning "SQLSERVERAGENT")
addSpec(DirectoryExists "C:\Temp")
addSpec(FileExists "C:\Temp\File.txt")
addSpec(IsAnonymousAuthenticationEnabled "IIS:/Sites/Default Web Site")
addSpec(IsWindowsAuthenticationEnabled "IIS:/Sites/Default Web Site")
addSpec(IsWindowsOptionalFeatureInstalled "IIS-BasicAuthentication")
addSpec(DotNetVersionInstalledMinimum 4 5 0)

checkSpec