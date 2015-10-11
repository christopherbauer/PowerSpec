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

function IsPortListening($port) {
    @{ 
        Name = $MyInvocation.MyCommand;
        Info = $port;
        Result = (Get-NetTCPConnection -State Listen | Where-Object { $_.LocalPort -eq $port } | measure).Count -eq 1
    }
}

function IsServiceRunning($serviceName) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $serviceName;
        Result = (Get-Service -name $serviceName | measure).Count -eq 1
    }
}

function IsInstalled($applicationName) {
    @{
        Name = $MyInvocation.MyCommand;
        Info = $applicationName;
        Result = (gp HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object -Property DisplayName -contains $applicationName | measure).Count -eq 1
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