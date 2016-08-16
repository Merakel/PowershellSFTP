@{
ModuleToProcess = 'PowershellSFTP.psm1'
ModuleVersion = '1.0.0'
Author = 'Colin'
Description = 'Module to find and download files based on a pattern from an SFTP site.'
PowerShellVersion = '4.0'
#RequiredAssemblies = @('WinSCPnet.dll')
CmdletsToExport = @( 
    'Find-Files',
    'Get-SFTPFile'
)
}