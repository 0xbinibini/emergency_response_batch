title Security安全日志 4648 && ..\..\tools\Logparser\logparser.exe -i:EVT -o:DATAGRID "select timegenerated,extract_token(strings,0,'|')  as 使用者:安全id,extract_token(strings,1,'|') as 使用者:帐户名,extract_token(strings,2,'|')  as 使用者:帐户域,extract_token(strings,5,'|')  as 凭据:帐户名,extract_token(strings,6,'|')  as 凭据:帐户域,extract_token(strings,8,'|')  as 目标服务器:名,extract_token(strings,9,'|') as 目标服务器:附加信息,extract_token(strings,10,'|') as 进程信息:进程_ID,extract_token(strings,11,'|') as 进程信息:进程名,extract_token(strings,12,'|') as 网络信息:网络地址,extract_token(strings,13,'|') as 网络信息:网络端口 from %arg%\Security.evtx where eventid=4648 %sqltime%"



