@echo off
title 工具启动脚本
set arg=%1
if defined %arg% goto runonce
setlocal ENABLEDELAYEDEXPANSION
set 1=Ddun
set 2=Autoruns
set 3=Logparser
set str_1=1:D盾工具
set str_2=2:微软自启动检查工具

set path_1=..\tools\Ddun\D_Safe_Manage.exe
set path_2=..\tools\Autoruns\Autoruns64.exe


pause
:main
cls
for /L %%i in (1,1,3) do @if defined !%%i! (echo !str_%%i![x]) else (echo !str_%%i![] && set !path_%%i!=)
set /p input=[请输入您的选择]
if defined path_%input%  start cmd /k "start !path_%input%!"
goto main

:runonce
for /L %%i in (1,1,2) do @if %arg%==!%%i! echo 启动!str_%%i! && start !path_%%i!

