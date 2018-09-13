@echo off

cd vagrant_dir

vagrant up

start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://192.168.33.10:8888"

:LOOP
set /p answer="Vagrant Halt?(y/n): %answer%"
if "%answer%"=="y" (goto EXIT)
goto LOOP
:EXIT

vagrant halt
