$global:PDRunRoot = $PSScriptRoot

Resolve-Path $global:PDRunRoot\Functions\*.ps1 |
    ? { -not ($_.ProviderPath.Contains(".Tests.")) } |
    % { . $_.ProviderPath    }

Add-Type -Path "$global:PDRunRoot\bin\WinSCPnet.dll"

Export-ModuleMember `
    -Function `
        Find-Files, `
        Get-SFTPFile,