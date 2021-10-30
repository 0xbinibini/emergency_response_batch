@echo off
echo -------------------------------powered by onlinewan-------------------------------
::转载自CSDN：https://blog.csdn.net/onlinewan/article/details/82791642
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (

echo 请求管理员权限...

goto UACPrompt

) else ( goto gotAdmin )

:UACPrompt

echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"

echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"

exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )

echo ----------------------wannacry勒索蠕虫专杀工具----------------------------
cd /d "C:/Windows/"
 
taskkill /im mssecsvc.exe /f
taskkill /im tasksche.exe /f
del mssecsvc.exe /q
del qeriuwjhrf /q
del tasksche.exe /q
 
taskkill /im mssecsvc.exe /f
taskkill /im tasksche.exe /f
del mssecsvc.exe /q
del qeriuwjhrf /q
del tasksche.exe /q