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

function DotNetVersionInstalledMinimum($major = 2, $minor = 0, $release = 0, $build = 0) {
    $dotNetMaximumVersion = ((Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
    Get-ItemProperty -name Version -EA 0 |
    Where { $_.PSChildName -match '^(?!S)\p{L}'} |
    Select PSChildName, Version).Version | measure -Maximum).Maximum.Split("{.}")

    $dotNetMajor = $dotNetMaximumVersion[0]
    $dotNetMinor = $dotNetMaximumVersion[1]
    $dotNetReleaseKey = $dotNetMaximumVersion[2]

    $thisSpecResult = @{
        Name = $MyInvocation.MyCommand;
        Info = "$major.$minor.$release.$build";
    }

    if($major -eq 4 -and $minor -ge 5 -and $dotNetMajor -eq 4 -and $dotNetMinor -le 5) {
        #Forgive Me
        if($dotNetReleaseKey -ge 393295 -and $minor -ge 6) {
            $thisSpecResult.Result = $true
        } elif($minor -ge 5){
            if($dotNetReleaseKey -ge 379893 -and $release -ge 2) {
                $thisSpecResult.Result = $true
            } elif($dotNetReleaseKey -ge 378675 -and $release -ge 1) {
                $thisSpecResult.Result = $true
            } elif($dotNetReleaseKey -ge 378389 -and $release -ge 0) {
                $thisSpecResult.Result = $true
            }
        }
    }
    else {
        $thisSpecResult.Result = $dotNetMajor -gt $major `
            -or ($dotNetMajor -eq $major -and $dotNetMinor -gt $minor) `
            -or ($dotNetMajor -eq $major -and $dotNetMinor -eq $minor -and $dotNetRelease -gt $release)
    }

    $thisSpecResult
}