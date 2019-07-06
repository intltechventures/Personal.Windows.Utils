@ECHO OFF
cls
REM 
REM ***************************************************************************
REM Shazam Script - Automated Rescue Steps for a Corrupted Windows System
REM Author: Kelvin D. Meeks
REM Email: kmeeks@intltechventures.com 
REM Created: 2019-07-01
REM Version: 1.3, 2019-07-06
REM International Technology Ventures, Inc.
REM https://www.intltechventures.com
REM
REM
REM DISCLAIMER:
REM
REM There are inherent dangers in the use of any software available for download on the Internet, and we caution you to make sure that you completely understand the potential risks before downloading any software.
REM 
REM The Software and code samples available on this website are provided "as is" without warranty of any kind, either express or implied. 
REM Use at your own risk.
REM 
REM The use of the software and scripts downloaded on this site is done at your own discretion and risk and with agreement that you will be solely responsible for any damage to your computer system or loss of data that results from such activities. You are solely responsible for adequate protection and backup of the data and equipment used in connection with any of the software, and we will not be liable for any damages that you may suffer in connection with using, modifying or distributing any of this software. No advice or information, whether oral or written, obtained by you from us or from this website shall create any warranty for the software.
REM
REM We make makes no warranty that:
REM
REM - The software will meet your requirements
REM - The software will be uninterrupted, timely, secure or error-free
REM - The results that may be obtained from the use of the software will be effective, accurate or reliable
REM - The quality of the software will meet your expectations
REM - Any errors in the software obtained from us will be corrected.
REM   
REM The software, code sample and their documentation made available on this website:
REM 
REM - Could include technical or other mistakes, inaccuracies or typographical errors. We may make changes to the software or documentation made available on its web site at any time without prior-notice.
REM - May be out of date, and we make no commitment to update such materials.
REM
REM We assume no responsibility for errors or omissions in the software or documentation available from its web site.
REM 
REM In no event shall we be liable to you or any third parties for any special, punitive, incidental, indirect or consequential damages of any kind, or any damages whatsoever, including, without limitation, those resulting from loss of use, data or profits, and on any theory of liability, arising out of or in connection with the use of this software.
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
ECHO STEP-3.0: Scan and Fix any Disk Errors
ECHO 	Command: chkdsk /scan /perf
chkdsk c: /scan /perf /V  
pause 



ECHO.
ECHO ======================================================================================= 
ECHO STEP-4.0: Anti-Virus Scan 

ECHO.
ECHO STEP-4.1: Update Anti-Virus Signature Definitions
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate

ECHO.
ECHO STEP-4.2: Run Full Anti-Virus Scan
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanTpe 2



ECHO.
ECHO =======================================================================================
ECHO STEP-5.0: Run DISM to repair an image of Windows 10

ECHO.
ECHO =======================================================================================
ECHO 5.1) First, Check health of Windows Image, 
ECHO 	Command: DISM.exe /Online /Cleanup-image /ScanHealth
ECHO    Command: DISM.exe /Online /Cleanup-image /CheckHealth
DISM.exe /Online /Cleanup-image /ScanHealth
DISM.exe /Online /Cleanup-image /CheckHealth
pause


ECHO.
ECHO =======================================================================================
ECHO 5.2) Second, Restore health of Windows Image, 
ECHO 	Command: DISM.exe /Online /Cleanup-image /RestoreHealth
DISM.exe /Online /Cleanup-image /RestoreHealth
pause


ECHO.
ECHO =======================================================================================
ECHO STEP-6.0: Run SFC to repair installation problems of Windows 10
ECHO	Command: sfc/scannow  
sfc /scannow
pause

ECHO.
ECHO =======================================================================================
ECHO STEP-7.0: Force Windows Update
ECHO    Command: wuauclt.exe /detectnow
ECHO	Command: wuauclt.exe /updatenow
PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()   
wuauclt.exe /detectnow  
pause
wuauclt.exe /updatenow
pause


ECHO.
ECHO =======================================================================================
ECHO STEP-8.0: Check systeminfo after forced update...
systeminfo 
pause

ECHO.
ECHO =======================================================================================
ECHO STEP-9.0: REVIEW Windows Update results in %windir%/Logs/CBS/CBS.log
pause
findstr /c:"[SR]" "%windir%\Logs\CBS\CBS.log" > "%userprofile%\Desktop\sfcdetails.txt" 
more "%userprofile%\Desktop\sfcdetails.txt"


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

