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