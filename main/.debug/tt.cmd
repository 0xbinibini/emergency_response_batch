setlocal enabledelayedexpansion

set act1=whoami $x^&^&net $x
set act2=echo $x
set act3=echo $x
for /L %%i in (1,1,3) do (
set action=!act%%i!
set $x=/user
rem echo !!acttion!!


set par=/user
echo !action!
rem for /F "tokens=*" %%i in ("!action!") do set I=%%i&&set str=!I:$x=!!par!!!&echo !str!
::何必用for直接set换又不是不行

)
call cmd
pause

