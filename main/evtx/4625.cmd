title Security��ȫ��־ 4625 && ..\..\tools\Logparser\logparser.exe -i:EVT -o:DATAGRID "select timegenerated,extract_token(strings,1,'|') as ʹ����:�ʻ���,extract_token(strings,3,'|')  as ʹ����:��¼_ID,extract_token(strings,8,'|')  as ʧ��ԭ��,extract_token(strings,5,'|')  as �µ�¼:�ʻ���,extract_token(strings,6,'|')  as �µ�¼:�ʻ���,extract_token(strings,9,'|') as ��״̬,extract_token(strings,10,'|') as ��¼����,extract_token(strings,11,'|') as ��¼����,extract_token(strings,13,'|') as ����վ��,extract_token(strings,17,'|') as ���÷�����id,extract_token(strings,19,'|') as Դ�����ַ,extract_token(strings,20,'|') as Դ�˿� from %arg%\Security.evtx where eventid=4625 %lgtype% %sqltime%"




