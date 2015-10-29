Import-Module WebAdministration;
function IsAnonymousAuthenticationEnabled($sitePath) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $sitePath
        Result = (Get-WebConfigurationProperty -filter /system.WebServer/security/authentication/anonymousAuthentication -name enabled -PSPath $sitePath).value
    }
}

function IsWindowsAuthenticationEnabled($sitePath) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $sitePath
        Result = (Get-WebConfigurationProperty -filter /system.WebServer/security/authentication/windowsAuthentication -name enabled -PSPath $sitePath).value
    }
}

function IsWindowsOptionalFeatureInstalled($feature) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $feature
        Result = (Get-WindowsOptionalFeature -Online -FeatureName $feature).State -eq "Enabled"
    }
}

function IsWindowsAuthenticationOverrideAllowed($sitePath) {
	@{
		Name = $MyInvocation.MyCommand;
		Info = $sitePath
		Result = (Get-WebConfiguration -PsPath $sitePath -Filter /system.webServer/security/authentication/windowsAuthentication -MetaData).Metadata.effectiveOverrideMode -eq "Allow"
	}
}

function IsAnonymousAuthenticationOverrideAllowed($sitePath) {
	@{
		Name = $MyInvocation.MyCommand;
		Info = $sitePath
		Result = (Get-WebConfiguration -PsPath $sitePath -Filter /system.webServer/security/authentication/anonymousAuthentication -MetaData).Metadata.effectiveOverrideMode -eq "Allow"
	}
}