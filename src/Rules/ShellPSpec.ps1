function IsPowershellMinimum($major, $minor = 0, $build = 0, $revision = 0) {
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