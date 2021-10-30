@echo off
echo ------------------------------powered by onlinewan---------------------------------
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
 
echo ----------------------wannamine2.0挖矿蠕虫专杀工具------------------------------
sc stop wmassrv
sc delete wmassrv
taskkill /IM spoolsv.exe /f
taskkill /IM rundll32.exe /f
 
wmic process get ProcessId,executablepath | findstr "C:\Windows\SpeechsTracing" > 1.txt
for /f "delims=" %%i in ("1.txt") do (for /f "tokens=2" %%m in (%%i) do (taskkill /PID %%m /f))
del 1.txt
 
del C:\Windows\system32\wmassrv.dll
del C:\Windows\system32\HalPluginsServices.dll
del C:\Windows\System32\EnrollCertXaml.dll
del C:\Windows\SpeechsTracing\spoolsv.exe
del C:\Windows\SpeechsTracing\Microsoft\*.exe
rd /s /q C:\Windows\SpeechsTracing