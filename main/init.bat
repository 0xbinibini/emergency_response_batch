rem @echo off
if exist ..\tools\Ddun\D_Safe_Manage.exe (
	echo ��⵽����D�ܹ��߽������ && set Ddun=1
) else (
if exist ..\arichive2tools\Ddun\d_safe_*.zip (
	echo ��⵽����D�ܹ���ѹ������Ϊ����ѹ && set Ddun=1 && start cmd  /k "7zG.exe x "..\arichive2tools\Ddun\d_safe_2.1.6.1_0705.zip" -o"..\tools\Ddun""
	)
)
if exist ..\tools\Autoruns\Autoruns.exe (
	echo ��⵽����΢��Autoruns���߽������ && set Autoruns=1
) else (
if exist ..\arichive2tools\Autoruns\*.zip (
	echo ��⵽����΢��Autorunsѹ������Ϊ����ѹ && set Autoruns=1 && start cmd  /k "7zG.exe x "..\arichive2tools\Autoruns\*.zip" -o"..\tools\Autoruns""
	)
)
if exist ..\tools\Logparser\LogParser.exe (
	echo ��⵽����Logparser���߽������ && set Logparser=1
) else (
if exist ..\arichive2tools\Logparser\*.zip (
	echo ��⵽����Logparserѹ������Ϊ����ѹ && set Logparser=1 && start cmd  /k "7zG.exe x "..\arichive2tools\Logparser\*.zip" -o"..\tools\Logparser""
	)
)
if exist ..\tools\Windows_Collector_v1106_NEW\SglabIr_Collector_*.exe (
	echo ��⵽���ڹ��Ƿ������߽������ && set gxsj=1
) else (
if exist ..\arichive2tools\Windows_Collector_v1106_NEW\*.zip (
	echo ��⵽���ڹ��Ƿ�������ѹ������Ϊ����ѹ && set gxsj=1 && start cmd  /k "7zG.exe x "..\arichive2tools\Windows_Collector_v1106_NEW\*.zip" -o"..\tools\Windows_Collector_v1106_NEW""
	)
)

rem pause