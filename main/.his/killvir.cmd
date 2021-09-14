@echo off
setlocal enabledelayedexpansion
net session >nul 2>&1
if %errorlevel% == 0 goto loop
if %errorlevel% == 1 goto gotadmin

:gotadmin
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
pause

:loop
if defined auto goto kill
cd /d "%~dp0"
cls
title 通杀脚本调用器
rem echo %cd%
echo `: 一键关闭高危端口防止横向传播
echo 1: WannaCry专杀批
echo 2: WannaMine挖矿木马批
echo 0: 通用批处理
set /p input=[请输入您的选择]
if %input% == ` start "" 隔离-一键关闭高危端口set版-1.1
if %input% == 0 goto 0
if %input% == 1 start "" /d ".\vir\" wannacry
if %input% == 2 goto wannamine
goto loop

:wannamine
set /p input=[请输入wannamine版本]
if %input% == 0 （echo 我哪知道什么版本你自己动 && goto automine)
if %input% == 2 start "" /d ".\vir\" wannamine2.0
if %input% == 3 start "" /d ".\vir\" wannamine3.0
if %input% == 4 start "" /d ".\vir\" wannamine4.0
goto loop
:automine
echo 自行判断wannamine版本逻辑
rem if ? start ? 
goto loop

:0
set /p virlist=[输入清单列表名字格式请参照temp.txt]
goto kill
:kill
call :tok&::tokens拓展为1,2,...,26
echo 准备读取清单处理 & echo.
echo -----------清理高频短时自启项目----------
set 1=sc& set 2=se& set 3=scs& set 4=pr
set title1=读取计划任务清单并删除
set title2=读取服务项任务停止并删除
set title3=读取排列组合服务项任务停止并删除
set title4=读取恶意进程并杀死
rem set act1=schtasks /delete /tn /f %$x%
set act2=net stop $x^&^&sc delete $x
rem set act3=taskkill /f /im %$x%
set act1=echo $x
set act3=echo $x

for /L %%i in (1,1,3) do (
set num=!%%i!& set str=!title%%i!& set act=!act%%i!
findstr /i "!num!" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo !str!
for /f "eol=# tokens=%tokens%" %%i in (.\vir\%virlist%.txt) do (
	if %%i==!num! set "action=!act:$x=%%j!"&&@echo !action!>comm.bat&&call comm.bat
	
	)
)

echo: & echo ------------清理落地文件----------------
findstr /i "fi" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo 读取静态恶意文件，动态链接库文件并删除
for /f "tokens=1,2" %%i in (./vir/%virlist%.txt) do @if %%i==fi echo %%j

echo; & echo -----清理权限维持的项目开机启动项目等-----
findstr /i "re" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo 读取注册表开机启动项关联文件项目并删除
for /f "tokens=1,2" %%i in (./vir/%virlist%.txt) do @if %%i==re echo %%j


echo\
:tok
set a=1
for /l %%i in (2,1,26) do ( 
set a=!a!,%%i
)
::打印1,...26作为tokens
set tokens=%a%
rem call ascii
rem ::将letter1-letter26分别对应a-z 已废弃-理由:不支持诸如%%!letter%%i!这种写法
exit /b

pause
