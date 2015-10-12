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