reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Setup /v SourcePath /t REG_SZ /d C:\Windows\Source\i386 /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Setup /v ServicePackSourcePath /t REG_SZ /d C:\R2\CMPNENTS\R2 /f
C:\R2\CMPNENTS\R2\setup2.exe /q /a /sr

