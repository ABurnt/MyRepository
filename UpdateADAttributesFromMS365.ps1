#Update AD On-Prem Users attributes from Microsoft 365 CSV Raport
#Author: Andrzej Berndt

#Script updates specific users attributes in AD On-Prem from CSV Raport which you can generate in Microsoft 365 Admin Center Plaftorm. 

Clear-Host

$csv = Import-Csv -Path "$PSScriptRoot\raport.csv" # <-- Select the file containing MS 365 Users CSV Raport
$AccountsToChange = Get-Content "$PSScriptRoot\accounts.txt" # <-- Select the file containing a list of users whose attributes you want to update.

foreach ($account in $AccountsToChange){ 
    $attributes=@()
    $pos = $account.IndexOf("@")
    $user = $account.Substring(0,$pos)

    $isSynced = $csv | Where-Object -Property "*User principal name*" -Like "$user*"

    if ($isSynced.dirSyncEnabled.Length -eq 0){

        # -- phone
        $mobile1 = $csv | Where-Object -Property "*User principal name*" -Like "$user*" | select "Mobile Phone*" | Format-Table -HideTableHeaders
        $mobile = Out-String -InputObject $mobile1
        $mobile = $mobile.Replace('-','').Trim()
        $mobile = $mobile.Replace(' ','')
        # --- main phone
        $main_phone1 = $csv | Where-Object -Property "*User principal name*" -Like "$user*" | select "Phone number" | Format-Table -HideTableHeaders
        $main_phone = Out-String -InputObject $main_phone1
        $main_phone = $main_phone.Replace('-','').Trim()
        $main_phone = $main_phone.Replace(' ','')
        # --- department
        $department1 = $csv | Where-Object -Property "*User principal name*" -Like "$user*" | select "Department" | Format-Table -HideTableHeaders
        $department = Out-String -InputObject $department1
        $department = $department.Trim()
        # --- title
        $title1 = $csv | Where-Object -Property "*User principal name*" -Like "$user*" | select "Title" | Format-Table -HideTableHeaders
        $title = Out-String -InputObject $title1 
        $title = $title.Trim()
        # --- update AD On-Prem user's attributes
        if ($mobile.Length -gt 1){
            Get-ADUser -Filter "userPrincipalName -like '$account'" | Set-ADUser -MobilePhone $mobile
            $attributes += $mobile
        }
        if ($main_phone.Length -gt 1){
            Get-ADUser -Filter "userPrincipalName -like '$account'" | Set-ADUser -OfficePhone $main_phone
            $attributes += $main_phone
        }
        if ($department.Length -gt 1){
            Get-ADUser -Filter "userPrincipalName -like '$account'" | Set-ADUser -Department $department
            $attributes += $department
        }
        if ($title.Length -gt 1){
            Get-ADUser -Filter "userPrincipalName -like '$account'" | Set-ADUser -Title $title
            $attributes += $title
        }
        Get-ADUser -Filter "userPrincipalName -like '$account'" | Set-ADUser -UserPrincipalName "$user@domain.eu" # <-- replace with your own domain in AD On-Prem
        Write-Host "Changing UPN for user: $user" -ForegroundColor Yellow
        Write-Host "Attributes that have changed: $attributes" -ForegroundColor Green

    }

}
$end = Read-Host -Prompt "Done"