@echo off
setlocal enabledelayedexpansion
echo ��¼��־����:2����ʽ��¼(����̨��¼������Ļ��¼ϵͳ) 3:����(net use) 4:������(Ϊ�˱���) 5:��������(�����¼) 7:��������(�����뱣������Ļ��������) 8:��������NetworkCleartext(IIS����������ƾ�ݵ�¼��֤��) 9:NewCredentials��RunAs��ӳ���������������ƾ֤(�����ͼ������������κ��¼�)10:Զ�̽���(�ն˷���,Զ������) 11������֤���¼ & echo ���ڡ���������������������������׼��������־�������ߡ���������������������������&& echo ����event log explorer ��logparser������ƽ̨
cd /d %~dp0
set arg=%1
if not defined arg for /f %%i in ('hostname') do (
@set arg=%%i
echo %arg%
pause
if not exist !arg! echo ��ǰû�б�����־,������������Ҫ��ѯ��������־�ļ��� &&set /p arg=[������־�ļ�������]
)

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
ϵͳ��־ System.evtx 7036(��������ֹͣ) 7045(���񱻰�װ)
	set /p svname=[������Ҫ���ҵķ�������(eg:Network Time Manager]
	if defined svname set svname="and EXTRACT_TOKEN(Message,0,' ������')='%svname%'" && set svname=!svname:"= !
start 7036-45.cmd

pause