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
::��ӡ1,...26��Ϊtokens
set tokens=%a%
rem call ascii
rem ::��letter1-letter26�ֱ��Ӧa-z �ѷ���-����:��֧������%%!letter%%i!����д��
exit /b
REM ::--------------------------------------------------------------------------::


:gotadmin
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
::pause

:loop
if defined auto call :kill 1>.\log\%computername%_%rand%.txt 2>.\log\error_%computername%_%rand%.txt
cd /d "%~dp0"
cls
title ͨɱ�ű�������
rem echo %cd%
echo `: һ���رո�Σ�˿ڷ�ֹ���򴫲�
echo 1: WannaCryרɱ��
echo 2: WannaMine�ڿ�ľ����
echo 0: ͨ��������
set /p input=[����������ѡ��]
if %input% == ` start "" ����-һ���رո�Σ�˿�set��-1.1
if %input% == 0 goto 0
if %input% == 1 start "" /d ".\vir\" wannacry
if %input% == 2 goto wannamine
goto loop

:wannamine
set /p input=[������wannamine�汾]
if %input% == 0 ��echo ����֪��ʲô�汾���Լ��� && goto automine)
if %input% == 2 start "" /d ".\vir\" wannamine2.0
if %input% == 3 start "" /d ".\vir\" wannamine3.0
if %input% == 4 start "" /d ".\vir\" wannamine4.0
goto loop
:automine
echo �����ж�wannamine�汾�߼�
rem if ? start ? 
goto loop

:0
set /p virlist=[�����嵥�б����ָ�ʽ�����temp.txt]
call :kill 1>.\log\%computername%_%rand%.txt 2>.\log\error_%computername%_%rand%.txt
::1>.\log\%computername%_%rand%.txt 2>.\log\error_%computername%_%rand%.txt
:kill
if defined end exit&::�����Ա�֤��call��ʱ��ֻ��ִ��һ��
call :tok&::tokens��չΪ1,2,...,26
echo ׼����ȡ�嵥���� & echo.
echo -----------�����Ƶ��ʱ������Ŀ----------
set 1=sc&set 2=se&set 3=pr
set title1=��ȡ�ƻ������嵥��ɾ��
set title2=��ȡ����������ֹͣ��ɾ��
set title3=��ȡ������̲�ɱ��
set act1=schtasks /delete /f /tn $x
set act2=net stop $x^&^&sc delete $x
set act3=taskkill /f /im $x

for /f "delims=: tokens=1-3" %%i in ('ipconfig ^| findstr IPv4') do (set ip=!ip!%%j)
echo %date% %time% %PROCESSOR_ARCHITECTURE% %PROCESSOR_LEVEL%��%PROCESSOR_REVISION% �������_�����%computername%_%rand% ��:%userdomain%  %username% IPV4:!ip! kill%virlist% >>dialog.txt
for /L %%i in (1,1,3) do (
set num=!%%i!& set str=!title%%i!& set "act=!act%%i!"
::echo !act!
findstr /i "!num!" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo !str!
for /f "eol=# tokens=%tokens%" %%i in (.\vir\%virlist%.txt) do (
	if %%i==!num! (
		::����������С ��ĸ�����
		if %%j leq 9999 (
rem 		echo �������%%j
		::ȡֵ��ֵnum���
		set param1=%%k
		for /f "delims=; tokens=%tokens%" %%i in ("%%l") do set pa1=%%i&set pa2=%%j&set pa3=%%k&set pa4=%%l&set pa5=%%m&set pa6=%%n&set pa7=%%o
rem 		echo !pa1! !pa2! !pa3! !pa4! !pa5!
		for /f "delims=; tokens=%tokens%" %%i in ("%%m") do set pb1=%%i&set pb2=%%j&set pb3=%%k&set pb4=%%l&set pb5=%%m&set pb6=%%n&set pb7=%%o
		for /f "delims=; tokens=%tokens%" %%i in ("%%n") do set pc1=%%i&set pc2=%%j&set pc3=%%k&set pc4=%%l&set pc5=%%m&set pc6=%%n&set pc7=%%o
		::�ñ�Ѱ����
		for /f "delims=- tokens=1,2,3" %%i in ("%%j") do (set /a I=%%i,J=%%j,K=%%k)
		::����ƴ��
		for /l %%i in (1,1,!I!) do (
		set pj1=!pa%%i!&::echo pa%%i��ֵ!pa%%i!
			for /l %%j in (1,1,!J!) do (
			set pj2=!pj1!!pb%%j!&::echo pb%%j��ֵ!pb%%j!
				for /l %%k in (1,1,!K!) do (
				set pj3=!pj2!!pc%%k!&::echo pc%%k��ֵ!pc%%k!
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

echo: & echo ------------��������ļ�----------------
timeout /t 1 >nul&::ɾ��̫����������Ӧ�Ļ���ɾ������
findstr /i "fi" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo ��ȡ��̬�����ļ�����̬���ӿ��ļ���ɾ��
for /f "tokens=1,*" %%i in (./vir/%virlist%.txt) do @if %%i==fi echo ����ļ�%%j&(del /f /ASHR %%j&del /f %%j) 2>&1
for /f "tokens=1,*" %%i in (./vir/%virlist%.txt) do @if %%i==fis forfiles /p C:\ /s /m %%j /c "cmd /c echo @path&del /f /ASHR @path" 2>&1
for /f "tokens=1,*" %%i in (./vir/%virlist%.txt) do @if %%i==di echo Y|rd /s %%j


echo; & echo -----����Ȩ��ά�ֵ���Ŀ����������Ŀ��-----
findstr /i "re" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo ��ȡע���������������ļ���Ŀ��ɾ��
for /f "tokens=1,*" %%i in (./vir/%virlist%.txt) do @if %%i==re echo ���ע���reg delete /f %%j&reg delete /f %%j&&echo success!

set end=1&::ִ��һ�κ�ı�Ǳ�֤����ִ�еڶ���
echo\

del comm.bat>nul
::pause
