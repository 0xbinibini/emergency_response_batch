title rdp������־ 1149 && ..\..\tools\Logparser\LogParser.exe -i:evt -o:DATAGRID "select TimeGenerated,EventID,EventType,Strings,ComputerName,extract_token(strings,2,'|')  as ԴIP,SID from %arg%\Microsoft-Windows-TerminalServices-LocalSessionManager%%4Operational.evtx where eventid=1149 %sqltime%"


pause