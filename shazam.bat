@ECHO OFF
cls
REM 
REM ***************************************************************************
REM Shazam Script - Automated Rescue Steps for a Corrupted Windows System
REM Author: Kelvin D. Meeks
REM Email: kmeeks@intltechventures.com 
REM Created: 2019-07-01
REM International Technology Ventures, Inc.
REM https://www.intltechventures.com
REM ***************************************************************************
REM 
pushd .
c:
cd \
ECHO.
ECHO My "Shazam" Script - Automated Rescue Steps for Cleaning-up a Corrupted Windows System
ECHO.
ECHO You should make a full backup of your computer before proceeding with running this script
pause


ECHO.
ECHO STEP-1.0: 
ECHO 	- Command: chkdsk /scan /perf
pause
chkdsk c: /scan /perf


ECHO.
ECHO STEP-2: Run DISM to repair an image of Windows 10
ECHO 	- 2.1) First, Check health of Windows Image, 
ECHO 	- Command: DISM.exe /Online /Cleanup-image /CheckHealth
pause
DISM.exe /Online /Cleanup-image /CheckHealth

ECHO 	- 2.2) Second, Restore health of Windows Image, 
ECHO 	- Command: DISM.exe /Online /Cleanup-image /RestoreHealth
pause
DISM.exe /Online /Cleanup-image /Restorehealth

ECHO.
ECHO STEP-3.0: Run SFC to repair installation problems of Windows 10
ECHO	- Command: sfc/scannow
pause
sfc /scannow

ECHO.
ECHO STEP-4:
ECHO 	- Force Windows Update
ECHO	- Command: wuauclt.exe /updatenow
pause 
REM wuauclt.exe /updatenow
PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()
wuauclt.exe /detectnow

ECHO.
ECHO STEP-5:
ECHO	- REVIEW Windows Update %windir%/Logs/CBS/CBS.log
pause
findstr /c:"[SR]" %windir%\Logs\CBS\CBS.log >"%userprofile%\Desktop\sfcdetails.txt" 
more %userprofile%\Desktop\sfcdetails.txt

:FINISHED
ECHO.
ECHO Shazam Script Completed!
popd
goto EXIT 

REM Some helpful articles
REM https://support.microsoft.com/en-us/help/947821/fix-windows-update-errors-by-using-the-dism-or-system-update-readiness
REM https://venturebeat.com/2015/07/28/how-to-force-windows-to-start-downloading-the-windows-10-update-files/
REM https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image
REM https://support.microsoft.com/en-us/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system
REM https://social.technet.microsoft.com/Forums/Lync/en-US/7289c393-5ca0-44dd-8ac9-02f1144503d3/wuaucltexe-vs-check-for-updates?forum=winserverwsus


:EXIT 
