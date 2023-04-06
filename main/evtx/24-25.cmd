title RDP连接日志24-25 && ..\..\tools\Logparser\logparser.exe -i:EVT -o:DATAGRID "select TimeGenerated as RDP212425时间,EventID,EventType,Strings,ComputerName,SID from %arg%\Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx where %eventid% %sqltime%"
rem Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx


pause