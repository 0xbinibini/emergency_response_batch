title RDP������־24-25 && ..\..\tools\Logparser\logparser.exe -i:EVT -o:DATAGRID "select TimeGenerated as RDP212425ʱ��,EventID,EventType,Strings,ComputerName,SID from %arg%\Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx where %eventid% %sqltime%"
rem Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx


pause