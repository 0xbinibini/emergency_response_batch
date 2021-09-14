rem chcp 65001
color 3f & title ipsec关闭高危端口
@echo off

rem 一键关闭高危端口 在Win10直接命令行输入会报错(批处理可以顺利执行)暂不知为何
set /a n=1
%1start /b  %~s0 :&pause>nul &cd.>$.t && timeout /t 1 >nul&start /b del $.t ^&exit&timeout /t 1 & goto gogo
del $.t
:loop
if exist $.t (echo 停止我要自行选择-将会退出本窗口回到父进程  &exit)
timeout /t 1 >nul
cls
echo ----------------------------------整合版本 ===^>^>by binibini----------------------------------------------
echo 1:	暂时阻断一切可能传播来源 一键关闭135 137 138 139 445危险端口
echo 2:	病毒查杀已完成漏洞已修补补丁已安装 业务需要打开上述端口请选我
echo 3: 	导出安全策略
echo 4:	导入安全策略
echo ----------------------------------------%n%秒后将默认选择1号方案-------------------------------------------------------
if %n%==10 (echo 时间到将选择默认1号方案&set input=1 && goto process )
set /a n=n+1
goto loop

:gogo
rem echo %input%
set /p input=[等待您的选择]
goto process

:process
rem echo %input% 
rem pause
if %input%==1 goto close
if %input%==2 goto open
if %input%==3 goto exp
if %input%==4 (goto inp) else (
echo 序号不对重新输
call %0
pause 
exit /b
)

rem ::导出IPsec安全策略
:exp
netsh ipsec static exportpolicy file = ./ipsec.ipsec && echo 导出成功 && timeout /T 3 /NOBREAK && exit /b
rem ::导入IPsec安全策略
:inp
netsh ipsec static importpolicy file = ./ipsec.ipsec && echo 导入成功 && timeout /T 3 /NOBREAK && exit /b

:close
rem 启动IPsec Policy Agent服务 一般默认都是开启的
rem sc query policyagent | findstr /I "running"
rem sc config policyagent start = auto
rem net start policyagent
::删除原有的可能名为SECCPP的安全策略
choice /t 5 /d Y /m Y:ipcsec模式——N:高级防火墙策略^(默认Y^)
if %errorlevel%==1 goto close1
if %errorlevel%==2 goto close2
:close1
netsh ipsec static delete policy name = SECCPP
::创建一个静态的ip安全策略 可以输入secpol.msc->IP安全策略查看
echo 创建一个安全策略
netsh ipsec static ^
	add policy name = SECCPP description=安全策略201705
echo 添加两个筛选器动作阻断和允许
netsh ipsec static add filteraction name = Permitted action = permit description=允许
netsh ipsec static add filteraction name = Blocked action = block description=禁断

echo 建立筛选器列表可以看为ip池
netsh ipsec static delete filterlist name = wanna
netsh ipsec static add filterlist name = wanna description=阻止再次感染
echo 阻止任何源地址访问到本身的135 137 138 139 445(tcp) 137 138(UDP)
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 135 protocol = TCP 
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 137 protocol = TCP
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 138 protocol = TCP
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 139 protocol = TCP
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 445 protocol = TCP description = ban
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 137 protocol = UDP
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 138 protocol = UDP
echo 建立策略规则
netsh ipsec static add rule name=SECCPR policy=SECCPP filterlist=wanna filteraction=Blocked
echo 指派策略生效
netsh ipsec static set policy name = SECCPP assign = y && echo 策略指派生效已阻断传播来源 不要忘记打补丁奥
::echo 建立一个筛选器可以访问的终端列表
::netsh ipsec static add filter filterlist = 可访问的终端列表 Srcaddr = 203.86.31.0 srcmask=255.255.255.0 dstaddr = 60.190.145.9 dstport = 0 description = 部门2访问 protocol =any mirrored = yes
if %n% == 10 (echo 请您继续按键选择^(这将回退到主进程^)或按ctrlc结束批处理或直接关闭窗口
exit
)
pause
call %0
:close2
echo --------------------------------------------------wf.msc高级安全防火墙阻断需要打开防火墙-----------------------------------------------------------
netsh advfirewall firewall add rule name="wanna"      protocol=TCP dir=in localport=135,137,138,139,445 action=block
netsh advfirewall firewall add rule name="wanna_U" protocol=UDP dir=in localport=137,138 action=block
echo 135,137,138,139,445(TCP)137,138(UDP)已封堵 打开防火墙生效 正在为您打开防火墙
netsh firewall set opmode mode=enable
rem netsh advfirewall show allprofiles
rem netsh advfirewall set currentprofile state on
pause
exit

:open
rem 策略指派移除
netsh ipsec static ^
	set policy name = SECCPP assign = n && echo 指派策略不生效 端口已打开请测试业务是否正常！
choice /d N /t 5 /m 是否删除安全SECPP策略(默认N:不删除)
if errorlevel 2 (echo 不删除策略,仅取消指派策略)
if errorlevel 1 ( netsh ipsec static delete policy name = SECCPP && echo SECCPP策略已删除 )
	 
pause
exit