rem @echo off
setlocal enabledelayedexpansion

rem set 1=sc
rem set a1=��ȡ�ƻ������嵥��ɾ��
rem set 2=se
rem set a2=��ȡ����������ֹͣ��ɾ��
rem set 3=pr
rem set a3=��ȡ������̲�ɱ��


set 1=sc&set 2=se& set 3=pr
set a1=��ȡ�ƻ������嵥��ɾ��
set a2=��ȡ����������ֹͣ��ɾ��
set a3=��ȡ������̲�ɱ��
for /L %%i in (1,1,3) do (
set num=!%%i!& set str=!a%%i!
findstr /i "!num!" temp.txt>nul && if %errorlevel% == 0 echo !str!
pause
for /f "tokens=1,2" %%a in (temp.txt) do echo !num!&if %%a==!num! echo %%b
)

pause