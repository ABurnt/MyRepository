<h1 align="center">Hi 👋, I'm Andrzej</h1>
<h3 align="center">SecOps and IT Administrator from Poland.</h3>

- 👨‍💻 My projects and scripts are available at [https://github.com/ABurnt/MyRepository](https://github.com/ABurnt/MyRepository)

- 📝 LinkedIn activity [https://www.linkedin.com/in/andrzej-berndt/recent-activity/shares/](https://www.linkedin.com/in/andrzej-berndt/recent-activity/shares/)

- 💬 Let's talk about **Security and Automation** 

- 📫 How to reach me **andrzej.berndt@outlook.com**

<h3 align="left">Connect with me:</h3>
<p align="left">
<a href="https://www.linkedin.com/in/andrzej-berndt/" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="https://www.linkedin.com/feed/" height="30" width="40" /></a>
</p>

<h3 align="left">Technologies & Skills</h3>
<p align="left">
  <a href="https://learn.microsoft.com/powershell/" target="_blank" rel="noreferrer">
    <img src="https://upload.wikimedia.org/wikipedia/commons/a/af/PowerShell_Core_6.0_icon.png" alt="PowerShell" width="40" height="40"/>
  </a>
  <a href="https://azure.microsoft.com/" target="_blank" rel="noreferrer">
    <img src="https://www.vectorlogo.zone/logos/microsoft_azure/microsoft_azure-icon.svg" alt="Azure" width="40" height="40"/>
  </a>
  <a href="https://www.microsoft.com/windows-server" target="_blank" rel="noreferrer">
    <img src="https://www.vectorlogo.zone/logos/microsoft/microsoft-icon.svg" alt="Windows" width="40" height="40"/>
  </a>
  <a href="https://www.linux.org/" target="_blank" rel="noreferrer">
    <img src="https://www.vectorlogo.zone/logos/linux/linux-icon.svg" alt="Linux" width="40" height="40"/>
  </a>
  <a href="https://www.eset.com/fi/yritys/protect-platform/" target="_blank" rel="noreferrer">
    <img src="https://upload.wikimedia.org/wikipedia/commons/6/63/ESET_antivir_7_logo.png" alt="ESET" width="40" height="40"/>
  </a>
</p>

<ul>
  <li>AV/EDR: administration, policy management, incident analysis</li>
  <li>SIEM: KQL (Microsoft Sentinel) & EQL (Elastic/Kibana) — Machine Learning jobs, alerts, exceptions</li>
  <li>PowerShell: automation, hardening, deployment scripting</li>
  <li>Azure hardening: reporting, monitoring, targeted modifications</li>
  <li>Windows & Linux system administration</li>
</ul>

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

### The script is used to monitor disks usage on workstations in your Active Directory domain. Powershell remoting is required to be enabled in your environment for the program to work properly. This script sends email notifications, so you need to have a SMTP Relay configured.

Before you run the script - edit and insert information about your smtp relay connection in commented sections. You can also change OU location of your domain computers.

The script will be ready for use once you've completed these steps. After that, you can place the script in the task scheduler, e.g. once a day and invoke it with the command:

```
powershell -ep bypass -f "[path to the script]"
```

