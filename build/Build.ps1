

$powerSpec = Get-Content .\src\Core.ps1
$rulesScripts = Get-Content .\src\Rules\*

$content = $powerSpec + $rulesScripts

$content > ".\PowerSpec.ps1"
