# PowershellSFTP

This module uses the WinSCP assembly to connect to and download to an SFTP site. Typical use it to identify files with with `Find-Files` function and pipe them to `Get-SFTPFile`.

# Find-Files

This function will find files based on a pattern provided, or if left blank all files in a location, excluding directories. Returns the values found in a hashtable for piping to `Get-SFTPFile`. The following parameters are available:
* HostName - The hostname of the SFTP site you want to connect to.
* Username - The username you will use to log in with.
* Password - The password to your usename.
* SshHostKeyFingerprint - The SSH Fingerprint of the SFTP site.
* RemotePath - Location of the files you want to find on the SFTP site.
* Pattern - Regex pattern to search for files based on. If nothing is provided returns everything in directory.

# Get-SFTPFile

This function will download files that are passed to it through the pipeline, or provided in the download parameter. The paramters are as follows:

* Download - Files that you want downloaded. Accepts Value from pipeline.
* HostName - The hostname of the SFTP site you want to connect to.
* Username - The username you will use to log in with.
* Password - The password to your usename.
* SshHostKeyFingerprint - The SSH Fingerprint of the SFTP site.
* RemotePath - Location of the files you want to find on the SFTP site.
* LocalPath - Location where you want the downloaded files stored.

# Potential Features to add:

* Recursively downloading files.
* Downloading directories rather than individual files.
