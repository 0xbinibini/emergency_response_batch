rem @echo off
setlocal enabledelayedexpansion

rem set 1=sc
rem set a1=读取计划任务清单并删除
rem set 2=se
rem set a2=读取服务项任务停止并删除
rem set 3=pr
rem set a3=读取恶意进程并杀死


set 1=sc&set 2=se& set 3=pr
set a1=读取计划任务清单并删除
set a2=读取服务项任务停止并删除
set a3=读取恶意进程并杀死
for /L %%i in (1,1,3) do (
set num=!%%i!& set str=!a%%i!
findstr /i "!num!" temp.txt>nul && if %errorlevel% == 0 echo !str!
pause
for /f "tokens=1,2" %%a in (temp.txt) do echo !num!&if %%a==!num! echo %%b
)

pause