for /f "delims=" %%i in (src.txt) do @(set /p=%%i,<nul) >>des.txt

pause