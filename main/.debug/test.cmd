setlocal enabledelayedexpansion

set virlist=temp
echo ׼����ȡ�嵥���� & echo.
echo -----------�����Ƶ��ʱ������Ŀ----------
set 1=sc&set 2=se& set 3=pr
set title1=��ȡ�ƻ������嵥��ɾ��
set title2=��ȡ����������ֹͣ��ɾ��
set title3=��ȡ������̲�ɱ��
set act1=echo& set act2=echo& set act3=echo

for /L %%i in (1,1,3) do (
set num=!%%i!& set str=!title%%i!&set act=!act%%i!
findstr /i "!num!" .\vir\%virlist%.txt>nul && if %errorlevel% == 0 echo !str!
pause
rem call cmd
for /f "tokens=1,2" %%i in (.\vir\%virlist%.txt) do @if %%i==!num! !act! %%j
)

pause