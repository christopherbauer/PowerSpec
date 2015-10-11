
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