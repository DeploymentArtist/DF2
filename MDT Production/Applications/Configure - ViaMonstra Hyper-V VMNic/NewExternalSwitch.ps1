Import-Module 'C:\Program Files\modules\HyperV\HyperV.psd1'

$VMSwitchName = $args[0]
$VMNICMac = $args[1]

#$VMSwitchName = "External"
#$VMNICMac = "D8:D3:85:B3:70:30"
$VMNICName = Get-WmiObject Win32_NetworkAdapter -Filter "Macaddress='$VMNICMac'"

Write $VMSwitchName
Write $VMNICMac
write $VMNICName.Name

New-VMExternalSwitch -VirtualSwitchName $VMSwitchName -ExternalEthernet $VMNICName.name -Ports 1024 -Force
Remove-VMSwitchNIC -Name $VMSwitchName -Force

