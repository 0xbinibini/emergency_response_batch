setlocal enabledelayedexpansion

set virlist=temp
echo 准备读取清单处理 & echo.
echo -----------清理高频短时自启项目----------
set 1=sc&set 2=se& set 3=pr
set title1=读取计划任务清单并删除
set title2=读取服务项任务停止并删除
set title3=读取恶意进程并杀死
set act1=echo& set act2=echo& set act3=echo

for /L %%i in (1,1,3) do (
set num=!%%i!& set str=!title%%i!&set act=!act%%i!
findstr /i "!num!" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo !str!
pause
rem call cmd
for /f "tokens=1,2" %%i in (.\vir\%virlist%.txt) do @if %%i==!num! !act! %%j
)

pause