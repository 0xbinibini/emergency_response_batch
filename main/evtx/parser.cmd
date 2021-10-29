@echo off
setlocal enabledelayedexpansion
echo 登录日志类型:
echo 	2交互式登录(控制台登录键盘屏幕登录系统) 
echo 	3:网络(net use) 
echo 	4:批处理(为此保留) 
echo 	5:服务启动(服务登录) 
echo 	7:解锁屏保(带密码保护的屏幕保护解锁) 
echo 	8:网络明文NetworkCleartext(IIS服务器明文凭据登录验证等)
echo 	9:NewCredentials如RunAs或映射网络驱动器替代凭证(此类型几乎不出现在任何事件)
echo 	10:远程交互(终端服务,远程桌面) 
echo 	11缓存域证书登录 & echo 正在。。。。。。。。。。。。。。准备启动日志分析工具。。。。。。。。。。。。。。&& echo 启动event log explorer 、logparser、观星平台
echo 输入参数all将会把所有的Security.evtx System.evtx Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx Microsoft-Windows-TerminalServices-RemoteConnectionManager%%4Operational.evtx输出为csv
cd /d %~dp0
set arg=%1
if not defined arg for /f %%i in ('hostname') do (
@set arg=%%i
echo 当前分析日志:!arg!
pause
if not exist !arg! echo 当前没有本机日志,请重新输入你要查询的主机日志文件夹 &&set /p arg=[主机日志文件夹名称]
)
if %arg%==all goto 2csv
rem cmd.exe
:istime
set /p stamp=[请输入要查找的时间段 eg:2021-09-07 00:00:00 2021-09-08 00:00:00]
if defined stamp (
	for /f "tokens=1,2,3,4" %%i in ("%stamp%") do (
		set sta=%%i %%j
		set sto=%%k %%l
rem 		set sqltime="TimeGenerated^^^>'!sta!' and TimeGenerated^^^<'!sto!'"
		set sqltime="and TimeGenerated^>'!sta!' and TimeGenerated^<'!sto!'"
		set sqltime=!sqltime:"= !
		)
	)
rem echo "%sqltime%"

:sqlquery
rem RDP连接日志 Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx 1149
start 1149.cmd
rem Remote连接日志 Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Operational.evtx 24 25
	set /p eventid=[请输入事件ID号查询语句eg:eventid=24 or eventid=25]
start 24-25.cmd
rem 安全日志 Security.evtx 4624(登录成功) 4625(登录失败) 4648(明确凭据登录)
	set /p lgtype=[请输入登录类型(常见类型3网络登录 10远程桌面登录)eg:3]
	if defined lgtype set lgtype="and extract_token(strings,8,'|')='%lgtype%'" && set lgtype=!lgtype:"= !
start 4624.cmd
start 4625.cmd
start 4648.cmd
rem 系统日志 System.evtx 7036(服务开启或停止) 7045(服务被安装)
	set /p svname=[请输入要查找的服务类型(eg:Network Time Manager]
	if defined svname set svname="and EXTRACT_TOKEN(Message,0,' 服务处于')='%svname%'" && set svname=!svname:"= !
start 7036-45.cmd
exit

:2csv
set /p gz=[选择是否要将日志挂载到本地查看;输入all挂载所有；默认不挂载]
for /f %%i in ('dir /AD /B') do (
echo F|xcopy "%%i\Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx" "%%i\csv\%%i-rdp.evtx" && ..\..\tools\Logparser\LogParser.exe -i:evt -o:csv "select * from %%i\csv\%%i-rdp.evtx" > %%i\csv\%%i-rdp.csv
echo F|xcopy "%%i\Microsoft-Windows-TerminalServices-RemoteConnectionManager%%4Operational.evtx" "%%i\csv\%%i-remote.evtx" && ..\..\tools\Logparser\LogParser.exe -i:evt -o:csv "select * from %%i\csv\%%i-remote.evtx" > %%i\csv\%%i-remote.csv
echo F|xcopy "%%i\Security.evtx" "%%i\csv\%%i-security.evtx" && ..\..\tools\Logparser\LogParser.exe -i:evt -o:csv "select * from %%i\csv\%%i-security.evtx" > %%i\csv\%%i-security.csv
echo F|xcopy "%%i\System.evtx" "%%i\csv\%%i-system.evtx" && ..\..\tools\Logparser\LogParser.exe -i:evt -o:csv "select * from %%i\csv\%%i-system.evtx" > %%i\csv\%%i-system.csv
rem if defined gz start cmd /k "start %%i\csv\%%i-rdp.evtx & start %%i\csv\%%i-remote.evtx & start %%i\csv\%%i-security.evtx & start %%i\csv\%%i-system.evtx"
if defined gz forfiles /P %%i\csv /M *.evtx /C "cmd /c @path"
)


pause