# Get credentials from arguments
param ([string] $fqdn, [string] $user, [string] $pass, [string] $object)

# Build credentials
$remotepass= ConvertTo-SecureString -String $pass -AsPlainText -Force
$UserCredential= new-object -typename System.Management.Automation.PSCredential -argumentlist $user,$remotepass

$Session= New-PSSession -ComputerName $fqdn -Authentication Kerberos -Credential $UserCredential

#Create output which logicmonitor understands for instance names
invoke-command -session $Session -scriptblock {C:\java\jboss-5.1.0.GA\bin\twiddle get $object} | write-output

# Remove the PowerShell session
Remove-PSSession $Session
