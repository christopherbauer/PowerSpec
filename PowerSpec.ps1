$spec = @{
    rules = @();
}

function addSpec($rule) {
    $spec.rules += $rule
}


function Describe() {
    
    Process {
        if($_.Result -eq $True){
            $color = "Green"
        } else {
            $color = "Red"
        }
        Write-Host "$($_.Name) $($_.Info) $($_.Result)" -ForegroundColor $color
    }
}


function checkSpec() {
    $results = $spec.rules
    $results | Describe
    if(($results | Where-Object -Property Result -eq $false | measure).Count -gt 0) {
        Write-Host 'Failed' -ForegroundColor Red
        Exit 0
    } else {
        Write-Host 'Success' -ForegroundColor Green
        Exit 1
    }
}

function DirectoryExists($path) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $path
        Result = Test-Path $path
    }
}

function FileExists($pathToFile) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $pathToFile
        Result = Test-Path $pathToFile
    }
}
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
function IsPortListening($port) {
    @{ 
        Name = $MyInvocation.MyCommand;
        Info = $port;
        Result = (Get-NetTCPConnection -State Listen | Where-Object { $_.LocalPort -eq $port } | measure).Count -eq 1
    }
}

function IsServiceInstalled($serviceName) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $serviceName;
        Result = (Get-Service -name $serviceName -ErrorAction SilentlyContinue | measure).Count -ge 1
    }
}

function IsServiceRunning($serviceName) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $serviceName;
        Result = (Get-Service -name $serviceName -ErrorAction SilentlyContinue).Status -eq "Running"
    }
}

function IsInstalled($applicationName) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $applicationName;
        Result = (gp HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object -Property DisplayName -contains $applicationName | measure).Count -eq 1
    } 
}
function IsPowershellMininum($major, $minor = 0, $build = 0, $revision = 0) {
    $version = $PSVersionTable.PSVersion
    @{
        Name = $MyInvocation.MyCommand
        Info = "$major.$minor.$build.$revision"
        Result = $version.Major -gt $major `
            -or ($version.Major -eq $major -and $version.Minor -gt $minor) `
            -or ($version.Major -eq $major -and $version.Minor -eq $minor -and $version.Build -gt $build) `
            -or ($version.Major -eq $major -and $version.Minor -eq $minor -and $version.Build -eq $build -and $version.Revision -ge $revision)
    }
}
