@echo off
echo ========================================= > %TEMP%\boom.txt
echo PENTEST VDI BREAKOUT SUCCESSFUL >> %TEMP%\boom.txt
echo ========================================= >> %TEMP%\boom.txt
echo. >> %TEMP%\boom.txt
echo USERNAME: >> %TEMP%\boom.txt
whoami >> %TEMP%\boom.txt
echo. >> %TEMP%\boom.txt
echo RUNNING PROCESSES: >> %TEMP%\boom.txt
tasklist >> %TEMP%\boom.txt
start notepad %TEMP%\boom.txt
