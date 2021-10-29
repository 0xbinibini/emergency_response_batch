title remote连接日志24-25 && ..\..\tools\Logparser\logparser.exe -i:EVT -o:DATAGRID "select TimeGenerated,EventID,EventType,Strings,ComputerName,SID from %arg%\Microsoft-Windows-TerminalServices-RemoteConnectionManager%%4Operational.evtx where %eventid% %sqltime%"
rem || ..\..\tools\Logparser\logparser.exe -i:EVT -o:DATAGRID "select TimeGenerated,EventID,EventType,Strings,ComputerName,SID from '%arg%\Microsoft-Windows-TerminalServices-RemoteConnectionManager Operational.evtx' where %eventid% %sqltime%"


pause