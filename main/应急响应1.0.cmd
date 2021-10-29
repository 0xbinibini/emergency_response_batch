rem @echo on
@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
echo 请求管理员权限...
goto UACPrompt
) else (goto init)
:UACPrompt
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
exit /B

:init
call init.bat
rem pause
goto loop

:loop
cd /d "%~dp0"
del "%temp%\getadmin.vbs"
title 应急响应脚本 & color 0e

cls
echo ----------------------------------整合版本 ===^>^>by binibini----------------------------------------------
echo  mmmm  m    m #        "             "    #        "             "   
echo m"  "m  #  #  #mmm   mmm    m mm   mmm    #mmm   mmm    m mm   mmm   
echo #  m #   ##   #" "#    #    #"  #    #    #" "#    #    #"  #    #   
echo #    #  m""m  #   #    #    #   #    #    #   #    #    #   #    #   
echo  #mm#  m"  "m ##m#"  mm#mm  #   #  mm#mm  ##m#"  mm#mm  #   #  mm#mm

echo 当前系统体系架构:%PROCESSOR_ARCHITECTURE%
echo 当前用户: && whoami
echo 1: 查看计算机基本信息
echo 2: 检测计算机用户信息
echo 3: 查看网络链接与进程
echo 4: 查看启动项与计划任务程序
echo 5: 查看关键注册表项
echo 6: 查看敏感文件位置
echo 7：打开事件日志
echo 8: 关键文件拓展名关联命令
echo 9: webshell检测(规划中)
echo 0: 启动查杀批处理
echo `: 选择第三方工具
set /p input=[请选择不要输入诸如007哦]
if %input% equ ` (echo 选择第三方工具 & start choosetools)
if %input% equ 0 (echo 启动查杀 & call killvir1.0 )
if %input% Geq 1 (echo 大概是个正数) else (
echo 输入不合法重新输入
goto loop
)

if %input% Leq 8 (
echo 小等8输入合法准备执行
goto process
) else (
echo 你输入的值大于8了请重新选择
goto loop
)
:process
rem if %input% == %input% goto :%input%
goto :%input%


:1
REM <---------------------------基本信息----------------------------->
start cmd /k "title 系统基本信息&color 2f & start msinfo32 & systeminfo>%USERDOMAIN%.txt && type %USERDOMAIN%.txt & wmic qfe>%USERDOMAIN%hotfix.txt && type %USERDOMAIN%qfe.txt && echo 启动基线检查工具检查"
REM 大神火车上写的exp提权检测项目名:win-powerup-exp-index
goto loop
:2
REM <---------------------------用户信息----------------------------->
start cmd /k "title 用户和组信息&color 4A & whoami /user & net user & net localgroup &  wmic useraccount get name,sid & start lusrmgr.msc & REG QUERY HKEY_LOCAL_MACHINE\SAM\SAM\Domains\Account\Users\Names || echo 获取用户信息注册表(\SAM\SAM\Domains\Account\Users)失败请尝试手工查看 & if defined Ddun start ..\tools\Ddun\D_Safe_Manage.exe"
goto loop
:3
REM <----------------------------------网络连接与进程排查----------------------------------->
start taskmgr.exe
start cmd /k "tasklist /svc && echo 分析进程参数 & wmic process get caption,commandline /value"
rem start cmd /k "tasklist /m xxx.dll"
start cmd /k "netstat /anob"
start powershell -noexit -command "Get-WmiObject Win32_Process | select Name,ProcessId,ParentProcessId,Path"
goto loop
:4
REM <---------------------------启动项与任务计划程序等自启项----------------------------->
start msconfig
start taskschd.msc
start sysdm.cpl
start powershell -noexit -Command "$host.ui.RawUI.WindowTitle='计划任务程序显示' ;Get-ScheduledTask"
start cmd /k "title 超级命令计划工具查看与启动文件夹文件查看 & schtasks & dir "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp" /A /S /4"
REM <----------------------------------后门查看----------------------------------->
bitsadmin /list /allusers /verbose
goto loop
:5
REM <----------------------------------注册表项----------------------------------->
start cmd /k "(echo Run键值 & REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Run && (REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Policies\Explorer &  REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Policies\Explorer\Run) & REG QUERY HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Run & (REG QUERY HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Policies\Explorer & REG QUERY HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Policies\Explorer\Run)) > Run_key.txt  & type Run_key.txt"
REM <------------------------------------------------------------------------------>
start cmd /k "(echo Run_once键值 & REG QUERY HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\RunOnce & reg query HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\RunOnce) > Run_Once_key.txt & type Run_Once_key.txt"
goto loop

:6
REM <----------------------------------敏感文件排查----------------------------------->
start %WINDIR%
start %WINDIR%\tmp
start %WINDIR%\system32\
start %TEMP%
start %LOCALAPPDATA%
start %APPDATA%

echo 查看用户们最近打开的文件
cd %UserProfile%\Recent  && start %UserProfile%\Recent && forfiles /m *.exe /d +2020/2/12 /s /p C:\ /c "cmd /c echo @path @fdate @ftime" 2>null
dir %WINDIR%\Prefetch
goto loop

:7
REM <----------------------------------日志分析----------------------------------->
rem start %windir%\System32\winevt\Logs\
REM System.evtx系统日志 Application.evtx应用程序日志
rem C:\Windows\System32\winevt\Logs目录下提取出以下文件
rem Security.evtx 1102清除日志 
rem system.evtx 104清除日志 7045服务已安装在系统中 7036运行或停止服务
rem Microsoft-Windows-TerminalServices-LocalSessionManager%4Operational.evtx	24/25 1024
rem Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Operational.evtx rdp记录日志 1149
if not exist evtx\%computername% (xcopy %windir%\System32\winevt\Logs\* evtx\%computername%\)
rem start 
start eventvwr.msc
start powershell -noexit -command echo 获取传统日志;Get-EventLog;Get-WinEvent cmdlet
if defined Logparser set /p comp=[输入您要分析的日志以主机名(hostname)为名称,all参数分析evtx文件夹下所有主机日志，默认分析本机日志] & start cmd /k "call .\evtx\parser.cmd !comp!"
rem cmd.exe
goto loop
:8
rem assoc & ftype
start cmd /k "ftype txtfile & ftype exefile"
goto loop
:9
REM <----------------------------------Webshell检测----------------------------------->
echo 基于流量
echo 基于文件
echo 基于日志
goto loop

REM 常用工具PChunter 、 autoruns 、 process explorer
REM 勒索病毒判断网址 lesuobingdu.360.cn 黑客可以通过ProcessHacker工具结束掉一些防护进程

