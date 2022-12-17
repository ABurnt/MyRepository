#Change MS365 UPN's users
#Author: Andrzej Berndt

#Create a file named 'mails.txt' containing emails of users whose UPN you want to change in MS365.
#Put the file in the same location as this script.

Clear-Host
$checkModule = Get-InstalledModule -Name "MSOnline" -AllVersions -ErrorAction SilentlyContinue #Check if module is installed

if (-not $checkModule){

    Write-Host "Module MSOnline not found." -ForegroundColor Red
    Install-Module -Name MSOnline -Confirm #Install module if not detected

}

if ($checkModule){

    Connect-msolservice #Connect to MS365
    $accountsToChange = Get-Content "$PSScriptRoot\mails.txt" #Load user accounts from txt file

    foreach ($account in $accountsToChange){

            $pos = $account.IndexOf("@")
            $user = $account.Substring(0,$pos)
            Write-Host "Changing UPN for account:  $account" -ForegroundColor Yellow
            Set-MsolUserPrincipalName -NewUserPrincipalName $user@domain.com -UserPrincipalName $account #Change UPN for specific users <--- enter your target domain in place of '@domain.com'

        }
            $end = Read-Host -Prompt "Done."
    
}



