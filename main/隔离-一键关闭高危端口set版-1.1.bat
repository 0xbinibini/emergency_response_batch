rem chcp 65001
color 3f & title ipsec�رո�Σ�˿�
Setlocal enabledelayedexpansion
@echo off

rem if exist $.d goto close & del $.d
del $.t
netsh ipsec static show policy name=SECCPP | findstr "SECCPP" > nul
if %errorlevel%==0 (
choice /d N /t 3 /m ���иð�ȫ������Ȼ��Ҫִ��ô��
if !errorlevel!==2 echo ���� & pause & exit
if !errorlevel!==1 goto gogo
)

rem һ���رո�Σ�˿� ��Win10ֱ������������ᱨ��(���������˳��ִ��)�ݲ�֪Ϊ��
set /a n=10
%1start /b  %~s0 :&pause>nul &cd.>$.t && timeout /t 1 >nul&start /b del $.t ^&exit&timeout /t 1 & goto gogo
rem del $.t

:loop
if exist $.t (echo ֹͣ��Ҫ����ѡ��-�����˳������ڻص�������  &exit)
timeout /t 1 >nul
cls
echo ----------------------------------���ϰ汾 ===^>^>by binibini----------------------------------------------
echo 1:	��ʱ���һ�п��ܴ�����Դ һ���ر�135 137 138 139 445Σ�ն˿�
echo 2:	������ɱ�����©�����޲������Ѱ�װ ҵ����Ҫ�������˿���ѡ��
echo 3: 	������ȫ����
echo 4:	���밲ȫ����
echo --------------------------------%n%���Ĭ��ѡ��1�ŷ���-------------------------------------------------------
if %n%==0 (echo ʱ�䵽��ѡ��Ĭ��1�ŷ���&set input=1 && goto close )
set /a n=n-1
goto loop

:gogo
rem echo %input%
cls
echo ----------------------------------���ϰ汾 ===^>^>by binibini----------------------------------------------
echo 1:	��ʱ���һ�п��ܴ�����Դ һ���ر�135 137 138 139 445Σ�ն˿�
echo 2:	������ɱ�����©�����޲������Ѱ�װ ҵ����Ҫ�������˿���ѡ��
echo 3:	������ȫ����
echo 4:	���밲ȫ����
echo 5: 	�˳�
set /p input=[�ȴ�����ѡ��]
goto process

:process
rem echo %input% 
rem pause
if %input%==5 goto bye
if %input%==1 goto close
if %input%==2 goto open
if %input%==3 goto exp
if %input%==4 (goto inp) else (
echo ��Ų���������
call %0
pause 
exit /b
)

:bye
exit
rem ::����IPsec��ȫ����
:exp
netsh ipsec static exportpolicy file = ./ipsec.ipsec && echo �����ɹ� && timeout /T 3 /NOBREAK && exit /b
rem ::����IPsec��ȫ����
:inp
netsh ipsec static importpolicy file = ./ipsec.ipsec && echo ����ɹ� && timeout /T 3 /NOBREAK && exit /b

:close
rem ����IPsec Policy Agent���� һ��Ĭ�϶��ǿ�����
rem sc query policyagent | findstr /I "running"
rem sc config policyagent start = auto
rem net start policyagent
ver | findstr /I "xp"
if %errorlevel% == 0 (
echo ���ϵ�XPϵͳ��x86ʱ�ǲ�֧��netsh ipsec�������Ҫ��ipseccmd����
::2000����ipsecpol ̫�����˾Ͳ�֧����
if %PROCESSOR_ARCHITECTURE% == x86 goto close_86xp
)
choice /t 5 /d Y /m Y:ipcsecģʽ����N:�߼�����ǽ����^(Ĭ��Y^)
if %errorlevel%==1 goto close1
if %errorlevel%==2 goto close2
:close_86xp
::-w REG �ò�������д��ע�����������Ȼ��Ч
rem ipseccmd -w REG -p "Block default ports" -r "Block TCP/135" -f *+0:135:TCP -n BLOCK -x 
::-f��ʽA.B.C.D/mask:port=A.B.C.D/mask:port:protocol �Ϸ�ʹ��+�Ŵ���˫��IP��ַ����*�����κ�IP��ַ��0�������Լ���IP��ַ��������ʹ��ͨ��� -n ָ��������������BLOCK��PASS����INPASS�������д��-x���� -y��Ч -oɾ��-pָ���Ĳ���
ipseccmd -p "SECCPP" -r "Block TCP/135" -f *=0:135:TCP -n BLOCK -x
ipseccmd -p "SECCPP" -r "Block TCP/137" -f *=0:135:TCP -n BLOCK -x
ipseccmd -p "SECCPP" -r "Block TCP/138" -f *=0:135:TCP -n BLOCK -x
ipseccmd -p "SECCPP" -r "Block TCP/139" -f *=0:135:TCP -n BLOCK -x
ipseccmd -p "SECCPP" -r "Block TCP/445" -f *=0:135:UDP -n BLOCK -x
ipseccmd -p "SECCPP" -r "Block UDP/137" -f *=0:135:UDP -n BLOCK -x
ipseccmd -p "SECCPP" -r "Block UDP/138" -f *=0:135:UDP -n BLOCK -x
if %n% == 10 (echo ������������ѡ��^(�⽫���˵�������^)��ctrlc�����������ֱ�ӹرմ���
exit)
pause
call %0
:close1
::ɾ��ԭ�еĿ�����ΪSECCPP�İ�ȫ����
netsh ipsec static delete policy name = SECCPP
::����һ����̬��ip��ȫ���� ��������secpol.msc->IP��ȫ���Բ鿴
echo ����һ����ȫ����
netsh ipsec static add policy name = SECCPP description=��ȫ����201705
echo �������ɸѡ��������Ϻ�����
netsh ipsec static add filteraction name = Permitted action = permit description=����
netsh ipsec static add filteraction name = Blocked action = block description=����

