@ECHO OFF
cls
ECHO shazam_offline_chkdsk.bat utility script - prepared by Kelvin D. Meeks
ECHO Purpose: Run an offline chkdsk command to repair a drive 
ECHO https://github.com/intltechventures/Personal.Windows.Utils/blob/master/shazam.bat
ECHO Version: 1.0.0, 2023-09-16
ECHO.
ECHO.
ECHO =======================================================================================
ECHO Scan and Fix any Disk Errors
REM OFF
REM https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk?tabs=event-viewer
REM ON 
ECHO 	Command: chkdsk /scan /perf /sdcleanup
chkdsk c: /scan /perf /sdcleanup /forceofflinefix /offlinescanandfix 
