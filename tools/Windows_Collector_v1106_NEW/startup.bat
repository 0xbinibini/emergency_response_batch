@echo off
title 自动日志收集器
cd %~dp0
if %PROCESSOR_ARCHITECTURE% NEQ AMD64 (echo 在日志收集成功前请不要关闭此框 && start /b /wait SglabIr_Collector_X86.exe) else (echo 在日志收集成功前请不要关闭此框 && start /b /wait SglabIr_Collector_X64.exe)
if exist Output\*.zip (md ..\..\main\evtx\%COMPUTERNAME% & move Output\*.zip ..\..\main\evtx\%COMPUTERNAME%\)



pause