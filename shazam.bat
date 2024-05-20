@ECHO OFF
cls
ECHO Shazam Script utility - prepared by Kelvin D. Meeks
ECHO Purpose: Automated rescue steps for cleaning-up a corrupted Microsoft Windows system
ECHO https://github.com/intltechventures/Personal.Windows.Utils/blob/master/shazam.bat
ECHO Version: 1.4.0, 2023-09-16
ECHO.
REM OFF 
REM 
REM ***************************************************************************
REM Shazam Script - Automated Rescue Steps for a Corrupted Windows System
REM Author: Kelvin D. Meeks
REM Email: kmeeks@intltechventures.com 
REM Created: 2019-07-01
REM
REM Github Location:
REM https://github.com/intltechventures/Personal.Windows.Utils/blob/master/shazam.bat
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
REM ON 
ECHO Save current directory location, then switch to C:\
pushd .
c:
cd \
ECHO.
ECHO NOTE: You must run this as an Administrator
ECHO.
ECHO You should make a full backup of your computer before proceeding with running this script
pause


ECHO.
ECHO.
ECHO =======================================================================================
ECHO STEP-1.0: Check systeminfo before starting clean-up steps...
pause
systeminfo 




ECHO.
ECHO =======================================================================================
ECHO STEP-2: Create Restore Point
ECHO 	Command: Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE% Shazam Script - Restore Point Created", 100, 1
pause
Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE% Shazam Script - Restore Point Created", 100, 1 




ECHO.
ECHO.
ECHO =======================================================================================
ECHO STEP-3.0: Scan and Fix any Disk Errors
REM OFF
REM https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk?tabs=event-viewer
REM ON 
ECHO 	Command: chkdsk /scan /perf 
pause
chkdsk c: /scan /perf 
 


ECHO.
ECHO.
ECHO ======================================================================================= 
ECHO STEP-4.0: Anti-Virus Scan 

ECHO.
ECHO STEP-4.1: Update Anti-Virus Signature Definitions
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate

ECHO.
ECHO STEP-4.2: Run Full Anti-Virus Scan
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2


ECHO.
ECHO.
ECHO =======================================================================================
ECHO STEP-5.0: Run DISM to repair an image of Windows 10
REM OFF 
REM https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/deployment-image-servicing-and-management--dism--command-line-options?view=windows-10
REM https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image
REM https://win10.guru/dism-whats-the-difference-between-scanhealth-and-checkhealth/
REM ON 
ECHO.
ECHO =======================================================================================
ECHO 5.1) First, Check health of Windows Image:

pause 
ECHO 5.1a) [re: fast check], DISM.exe /Online /Cleanup-Image /CheckHealth 
DISM.exe /Online /Cleanup-Image /CheckHealth
 
ECHO.
ECHO. 
ECHO 5.1b) [re: deep check], DISM.exe /Online /Cleanup-Image /ScanHealth 
pause
DISM.exe /Online /Cleanup-Image /ScanHealth


ECHO. 
ECHO.
ECHO 5.1c) DISM.exe /Online /Cleanup-image /RestoreHealth
pause 
DISM.exe /Online /Cleanup-image /RestoreHealth

ECHO .
ECHO .
ECHO 5.1c) DISM.exe /Online /Cleanup-image /startcomponentcleanup
pause 
dism.exe /Online /Cleanup-image /startcomponentcleanup


ECHO.
ECHO =======================================================================================
ECHO STEP-6.0: Force Windows Update
ECHO. 
ECHO    Command: wuauclt.exe /detectnow
pause
PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()   
wuauclt.exe /detectnow  

ECHO. 
ECHO. 
ECHO	Command: wuauclt.exe /updatenow
pause
wuauclt.exe /updatenow


ECHO. 
ECHO.
ECHO =======================================================================================
ECHO STEP-7.0: Run SFC to repair installation problems of Windows 10
REM OFF
REM https://support.microsoft.com/en-us/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e
REM ON  
ECHO. 
ECHO	Command: sfc /scannow  
pause 
sfc /scannow


ECHO.
ECHO.
ECHO =======================================================================================
ECHO STEP-8.0: Check systeminfo after forced update...
pause
systeminfo 


ECHO.
ECHO.
ECHO =======================================================================================
ECHO STEP-9.0: REVIEW Windows Update results in %windir%/Logs/CBS/CBS.log
ECHO.
pause
findstr /c:"[SR]" "%windir%\Logs\CBS\CBS.log" > "%userprofile%\Desktop\sfcdetails.txt" 
more "%userprofile%\Desktop\sfcdetails.txt"


:FINISHED
ECHO.
ECHO =======================================================================================
ECHO Shazam Script Completed!
ECHO.
ECHO.
ECHO Return to previous directory location 
popd
goto EXIT 


REM OFF 
REM Some helpful articles:
REM
REM https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/command-line-arguments-windows-defender-antivirus
REM https://github.com/MicrosoftDocs/windows-itpro-docs/blob/master/windows/security/threat-protection/windows-defender-antivirus/command-line-arguments-windows-defender-antivirus.md
REM https://www.windowscentral.com/how-use-windows-defender-command-prompt-windows-10
REM https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/repair-a-windows-image
REM https://support.microsoft.com/en-us/help/10164/fix-windows-update-errors
REM https://support.microsoft.com/en-us/help/947821/fix-windows-update-errors-by-using-the-dism-or-system-update-readiness
REM https://venturebeat.com/2015/07/28/how-to-force-windows-to-start-downloading-the-windows-10-update-files/
REM https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image
REM https://support.microsoft.com/en-us/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system
REM https://social.technet.microsoft.com/Forums/Lync/en-US/7289c393-5ca0-44dd-8ac9-02f1144503d3/wuaucltexe-vs-check-for-updates?forum=winserverwsus
RE MON 

:EXIT 

