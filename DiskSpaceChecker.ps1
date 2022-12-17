#DiskSpaceChecker
#Author: Andrzej Berndt

#Check disk usage on computers in your domain. 
#Script requires powershell remoting to be enabled. 

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$logpath = "C:\Script\DiskSpaceChecker\Logs" #Path for script logs
$Session_option = New-PSSessionOption -NoMachineProfile #Do not create profile on target computer when connection established
Start-Transcript -OutputDirectory $logpath -NoClobber

function SendAnEmail{
    [CmdletBinding()]

    Param (

        [Parameter(Mandatory=$true, Position=0)]
        [System.String] $PChost,
        [Parameter(Mandatory=$true, Position=1)]
        [System.Array] $list_of_disks,
        [Parameter(Mandatory=$true, Position=2)]
        [System.Array] $list_of_usages,
        [Parameter(Mandatory=$true, Position=3)]
        [System.Array] $list_of_users,
        [Parameter(Mandatory=$true, Position=4)]
        [System.Array] $list_of_total_sizes
        

    )

    Process {
    
        $smtphost = "" #<-- SMTP Relay IP Address
        $from = "" #<-- Source Mail 
        $email1 = "" #<-- Destination Mail
        $timeout = "60"
        $subject = "" #<-- Email Title 

        if (($list_of_users).Length -gt 1){
                
            $list_of_users = ($list_of_users -join ", ")

        }

        $body = "The percentage of the partition on the remote computer that is occupied: <b> $PChost </b> <br />
        Active remote users: <b> $list_of_users </b>"
        for(($i = 0); $i -lt ($list_of_disks).Length; $i++){

            $body += "<br /> Partition $($list_of_disks[$i]): <b> $($list_of_usages[$i]) % </b> - total size: <b> $($list_of_total_sizes[$i]) GB</b>"

        }

        $body += "<br />Take an action on the user's computer to free up space."
        $smtp= New-Object System.Net.Mail.SmtpClient $smtphost 
        $msg = New-Object System.Net.Mail.MailMessage 
        $msg.To.Add($email1)
        $msg.from = $from
        $msg.subject = $subject
        $msg.body = $body 
        $msg.isBodyhtml = $true 
        $smtp.send($msg)
 
    }
}

if ((Get-Module -Name ActiveDirectory).Count -eq 0){ #Verify if module is installed.
    Import-Module -Name ActiveDirectory #Import the module if not installed.
}

$hosts = (Get-ADComputer -SearchBase "OU=Computers,DC=DOMAIN,DC=LOCAL" -Filter 'operatingsystem -notlike "*server*" -and enabled -eq "true"' -Properties *).DNSHostName #Check computers with specific attributes (only Client OS and enable status) and OU location. <-- insert your OU path including computer objects

foreach ($PChost in $hosts){
    
    if ($conn = Test-Connection -BufferSize 32 -Count 1 -ComputerName $PChost -Quiet){ #Verify if computer is responding

        $limit = $false
        $get_info = Invoke-Command -ComputerName $PChost {Get-Volume | Where-Object {($_.DriveType -eq "Fixed") -and ($_.DriveLetter).Length -gt 0}} -ErrorAction Continue -SessionOption $Session_option #Consider only drives with assigned letters and not removable media
        $list_of_disks = @()
        $list_of_usages = @()
        $list_of_total_sizes = @()

        foreach ($disk in $get_info){
        
               $size_used = $disk.Size - $disk.SizeRemaining
               $drive_letter = $disk.DriveLetter
               $disk_total_size = [math]::round($disk.Size /1GB, 2)
               $disk_usage = [Math]::Floor(($size_used*100)/$disk.Size)  
               if ($disk_usage -ge 95){

                    $limit = $true
                    $list_of_disks += $drive_letter
                    $list_of_usages += $disk_usage
                    $list_of_total_sizes += $disk_total_size

               }

        }

        if ($limit -eq $true){

            $get_user = Invoke-Command -ComputerName $PChost {quser} -ErrorAction Continue -SessionOption $Session_option
            $get_user2 = $get_user | ForEach-Object -Process { (($_ ).Substring(0,($_ -replace '\s{2}',',').IndexOf(","))).Trim()}
            $list_of_users = $get_user2[1..$get_user.Length]
            SendAnEmail -PChost $PChost -list_of_disks $list_of_disks -list_of_usages $list_of_usages -list_of_users $list_of_users -list_of_total_sizes $list_of_total_sizes #Send an email if disk usage is greater equal 95%

        }

    }

}

Stop-Transcript


