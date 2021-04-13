@ECHO OFF
cls
REM 
REM ***************************************************************************
REM Shazam Script - Disk Cleanup
REM Author: Kelvin D. Meeks
REM Email: kmeeks@intltechventures.com 
REM Created: 2021-04-04
REM Updated: 2021-04-04
REM Version: 1.0.0
REM
REM Github Location:
REM https://github.com/intltechventures/Personal.Windows.Utils/blob/master/shazam_disk_cleanup.bat
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

REM
REM https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/clean-up-the-winsxs-folder
REM 

ECHO.
ECHO Using the /StartComponentCleanup parameter of Dism.exe on a running version of Windows 10 gives you similar results to running the StartComponentCleanup task in Task Scheduler, except previous versions of updated components will be immediately deleted (without a 30 day grace period) and you will not have a 1-hour timeout limitation.
ECHO.
ECHO Dism.exe /online /Cleanup-Image /StartComponentCleanup
ECHO.
pause
Dism.exe /online /Cleanup-Image /StartComponentCleanup


ECHO.
ECHO Using the /ResetBase switch with the /StartComponentCleanup parameter of DISM.exe on a running version of Windows 10 removes all superseded versions of every component in the component store.
ECHO WARNING: All existing service packs and updates cannot be uninstalled after this command is completed. This will not block the uninstallation of future service packs or updates.
ECHO.
ECHO Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
ECHO.
pause
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase


ECHO.
ECHO To reduce the amount of space used by a Service Pack, use the /SPSuperseded parameter of Dism.exe on a running version of Windows 10 to remove any backup components needed for uninstallation of the service pack. A service pack is a collection of cumulative updates for a particular release of Windows.
ECHO.
ECHO Dism.exe /online /Cleanup-Image /SPSuperseded
ECHO.
pause
Dism.exe /online /Cleanup-Image /SPSuperseded



ECHO.
ECHO Check C:\Users\Kelvin\AppData\Local\CrashDumps
ECHO. 
pushd
c:
cd C:\Users\Kelvin\AppData\Local\CrashDumps
ls -lsa 
pause
popd



