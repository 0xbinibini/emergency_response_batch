@echo off
setlocal enabledelayedexpansion
echo ��¼��־����:
echo 	2����ʽ��¼(����̨��¼������Ļ��¼ϵͳ) 
echo 	3:����(net use) 
echo 	4:������(Ϊ�˱���) 
echo 	5:��������(�����¼) 
echo 	7:��������(�����뱣������Ļ��������) 
echo 	8:��������NetworkCleartext(IIS����������ƾ�ݵ�¼��֤��)
echo 	9:NewCredentials��RunAs��ӳ���������������ƾ֤(�����ͼ������������κ��¼�)
echo 	10:Զ�̽���(�ն˷���,Զ������) 
echo 	11������֤���¼ & echo ���ڡ���������������������������׼��������־�������ߡ���������������������������&& echo ����event log explorer ��logparser������ƽ̨
echo �������all��������е�Security.evtx System.evtx Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx Microsoft-Windows-TerminalServices-RemoteConnectionManager%%4Operational.evtx���Ϊcsv
cd /d %~dp0
set arg=%1
if not defined arg for /f %%i in ('hostname') do (
@set arg=%%i
echo ��ǰ������־:!arg!
pause
if not exist !arg! echo ��ǰû�б�����־,������������Ҫ��ѯ��������־�ļ��� &&set /p arg=[������־�ļ�������]
)
if %arg%==all goto 2csv
rem cmd.exe
:istime
set /p stamp=[������Ҫ���ҵ�ʱ��� eg:2021-09-07 00:00:00 2021-09-08 00:00:00]
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
rem RDP������־ Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx 1149
start 1149.cmd
rem Remote������־ Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Operational.evtx 24 25
	set /p eventid=[�������¼�ID�Ų�ѯ���eg:eventid=24 or eventid=25]
start 24-25.cmd
rem ��ȫ��־ Security.evtx 4624(��¼�ɹ�) 4625(��¼ʧ��) 4648(��ȷƾ�ݵ�¼)
	set /p lgtype=[�������¼����(��������3�����¼ 10Զ�������¼)eg:3]
	if defined lgtype set lgtype="and extract_token(strings,8,'|')='%lgtype%'" && set lgtype=!lgtype:"= !
start 4624.cmd
start 4625.cmd
start 4648.cmd
rem ϵͳ��־ System.evtx 7036(��������ֹͣ) 7045(���񱻰�װ)
	set /p svname=[������Ҫ���ҵķ�������(eg:Network Time Manager]
	if defined svname set svname="and EXTRACT_TOKEN(Message,0,' ������')='%svname%'" && set svname=!svname:"= !
start 7036-45.cmd
exit

:2csv
set /p gz=[ѡ���Ƿ�Ҫ����־���ص����ز鿴;����all�������У�Ĭ�ϲ�����]
for /f %%i in ('dir /AD /B') do (
echo F|xcopy "%%i\Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx" "%%i\csv\%%i-rdp.evtx" && ..\..\tools\Logparser\LogParser.exe -i:evt -o:csv "select * from %%i\csv\%%i-rdp.evtx" > %%i\csv\%%i-rdp.csv
echo F|xcopy "%%i\Microsoft-Windows-TerminalServices-RemoteConnectionManager%%4Operational.evtx" "%%i\csv\%%i-remote.evtx" && ..\..\tools\Logparser\LogParser.exe -i:evt -o:csv "select * from %%i\csv\%%i-remote.evtx" > %%i\csv\%%i-remote.csv
echo F|xcopy "%%i\Security.evtx" "%%i\csv\%%i-security.evtx" && ..\..\tools\Logparser\LogParser.exe -i:evt -o:csv "select * from %%i\csv\%%i-security.evtx" > %%i\csv\%%i-security.csv
echo F|xcopy "%%i\System.evtx" "%%i\csv\%%i-system.evtx" && ..\..\tools\Logparser\LogParser.exe -i:evt -o:csv "select * from %%i\csv\%%i-system.evtx" > %%i\csv\%%i-system.csv
rem if defined gz start cmd /k "start %%i\csv\%%i-rdp.evtx & start %%i\csv\%%i-remote.evtx & start %%i\csv\%%i-security.evtx & start %%i\csv\%%i-system.evtx"
if defined gz forfiles /P %%i\csv /M *.evtx /C "cmd /c @path"
)


pause