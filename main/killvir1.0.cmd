@echo off
setlocal enabledelayedexpansion
set rand=%random%
net session >nul 2>&1
if not %errorlevel% == 0 goto gotadmin
if not %errorlevel% == 2 goto loop



REM ::--------------------------------------------------------------------------::
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
REM ::--------------------------------------------------------------------------::


:gotadmin
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
::pause

:loop
if defined auto call :kill 1>.\log\%computername%_%rand%.txt 2>.\log\error_%computername%_%rand%.txt
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
call :kill 1>.\log\%computername%_%rand%.txt 2>.\log\error_%computername%_%rand%.txt
::1>.\log\%computername%_%rand%.txt 2>.\log\error_%computername%_%rand%.txt
:kill
if defined end exit&::这句可以保证在call的时候只被执行一次
call :tok&::tokens拓展为1,2,...,26
echo 准备读取清单处理 & echo.
echo -----------清理高频短时自启项目----------
set 1=sc&set 2=se&set 3=pr
set title1=读取计划任务清单并删除
set title2=读取服务项任务停止并删除
set title3=读取恶意进程并杀死
set act1=schtasks /delete /f /tn $x
set act2=net stop $x^&^&sc delete $x
set act3=taskkill /f /im $x

for /f "delims=: tokens=1-3" %%i in ('ipconfig ^| findstr IPv4') do (set ip=!ip!%%j)
echo %date% %time% %PROCESSOR_ARCHITECTURE% %PROCESSOR_LEVEL%代%PROCESSOR_REVISION% 计算机名_随机号%computername%_%rand% 域:%userdomain%  %username% IPV4:!ip! kill%virlist% >>dialog.txt
for /L %%i in (1,1,3) do (
set num=!%%i!& set str=!title%%i!& set "act=!act%%i!"
::echo !act!
findstr /i "!num!" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo !str!
for /f "eol=# tokens=%tokens%" %%i in (.\vir\%virlist%.txt) do (
	if %%i==!num! (
		::带符号无穷小 字母无穷大
		if %%j leq 9999 (
rem 		echo 你进来啦%%j
		::取值赋值num替代
		set param1=%%k
		for /f "delims=; tokens=%tokens%" %%i in ("%%l") do set pa1=%%i&set pa2=%%j&set pa3=%%k&set pa4=%%l&set pa5=%%m&set pa6=%%n&set pa7=%%o
rem 		echo !pa1! !pa2! !pa3! !pa4! !pa5!
		for /f "delims=; tokens=%tokens%" %%i in ("%%m") do set pb1=%%i&set pb2=%%j&set pb3=%%k&set pb4=%%l&set pb5=%%m&set pb6=%%n&set pb7=%%o
		for /f "delims=; tokens=%tokens%" %%i in ("%%n") do set pc1=%%i&set pc2=%%j&set pc3=%%k&set pc4=%%l&set pc5=%%m&set pc6=%%n&set pc7=%%o
		::拿遍寻参数
		for /f "delims=- tokens=1,2,3" %%i in ("%%j") do (set /a I=%%i,J=%%j,K=%%k)
		::遍历拼接
		for /l %%i in (1,1,!I!) do (
		set pj1=!pa%%i!&::echo pa%%i的值!pa%%i!
			for /l %%j in (1,1,!J!) do (
			set pj2=!pj1!!pb%%j!&::echo pb%%j的值!pb%%j!
				for /l %%k in (1,1,!K!) do (
				set pj3=!pj2!!pc%%k!&::echo pc%%k的值!pc%%k!
				set pj3=!pj3:\s= !
				for /f "tokens=*" %%i in ("!pj3!") do (set "action=!act:$x="%%i"!"&&echo !action!&!echo !action!>comm.bat&&call comm.bat&&if %errorlevel%==0 echo success!&set !param1!=!pj3!)
					)
				)
			)
		) else (
 	set action=!act:$x="%%j"!&set "action=!action:\s= !"&&echo !action!&echo !action!>comm.bat&&call comm.bat
			 )
		)
	)
)

echo: & echo ------------清理落地文件----------------
timeout /t 1 >nul&::删的太快来不及反应的话会删不掉的
findstr /i "fi" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo 读取静态恶意文件，动态链接库文件并删除
for /f "tokens=1,*" %%i in (./vir/%virlist%.txt) do @if %%i==fi echo 清除文件%%j&(del /f /ASHR %%j&del /f %%j) 2>&1
for /f "tokens=1,*" %%i in (./vir/%virlist%.txt) do @if %%i==fis forfiles /p C:\ /s /m %%j /c "cmd /c echo @path&del /f /ASHR @path" 2>&1
for /f "tokens=1,*" %%i in (./vir/%virlist%.txt) do @if %%i==di echo Y|rd /s %%j


echo; & echo -----清理权限维持的项目开机启动项目等-----
findstr /i "re" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo 读取注册表开机启动项关联文件项目并删除
for /f "tokens=1,*" %%i in (./vir/%virlist%.txt) do @if %%i==re echo 清除注册表reg delete /f %%j&reg delete /f %%j&&echo success!

set end=1&::执行一次后的标记保证不会执行第二次
echo\

del comm.bat>nul
::pause
