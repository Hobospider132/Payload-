@echo off 

set task=flicker.cmd
set delay=1


net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 
    exit /b
)
cd /d %1


:checkprocess

:: check to see if task is running, if not wait and check again

tasklist /fi "ImageName eq %task%" /fo csv 2>NUL | find /I "%task%">NUL

if "%ERRORLEVEL%"=="0" goto run
else goto wait

:run
cmd /c start %task%

:wait
timeout /t %delay% /nobreak >NUL
goto checkprocess

