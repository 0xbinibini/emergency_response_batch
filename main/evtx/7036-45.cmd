title Security��ȫ��־ 7036-45 && ..\..\tools\Logparser\logparser.exe -i:EVT -o:DATAGRID "select TimeGenerated,EXTRACT_TOKEN(Message,0,' ������') as sv,EXTRACT_TOKEN(Message,1,'������') from %arg%\System.evtx where eventid=7036 or eventid=7045 or eventid=104 %svname% %sqltime%"


