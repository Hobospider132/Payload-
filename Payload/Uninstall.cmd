@echo off
color 0F


:elevate 

:: create a powershell instance, and restart the batch script with elevated permissions

net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 
    exit /b
)
cd /d %1

:remove

:: delete all files added to computer and remove task

rmdir "C://Users/%USERNAME%/scd"
schtasks /delete /tn Adoodoobe.exe


:end

