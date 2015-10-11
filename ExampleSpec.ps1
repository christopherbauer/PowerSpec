$spec.rules = @()

. "C:\Users\Christopher\Desktop\PowerSpec.ps1"

addSpec(IsPortListening(80))
addSpec(IsPortListening(2000))
addSpec(IsServiceRunning("Bonjour Service"))
addSpec(IsInstalled("iTunes"))
addSpec(DirectoryExists("C:\Temp"))
addSpec(FileExists("C:\Temp\File.txt"))

checkSpec