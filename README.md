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

The script is used to replace the UPN (User Principal Name) attribute of the indicated Microsoft 365 users. The script requires a Powershell module named MSOnline. However, if you don't have it - the script will install it for you!

If you want to check yourself whether you have the MSOnline module installed, execute the following command:

```
Get-InstalledModule -Name MSOnline
```

If you want to install MSOnline module manually, execute the following command:

```
Install-Module -Name MSOnline -Confirm
```

```
Connect-MsolService
```

```
Get-MsolUser -All | Sort UserPrincipalName | Select UserPrincipalName > "mails.txt"
```

```
Get-ADUser -Filter {Enabled -eq $true} -Properties UserPrincipalName | Sort UserPrincipalName | Select UserPrincipalName > "mails.txt"
```
