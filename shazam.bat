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
ECHO (NOTE: You must run this as an Administrator)
ECHO.
ECHO You should make a full backup of your computer before proceeding with running this script
pause



ECHO.
ECHO =======================================================================================
ECHO STEP-1.0: Check systeminfo before starting clean-up steps...
systeminfo 
pause


ECHO.
ECHO =======================================================================================
ECHO STEP-2: Create Restore Point
ECHO 	Command: Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE% Shazam Restore Point Created", 100, 1
Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE% Shazam Script - Restore Point Created", 100, 1 
pause



ECHO.
ECHO =======================================================================================
ECHO STEP-3.0: 
ECHO 	Command: chkdsk /scan /perf
chkdsk c: /scan /perf  
pause 


ECHO.
ECHO =======================================================================================
ECHO STEP-4.0: Run DISM to repair an image of Windows 10

ECHO.
ECHO =======================================================================================
ECHO 4.1) First, Check health of Windows Image, 
ECHO 	Command: DISM.exe /Online /Cleanup-image /ScanHealth
ECHO    Command: DISM.exe /Online /Cleanup-image /CheckHealth
DISM.exe /Online /Cleanup-image /ScanHealth
DISM.exe /Online /Cleanup-image /CheckHealth
pause


ECHO.
ECHO =======================================================================================
ECHO 4.2) Second, Restore health of Windows Image, 
ECHO 	Command: DISM.exe /Online /Cleanup-image /RestoreHealth
DISM.exe /Online /Cleanup-image /RestoreHealth
pause


ECHO.
ECHO =======================================================================================
ECHO STEP-5.0: Run SFC to repair installation problems of Windows 10
ECHO	Command: sfc/scannow  
sfc /scannow
pause

ECHO.
ECHO =======================================================================================
ECHO STEP-6.0: Force Windows Update
ECHO    Command: wuauclt.exe /detectnow
ECHO	Command: wuauclt.exe /updatenow
PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()   
wuauclt.exe /detectnow  
pause
wuauclt.exe /updatenow
pause


ECHO.
ECHO =======================================================================================
ECHO STEP-7.0: Check systeminfo after forced update...
systeminfo 
pause

ECHO.
ECHO =======================================================================================
ECHO STEP-8.0: REVIEW Windows Update results in %windir%/Logs/CBS/CBS.log
pause
findstr /c:"[SR]" %windir%\Logs\CBS\CBS.log > "%userprofile%\Desktop\sfcdetails.txt" 
more %userprofile%\Desktop\sfcdetails.txt


:FINISHED
ECHO.
ECHO =======================================================================================
ECHO Shazam Script Completed!
popd
goto EXIT 

REM Some helpful articles:
REM
REM https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/repair-a-windows-image
REM https://support.microsoft.com/en-us/help/10164/fix-windows-update-errors
REM https://support.microsoft.com/en-us/help/947821/fix-windows-update-errors-by-using-the-dism-or-system-update-readiness
REM https://venturebeat.com/2015/07/28/how-to-force-windows-to-start-downloading-the-windows-10-update-files/
REM https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image
REM https://support.microsoft.com/en-us/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system
REM https://social.technet.microsoft.com/Forums/Lync/en-US/7289c393-5ca0-44dd-8ac9-02f1144503d3/wuaucltexe-vs-check-for-updates?forum=winserverwsus


:EXIT 

