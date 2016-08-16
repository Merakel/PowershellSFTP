Function Find-Files{
    [CmdletBinding()]

    PARAM(
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

        [ValidateNotNullOrEmpty()]
        [String]$Pattern = "*"
    )

    Begin{
        [HashTable]$matches = @{}
        [System.Collections.ArrayList]$outMatches = @()
        
                
        $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
                HostName = $HostName
                UserName = $UserName
                Password = $Password
                Protocol = [WinSCP.Protocol]::Sftp
                SshHostKeyFingerprint = $SshHostKeyFingerprint
            }
        
        $session = New-Object WinSCP.Session
        $session.Open($sessionOptions)
    }

    Process{
        $outFiles = $session.ListDirectory($RemotePath).Files | Where-Object {$_.FileType -ne "d"}    

        Foreach($file in $outFiles){
            $add = Select-String -InputObject $file.Name -Pattern $Pattern -AllMatches
            If($add -ne $Null){
                $outMatches.add($add) | Out-Null
            }
        }


        $matches.add("matches",$outMatches)
    }

    End{
        $session.Dispose()

        Return $matches
    }
}