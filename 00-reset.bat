@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=Are you sure you want to delete your Ubuntu instance and start over (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

wsl --terminate Ubuntu
wsl --unregister Ubuntu

:END
endlocal
