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
goto kill
:kill
call :tok&::tokens��չΪ1,2,...,26
echo ׼����ȡ�嵥���� & echo.
echo -----------�����Ƶ��ʱ������Ŀ----------
set 1=sc& set 2=se& set 3=scs& set 4=pr
set title1=��ȡ�ƻ������嵥��ɾ��
set title2=��ȡ����������ֹͣ��ɾ��
set title3=��ȡ������Ϸ���������ֹͣ��ɾ��
set title4=��ȡ������̲�ɱ��
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

echo: & echo ------------��������ļ�----------------
findstr /i "fi" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo ��ȡ��̬�����ļ�����̬���ӿ��ļ���ɾ��
for /f "tokens=1,2" %%i in (./vir/%virlist%.txt) do @if %%i==fi echo %%j

echo; & echo -----����Ȩ��ά�ֵ���Ŀ����������Ŀ��-----
findstr /i "re" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo ��ȡע���������������ļ���Ŀ��ɾ��
for /f "tokens=1,2" %%i in (./vir/%virlist%.txt) do @if %%i==re echo %%j


echo\
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

pause
