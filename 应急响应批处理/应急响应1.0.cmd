rem @echo on
@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
echo �������ԱȨ��...
goto UACPrompt
) else (goto loop)
:UACPrompt
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
exit /B

:loop
cd /d "%~dp0"
del "%temp%\getadmin.vbs"
title Ӧ����Ӧ�ű� & color 0e
cls
echo ----------------------------------���ϰ汾 ===^>^>by binibini----------------------------------------------
echo ��ǰϵͳ��ϵ�ܹ�:%PROCESSOR_ARCHITECTURE%
echo ��ǰ�û�: && whoami
echo 1: �鿴�����������Ϣ
echo 2: ��������û���Ϣ
echo 3: �鿴�������������
echo 4: �鿴��������ƻ��������
echo 5: �鿴�ؼ�ע�����
echo 6: �鿴�����ļ�λ��
echo 7�����¼���־
echo 8: �ؼ��ļ���չ����������
echo 9: webshell���(�滮��)
echo 0: ������ɱ������
set /p input=[��ѡ��Ҫ��������007Ŷ]
if %input% equ 0 (echo ������ɱ & call killvir1.0 )
if %input% Geq 1 (echo ����Ǹ�����) else (
echo ���벻�Ϸ���������
goto loop
)

if %input% Leq 8 (
echo С��8����Ϸ�׼��ִ��
goto process
) else (
echo �������ֵ����8��������ѡ��
goto loop
)
:process
rem if %input% == %input% goto :%input%
goto :%input%


:1
REM <---------------------------������Ϣ----------------------------->
start cmd /k "title ϵͳ������Ϣ&color 2f & start msinfo32 & systeminfo>%USERDOMAIN%.txt && type %USERDOMAIN%.txt  && echo �������߼�鹤�߼��"
REM �������д��exp��Ȩ�����Ŀ��:win-powerup-exp-index
goto loop
:2
REM <---------------------------�û���Ϣ----------------------------->
start cmd /k "title �û�������Ϣ&color 4A & whoami /user & net user & net localgroup &  wmic useraccount get name,sid & start lusrmgr.msc & REG QUERY HKEY_LOCAL_MACHINE\SAM\SAM\Domains\Account\Users\Names || echo ��ȡ�û���Ϣע���(\SAM\SAM\Domains\Account\Users)ʧ���볢���ֹ��鿴"
goto loop
:3
REM <----------------------------------��������������Ų�----------------------------------->
start taskmgr.exe
start cmd /k "tasklist /svc && echo �������̲��� & wmic process get caption,commandline /value"
rem start cmd /k "tasklist /m xxx.dll"
start cmd /k "netstat /anob"
start powershell -noexit -command "Get-WmiObject Win32_Process | select Name,ProcessId,ParentProcessId,Path"
goto loop
:4
REM <---------------------------������������ƻ������������----------------------------->
start msconfig
start taskschd.msc
start sysdm.cpl
start powershell -noexit -Command "$host.ui.RawUI.WindowTitle='�ƻ����������ʾ' ;Get-ScheduledTask"
start cmd /k "title ��������ƻ����߲鿴�������ļ����ļ��鿴 & schtasks & dir "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp" /A /S /4"
REM <----------------------------------���Ų鿴----------------------------------->
bitsadmin /list /allusers /verbose
goto loop
:5
REM <----------------------------------ע�����----------------------------------->
start cmd /k "(echo Run��ֵ & REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Run && (REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Policies\Explorer &  REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Policies\Explorer\Run) & REG QUERY HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Run & (REG QUERY HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Policies\Explorer & REG QUERY HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\Policies\Explorer\Run)) > Run_key.txt  & type Run_key.txt"
REM <------------------------------------------------------------------------------>
start cmd /k "(echo Run_once��ֵ & REG QUERY HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\RunOnce & reg query HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion\RunOnce) > Run_Once_key.txt & type Run_Once_key.txt"
goto loop

:6
REM <----------------------------------�����ļ��Ų�----------------------------------->
start %WINDIR% 
start %WINDIR%\tmp 
start %WINDIR%\system32\
start %TEMP%
start %LOCALAPPDATA%
start %APPDATA%

echo �鿴�û�������򿪵��ļ�
cd %UserProfile%\Recent  && start %UserProfile%\Recent && forfiles /m *.exe /d +2020/2/12 /s /p C:\ /c "cmd /c echo @path @fdate @ftime" 2>null
dir %WINDIR%\Prefetch
goto loop

:7
REM <----------------------------------��־����----------------------------------->
start %windir%\System32\winevt\Logs\
REM System.evtxϵͳ��־ Application.evtxӦ�ó�����־
rem C:\Windows\System32\winevt\LogsĿ¼����ȡ�������ļ�
rem Security.evtx
rem Microsoft-Windows-TerminalServices-LocalSessionManager%4Operational.evtx
rem Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Operational.evtx
start eventvwr.msc
start powershell -noexit -command echo ��ȡ��ͳ��־;Get-EventLog;Get-WinEvent cmdlet
start cmd /k "echo  ��¼��־����:2����ʽ��¼(����̨��¼������Ļ��¼ϵͳ) 3:����(net use) 4:������(Ϊ�˱���) 5:��������(�����¼) 7:��������(�����뱣������Ļ��������) 8:��������NetworkCleartext(IIS����������ƾ�ݵ�¼��֤��) 9:NewCredentials��RunAs��ӳ���������������ƾ֤(�����ͼ������������κ��¼�)10:Զ�̽���(�ն˷���,Զ������) 11������֤���¼ & echo ���ڡ���������������������������׼��������־�������ߡ���������������������������&& echo ����event log explorer ��logparser������ƽ̨"
goto loop
:8
rem assoc & ftype
start cmd /k "ftype txtfile & ftype exefile"
goto loop
:9
REM <----------------------------------Webshell���----------------------------------->
echo ��������
echo �����ļ�
echo ������־
goto loop

REM ���ù���PChunter �� autoruns �� process explorer
REM ���������ж���ַ lesuobingdu.360.cn �ڿͿ���ͨ��ProcessHacker���߽�����һЩ��������

















