<h1 align="center">Hi 👋, I'm Andrzej Berndt</h1>
<h3 align="center">A passionate Microsoft Technologies and IT Administrator from Poland.</h3>

- 🌱 I’m currently learning **Azure Cloud Administration (AZ-104 Microsoft Certification)**

- 👨‍💻 All of my projects are available at [https://github.com/ABurnt/PowerShell](https://github.com/ABurnt/PowerShell)

- 📝 I wrote a few posts on [https://www.linkedin.com/in/andrzej-berndt/recent-activity/shares/](https://www.linkedin.com/in/andrzej-berndt/recent-activity/shares/)

- 💬 Let's talk about **Azure, Powershell, Microsoft 365, Windows Server.**

- 📫 How to reach me **andrzejberndt@onet.pl**

<h3 align="left">Connect with me:</h3>
<p align="left">
<a href="https://www.linkedin.com/in/andrzej-berndt/" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="https://www.linkedin.com/feed/" height="30" width="40" /></a>
</p>

<h3 align="left">Languages and Tools:</h3>
<p align="left"> <a href="https://azure.microsoft.com/en-in/" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/microsoft_azure/microsoft_azure-icon.svg" alt="azure" width="40" height="40"/> </a> </p>
<hr>
<h4 align="left">Scripts description:</h4>


# ChangeUPNsMS365

### The script is used to replace the UPN (User Principal Name) attribute of the indicated Microsoft 365 users. Put the users.txt text file including list of users you want to update in the same location as this script. The script requires a powershell module named MSOnline. However, if you don't have it - the script will install it for you!

If you want to check yourself whether you have the MSOnline module installed, execute the following command:

```
Get-InstalledModule -Name MSOnline
```

If you want to install MSOnline module manually, execute the following command:

```
Install-Module -Name MSOnline -Confirm
```

You can generate a list of users from Microsoft 365 by using these commands:

```
Connect-MsolService
```
```
(Get-MsolUser -All | Sort UserPrincipalName | Select UserPrincipalName).UserPrincipalName | Out-File "users.txt"
```

If you want to get data from local Active Directory (e.g. hybrid infrastructure), use the command below:

```
(Get-ADUser -Filter {Enabled -eq $true} -Properties UserPrincipalName | Sort UserPrincipalName | Select UserPrincipalName).UserPrincipalName | Out-File "users.txt"
```

<hr>

# DiskSpaceChecker

###The script is used to monitor disks usage on workstations in your Active Directory domain. Powershell remoting is required to be enabled in your environment for the program to work properly. This script sends email notifications, so you need to have a SMTP Relay configured.

Before you run the script - edit and insert information about your smtp relay connection in commented sections. You can also change OU location of your domain computers.

The script will be ready for use once you've completed these steps. After that, you can place the script in the task scheduler, e.g. once a day and invoke it with the command:

```
powershell -ep bypass -f "[path to the script]"
```

