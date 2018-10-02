:: WinOverdriver.
:: Version: 1.0
:: Written by Metaspook
:: License: <http://opensource.org/licenses/MIT>
:: Copyright (c) 2018 Metaspook.
:: 
@echo off

::
:: REQUESTING ADMINISTRATIVE PRIVILEGES
::
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
	(echo.Set UAC = CreateObject^("Shell.Application"^)&echo.UAC.ShellExecute "%~s0", "", "", "runas", 1)>"%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	exit /B
) else ( >nul 2>&1 del "%temp%\getadmin.vbs" )


::
:: MAIN SCRIPT STARTS BELOW
::
mode con: cols=56 lines=25
title "WinOverdriver"
pushd "%~dp0"

:MAINMENU
call:BANNER
echo.
echo    1. Disable. ^| 2. [Re]Enable. ^| 0. Exit  
echo.
set /p input=Enter Option: 
if %input% == 1 goto:AddEnv
if %input% == 2 goto:RmvEnv
if %input% == 0 exit
goto:MAINMENU

:AddEnv
call:BANNER
echo.
echo [DONE] Drivers signature verification disabled!
>nul 2>&1 bcdedit.exe -set loadoptions DISABLE_INTEGRITY_CHECKS
>nul 2>&1 bcdedit.exe -set TESTSIGNING ON
>nul 2>&1 timeout /t 2
goto:MAINMENU

:RmvEnv
call:BANNER
echo.
echo [DONE] Drivers signature verification enabled!
>nul 2>&1 bcdedit.exe -set loadoptions DISABLE_INTEGRITY_CHECKS
>nul 2>&1 bcdedit.exe -set TESTSIGNING OFF
>nul 2>&1 timeout /t 2
goto:MAINMENU

:BANNER
cls
echo.
echo    _____________________________________________
echo                       WinOverdriver             \\
echo         \ Drivers signature verification changer \__
echo          \          Written by Metaspook         /  \
echo           \\_____________________________________\__/
echo.
goto:eof
