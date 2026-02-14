# 1. Ask for user input
$domainName = Read-Host "Enter the desired domain name (e.g., tech.local)"
$password = Read-Host "Enter the Safe Mode Administrator Password" -AsSecureString

# 2. Install the Active Directory Domain Services Role
Write-Host "Installing AD-Domain-Services Role..." -ForegroundColor Cyan
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# 3. Promote the server to a Domain Controller
# This will create a new forest with the provided name
Write-Host "Promoting server to Domain Controller... The system will reboot automatically." -ForegroundColor Yellow

Install-ADDSForest `
    -DomainName $domainName `
    -SafeModeAdministratorPassword $password `
    -InstallDns:$true `
    -Force:$true