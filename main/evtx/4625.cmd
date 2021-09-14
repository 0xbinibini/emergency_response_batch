title Security安全日志 4625 && ..\..\tools\Logparser\logparser.exe -i:EVT -o:DATAGRID "select timegenerated,extract_token(strings,1,'|') as 使用者:帐户名,extract_token(strings,3,'|')  as 使用者:登录_ID,extract_token(strings,8,'|')  as 失败原因,extract_token(strings,5,'|')  as 新登录:帐户名,extract_token(strings,6,'|')  as 新登录:帐户域,extract_token(strings,9,'|') as 子状态,extract_token(strings,10,'|') as 登录类型,extract_token(strings,11,'|') as 登录进程,extract_token(strings,13,'|') as 工作站名,extract_token(strings,17,'|') as 调用方进程id,extract_token(strings,19,'|') as 源网络地址,extract_token(strings,20,'|') as 源端口 from %arg%\Security.evtx where eventid=4625 %lgtype% %sqltime%"