echo ����ɸѡ���б���Կ�Ϊip��
netsh ipsec static delete filterlist name = wanna
netsh ipsec static add filterlist name = wanna description=��ֹ�ٴθ�Ⱦ
echo ��ֹ�κ�Դ��ַ���ʵ������135 137 138 139 445(tcp) 137 138(UDP)
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 135 protocol = TCP && echo ����135tcp��������б�
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 137 protocol = TCP && echo ����137tcp��������б�
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 138 protocol = TCP && echo ����138tcp��������б�
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 139 protocol = TCP && echo ����139tcp��������б�
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 445 protocol = TCP description = ban && echo ����445tcp��������б�
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 137 protocol = UDP && echo ����137udp��������б�
netsh ipsec static add filter filterlist = wanna srcaddr=Any dstaddr = Me dstport = 138 protocol = UDP && echo ����138udp��������б�
echo �������Թ���
netsh ipsec static add rule name=SECCPR policy=SECCPP filterlist=wanna filteraction=Blocked
echo ָ�ɲ�����Ч
netsh ipsec static set policy name = SECCPP assign = y && echo ����ָ����Ч����ϴ�����Դ ��Ҫ���Ǵ򲹶���
::echo ����һ��ɸѡ�����Է��ʵ��ն��б�
::netsh ipsec static add filter filterlist = �ɷ��ʵ��ն��б� Srcaddr = 203.86.31.0 srcmask=255.255.255.0 dstaddr = 60.190.145.9 dstport = 0 description = ����2���� protocol =any mirrored = yes
if %n% == 10 (echo ������������ѡ��^(�⽫���˵�������^)��ctrlc�����������ֱ�ӹرմ���
exit
)
pause
call %0
:close2
echo --------------------------------------------------wf.msc�߼���ȫ����ǽ�����Ҫ�򿪷���ǽ-----------------------------------------------------------
netsh advfirewall firewall add rule name="wanna"      protocol=TCP dir=in localport=135,137,138,139,445 action=block
netsh advfirewall firewall add rule name="wanna_U" protocol=UDP dir=in localport=137,138 action=block
echo 135,137,138,139,445(TCP)137,138(UDP)�ѷ�� �򿪷���ǽ��Ч ����Ϊ���򿪷���ǽ
netsh firewall set opmode mode=enable
rem netsh advfirewall show allprofiles
rem netsh advfirewall set currentprofile state on
if %n% == 10 (echo ������������ѡ��^(�⽫���˵�������^)��ctrlc�����������ֱ�ӹرմ���
exit
)
pause
call %0

:open
rem ����ָ���Ƴ�
netsh ipsec static set policy name = SECCPP assign = n && echo ָ�ɲ��Բ���Ч �˿��Ѵ������ҵ���Ƿ�������
choice /d N /t 5 /m �Ƿ�ɾ����ȫSECPP����(Ĭ��N:��ɾ��)
if errorlevel 2 (echo ��ɾ������,��ȡ��ָ�ɲ���)
if errorlevel 1 ( netsh ipsec static delete policy name = SECCPP && echo SECCPP������ɾ�� )	 
call %0