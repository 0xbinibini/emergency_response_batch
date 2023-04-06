title rdp连接日志 1149 && ..\..\tools\Logparser\LogParser.exe -i:evt -o:DATAGRID "select TimeGenerated as remote1149连接时间,EventID,EventType,Strings,ComputerName,extract_token(strings,2,'|')  as 源IP,SID from %arg%\Microsoft-Windows-TerminalServices-RemoteConnectionManager%%4Operational.evtx where eventid=1149 %sqltime%"
rem Microsoft-Windows-TerminalServices-RemoteConnectionManager%%4Operational.evtx

pause