Function Get-SFTPFile{
    [CmdletBinding()]

    PARAM(
        [Parameter(ValueFromPipeline=$True,Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [HashTable]$Download,

        [Parameter(Mandatory=$True)] 
        [ValidateNotNullOrEmpty()] 
        [String]$HostName,

        [Parameter(Mandatory=$True)] 
        [ValidateNotNullOrEmpty()] 
        [String]$UserName,

        [Parameter(Mandatory=$True)] 
        [ValidateNotNullOrEmpty()] 
        [String]$Password,

        [Parameter(Mandatory=$True)] 
        [ValidateNotNullOrEmpty()] 
        [String]$SshHostKeyFingerprint,

        [Parameter(Mandatory=$True)] 
        [ValidateNotNullOrEmpty()] 
        [String]$RemotePath,

        [Parameter(Mandatory=$True)] 
        [ValidateNotNullOrEmpty()]
        [String]$LocalPath
    )

    Begin{
        
        $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
                HostName = $HostName
                UserName = $UserName
                Password = $Password
                Protocol = [WinSCP.Protocol]::Sftp
                SshHostKeyFingerprint = $SshHostKeyFingerprint
        }
        
        $session = New-Object WinSCP.Session
        $session.add_FileTransferProgress({Show-TransferProgress ($_)})
        $session.Open($sessionOptions)

        $transferOptions = New-Object WinSCP.TransferOptions
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
    }

    Process{
                
         Foreach($file in $Download.'outMatches'){
                $outFile = $RemotePath + "/" + $file
                $transferResult = $session.GetFiles($outFile,$LocalPath, $False, $transferOptions) 
                $transferResult.Check()
            }
			
    }


    End{
        $session.Dispose()
    }

}

Function Show-TransferProgress
{
    [CmdletBinding()]

    PARAM(
    [Parameter(Mandatory)] 
    [ValidateNotNullOrEmpty()]
    $File
    )
 
    #New line for every new file
    If(($script:lastFileName -ne $Null) -and ($script:lastFileName -ne $File.FileName))
    {
        Write-Host
    }
 
    # Print transfer progress
    Write-Verbose ("`r{0} ({1:P0})" -f $File.FileName, $File.FileProgress)
    Write-Progress -Activity $File.FileName -PercentComplete $File.FileProgress
 
    # Remember a name of the last file reported
    $script:lastFileName = $File.FileName
}
