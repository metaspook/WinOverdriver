:: WinOverdriver.
:: Version: 1.0
:: Written by Metaspook
:: License: <http://opensource.org/licenses/MIT>
:: Copyright (c) 2019 Metaspook.
:: 
@echo off

::
:: REQUESTING ADMINISTRATIVE PRIVILEGES
::
>nul 2>&1 reg query "HKU\S-1-5-19\Environment"
if '%errorlevel%' NEQ '0' (
	(echo.Set UAC = CreateObject^("Shell.Application"^)&echo.UAC.ShellExecute "%~s0", "", "", "runas", 1)>"%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	exit /B
) else ( >nul 2>&1 del "%temp%\getadmin.vbs" )

::
:: MAIN SCRIPT STARTS BELOW
::
title "WinOverdriver"
color 0B
pushd "%~dp0"
set APPVAR=1.0
mode con: cols=50 lines=25

:CHOICE_MENU
call:BANNER                       
echo   ================ OPTION MENU ===============
echo                ^|                 ^|
echo    1. Disable. ^|  2. [Re]Enable. ^|  0. Exit.
echo                ^|                 ^| 
echo   ============================================
echo.
echo  NOTE: Works till next boot.
echo USAGE: Type a number below and press Enter key.
echo.
set CMVAR=
set /p "CMVAR=Enter Option: "
if "%CMVAR%"=="0" exit
if "%CMVAR%"=="1" (
	call:BANNER
	>nul 2>&1 bcdedit.exe -set loadoptions DISABLE_INTEGRITY_CHECKS
	>nul 2>&1 bcdedit.exe -set TESTSIGNING ON
	echo [DONE] Drivers signature verification disabled!
	>nul 2>&1 timeout /t 2
	goto:CHOICE_MENU
)
if "%CMVAR%"=="2" (
	call:BANNER
	>nul 2>&1 bcdedit.exe -set loadoptions DISABLE_INTEGRITY_CHECKS
	>nul 2>&1 bcdedit.exe -set TESTSIGNING OFF
	echo [DONE] Drivers signature verification enabled!
	>nul 2>&1 timeout /t 2
	goto:CHOICE_MENU
)

:BANNER
cls                   
echo                       _______________
echo                WinOverdriver v%APPVAR%    \__ 
echo         \\  Written by Metaspook     /  \ 
echo          \\_____________________     \__/
echo.&echo.&echo.&echo.
goto:eof
