title Security��ȫ��־ 4648 && ..\..\tools\Logparser\logparser.exe -i:EVT -o:DATAGRID "select timegenerated,extract_token(strings,0,'|')  as ʹ����:��ȫid,extract_token(strings,1,'|') as ʹ����:�ʻ���,extract_token(strings,2,'|')  as ʹ����:�ʻ���,extract_token(strings,5,'|')  as ƾ��:�ʻ���,extract_token(strings,6,'|')  as ƾ��:�ʻ���,extract_token(strings,8,'|')  as Ŀ�������:��,extract_token(strings,9,'|') as Ŀ�������:������Ϣ,extract_token(strings,10,'|') as ������Ϣ:����_ID,extract_token(strings,11,'|') as ������Ϣ:������,extract_token(strings,12,'|') as ������Ϣ:�����ַ,extract_token(strings,13,'|') as ������Ϣ:����˿� from %arg%\Security.evtx where eventid=4648 %sqltime%"



