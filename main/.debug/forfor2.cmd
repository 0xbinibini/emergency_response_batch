@echo off
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
pause
findstr /i "!num!" temp.txt>nul && if %errorlevel% == 0 echo !str!
for /f "eol=# tokens=%tokens%" %%a in (temp.txt) do (
	if %%a==!num! (
		if %%b leq 9 (
			::set /a max=2+%%b
			for /f "delims=, tokens=%tokens%" %%i in ("%%c") do (set act1=%%i&set act2=%%j&set act3=%%k&set act4=%%l&set act5=%%m)
			for /f "delims=, tokens=%tokens%" %%i in ("%%d") do (set param1=%%i&set param2=%%j&set param3=%%k&set param4=%%l&set param5=%%m)
rem 			call cmd
			for /L %%i in (1,1,%%b) do !act%%i! !param%%i!
			) else (
			echo ���� %%b
			) 
		)
	)
)

pause