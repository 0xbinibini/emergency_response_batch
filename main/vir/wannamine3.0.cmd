@echo off
echo ------------------------------powered by onlinewan modifed/created by binbin---------------------------------
::转载自CSDN：https://blog.csdn.net/onlinewan/article/details/82791642
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
 
echo ----------------------wannamine3.0挖矿蠕虫专杀工具------------------------------
schTasks /Delete /F /TN "UPnPHostServices"
sc stop snmpstorsrv
sc delete snmpstorsrv
taskkill /IM TrustedHostex.exe /f
taskkill /IM rundll32.exe /f
 
wmic process get ProcessId,executablepath | findstr "C:\Windows\AppDiagnostics" > 1.txt
for /f "delims=" %%i in ("1.txt") do (for /f "tokens=2" %%m in (%%i) do (taskkill /PID %%m /f))
del 1.txt
 
rem del C:\Windows\system32\wmassrv.dll
rem del C:\Windows\system32\HalPluginsServices.dll
del C:\Windows\System32\snmpstorsrv.dll
rem del C:\Windows\SpeechsTracing\spoolsv.exe
del C:\Windows\System32\TrustedHostex.exe
del C:\Windows\System32\MarsTraceDiagnostics.xml
rd /s /q C:\Windows\AppDiagnostics\