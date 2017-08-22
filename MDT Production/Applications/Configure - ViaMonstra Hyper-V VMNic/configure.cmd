@echo off
cls
Echo Using 1 is %1
Echo Using 2 is %2
Pause
powershell.exe -ExecutionPolicy Unrestricted -file NewExternalSwitch.ps1 %1 %2
