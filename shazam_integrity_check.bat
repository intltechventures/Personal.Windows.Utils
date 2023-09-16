@ECHO OFF
cls
c:
cd \

ECHO. 
ECHO. 
ECHO Shazam Integrity Check utility script 
ECHO - Author: Kelvin D. Meeks
ECHO - https://github.com/intltechventures/Personal.Windows.Utils
ECHO - Last Updated: 2023-09-16 

ECHO. 
ECHO.  
ECHO **** About to run chkdsk on C:\
ECHO. 
pause
chkdsk c: /scan /perf /V


ECHO.
ECHO.
ECHO =======================================================================================
ECHO **** About to run chkdsk on D:\
REM OFF
REM https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk?tabs=event-viewer
REM ON 
ECHO.
pause 
chkdsk d: /scan /perf


ECHO.
ECHO.
ECHO =======================================================================================
ECHO STEP-7.0: Force Windows Update

ECHO About to execute command: wuauclt.exe /detectnow
pause 
PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()   
wuauclt.exe /detectnow  

ECHO.
ECHO.
ECHO About to execute command: wuauclt.exe /updatenow
pause
wuauclt.exe /updatenow



ECHO.
ECHO.  
ECHO =======================================================================================
ECHO **** About to run DISM.exe commands 
REM OFF 
REM https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/deployment-image-servicing-and-management--dism--command-line-options?view=windows-10
REM ON 
ECHO.
ECHO...fast check: /CheckHealth
pause 
DISM.exe /Online /CheckHealth
ECHO.
ECHO.

ECHO...deep check: /ScanHealth  
pause 
DISM.exe /Online /ScanHealth
ECHO.
ECHO.

ECHO...restore health
pause 
DISM.exe /Online /Cleanup-image /RestoreHealth
ECHO.
ECHO.

ECHO...component cleanup 
pause 
dism.exe /Online /cleanup-image /startcomponentcleanup


ECHO.
ECHO.
ECHO =======================================================================================
ECHO **** About to Run sfc scan...
ECHO.
pause
sfc /scannow





