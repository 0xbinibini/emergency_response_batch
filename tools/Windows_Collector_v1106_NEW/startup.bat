@echo off
title �Զ���־�ռ���
cd %~dp0
if %PROCESSOR_ARCHITECTURE% NEQ AMD64 (echo ����־�ռ��ɹ�ǰ�벻Ҫ�رմ˿� && start /b /wait SglabIr_Collector_X86.exe) else (echo ����־�ռ��ɹ�ǰ�벻Ҫ�رմ˿� && start /b /wait SglabIr_Collector_X64.exe)
if exist Output\*.zip (md ..\..\main\evtx\%COMPUTERNAME% & move Output\*.zip ..\..\main\evtx\%COMPUTERNAME%\)



pause