# 1. Gather Network Information
$ip = Read-Host "Enter the Static IP Address"
$mask = Read-Host "Enter the Subnet Mask Prefix (e.g., 24 for 255.255.255.0)"
$gateway = Read-Host "Enter the Default Gateway"
$dns1 = Read-Host "Enter Primary DNS"
$dns2 = Read-Host "Enter Secondary DNS"

# 2. Gather System Information
$newName = Read-Host "Enter the new Computer Name"

# 3. Identify the active Network Adapter
$adapter = Get-NetAdapter | Where-Object Status -eq "Up" | Select-Object -First 1

# 4. Configure IP and Gateway
Write-Host "Configuring IP address on $($adapter.Name)..." -ForegroundColor Cyan
New-NetIPAddress -InterfaceAlias $adapter.Name -IPAddress $ip -PrefixLength $mask -DefaultGateway $gateway

# 5. Configure DNS
Write-Host "Setting DNS servers..." -ForegroundColor Cyan
Set-DnsClientServerAddress -InterfaceAlias $adapter.Name -ServerAddresses ($dns1, $dns2)

# 6. Rename and Restart
Write-Host "Renaming computer to $newName and restarting..." -ForegroundColor Yellow
Rename-Computer -NewName $newName -Force -Restart