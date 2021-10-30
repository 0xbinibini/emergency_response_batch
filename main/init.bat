rem @echo off
if exist ..\tools\Ddun\D_Safe_Manage.exe (
	echo 检测到存在D盾工具将会加载 && set Ddun=1
) else (
if exist ..\arichive2tools\Ddun\d_safe_*.zip (
	echo 检测到存在D盾工具压缩包将为您解压 && set Ddun=1 && start cmd  /k "7zG.exe x "..\arichive2tools\Ddun\d_safe_2.1.6.1_0705.zip" -o"..\tools\Ddun""
	)
)
if exist ..\tools\Autoruns\Autoruns.exe (
	echo 检测到存在微软Autoruns工具将会加载 && set Autoruns=1
) else (
if exist ..\arichive2tools\Autoruns\*.zip (
	echo 检测到存在微软Autoruns压缩包将为您解压 && set Autoruns=1 && start cmd  /k "7zG.exe x "..\arichive2tools\Autoruns\*.zip" -o"..\tools\Autoruns""
	)
)
if exist ..\tools\Logparser\LogParser.exe (
	echo 检测到存在Logparser工具将会加载 && set Logparser=1
) else (
if exist ..\arichive2tools\Logparser\*.zip (
	echo 检测到存在Logparser压缩包将为您解压 && set Logparser=1 && start cmd  /k "7zG.exe x "..\arichive2tools\Logparser\*.zip" -o"..\tools\Logparser""
	)
)
if exist ..\tools\Windows_Collector_v1106_NEW\SglabIr_Collector_*.exe (
	echo 检测到存在观星分析工具将会加载 && set gxsj=1
) else (
if exist ..\arichive2tools\Windows_Collector_v1106_NEW\*.zip (
	echo 检测到存在观星分析工具压缩包将为您解压 && set gxsj=1 && start cmd  /k "7zG.exe x "..\arichive2tools\Windows_Collector_v1106_NEW\*.zip" -o"..\tools\Windows_Collector_v1106_NEW""
	)
)

rem pause