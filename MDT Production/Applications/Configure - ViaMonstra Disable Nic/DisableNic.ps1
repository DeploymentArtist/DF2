$NicToDisable = $args[0]
#$NicToDisable = "00:19:BB:36:1D:7E"

$VMNICName = Get-WmiObject Win32_NetworkAdapter -Filter "Macaddress='$NicToDisable'"

Write "Using $NicToDisable"
write "The MacAddress $NicToDisable is in use by $VMNICName"
Write "Turning of $VMNICName"

$VMNICName.disable()
#$VMNICName.enable()
