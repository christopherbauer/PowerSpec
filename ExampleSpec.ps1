clear-host

. "$PSScriptRoot\PowerSpec.ps1"
. "$PSScriptRoot\Rules\IISPSpec.ps1"
. "$PSScriptRoot\Rules\DrivePSpec.ps1"
. "$PSScriptRoot\Rules\ShellPSpec.ps1"
. "$PSScriptRoot\Rules\ServicesPSpec.ps1"

addSpec(IsPowershellMininum 3)
addSpec(IsPortListening 80)
addSpec(IsInstalled "Microsoft SQL Server 2012 (64 Bit)")
addSpec(IsServiceInstalled "SQLSERVERAGENT")
addSpec(IsServiceRunning "SQLSERVERAGENT")
addSpec(DirectoryExists "C:\Temp")
addSpec(FileExists "C:\Temp\File.txt")
addSpec(IsAnonymousAuthenticationEnabled "IIS:/Sites/Default Web Site")
addSpec(IsWindowsAuthenticationEnabled "IIS:/Sites/Default Web Site")
addSpec(IsWindowsOptionalFeatureInstalled "IIS-BasicAuthentication")

checkSpec