REM ****************************************************************************
REM shazam_integrity_check.cmd
REM Shazam Integrity Check utility script 
REM 
REM
REM Author: Kelvin D. Meeks
REM kmeeks@intltechventures.com
REM
REM https://www.linkedin.com/in/kelvinmeeks/
REM https://intltechventures.blogspot.com/
REM http://www.intltechventures.com/
REM https://github.com/intltechventures
REM 
REM
REM GitHub Repository:
REM https://github.com/intltechventures/Personal.Windows.Utils
REM 
REM
REM ****************************************************************************
REM Parameter Definitions
REM
:PARAMETER_DEFINITIONS
set JOB_NAME=shazam_integrity_check.cmd 
set VERSION=1.5.0
set LAST_UPDATED=2026-09-18 Fri
set ERROR_MESSAGE=Not Defined 
REM 
REM 
REM ****************************************************************************
REM Step: JOB_INITILIZATION 
REM
:JOB_INITIALIZATION 
@ECHO off
cls
pushd .
c:
cd \

REM 
REM
REM ****************************************************************************
REM Step: JOB_START 
REM 
:JOB_START 
ECHO.
ECHO. 
ECHO Starting %JOB_NAME%, version: %VERSION%
ECHO (Last Updated: %LAST_UPDATED%)
ECHO.
ECHO. 
ECHO Job Step: JOB_START 
powershell -c Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"
ECHO.
ECHO.
ECHO NOTE: You must run this as an Administrator
ECHO.
ECHO WARNING: You should make a full backup of your computer before proceeding with running this script
ECHO CTL-C to ABORT this script. 
ECHO. 
ECHO. 
ECHO Hit [enter] to proceed.
pause 


REM 
REM
REM ****************************************************************************
REM Step: STEP-01-CHKDSK 
REM 
REM References:
REM https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk
REM   /scan     - Use with NTFS only. Runs an online scan on the volume.
REM   /perf     - Use with NTFS only (must be used with /scan). Uses more system resources to complete a scan as fast as possible.
REM   /ver      - Displays the name of each file in every directory as the disk is checked.
REM  
:STEP-01-CHKSDK
ECHO. 
ECHO. 
ECHO ...Step: STEP-01-CHKDSK 
ECHO ...- About to run chkdsk c: /scan /perf /v
ECHO. 
chkdsk c: /scan /perf /v 



REM ******************************************************************************************
REM REFERENCES: 
REM  https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/deployment-image-servicing-and-management--dism--command-line-options?view=windows-10
REM https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image
REM https://win10.guru/dism-whats-the-difference-between-scanhealth-and-checkhealth/
REM 
ReM 
:STEP-02-START-DISM
ECHO.
ECHO.
ECHO ...Step: STEP-02-START-DISM - Check on the health a Windows image




:STEP-02-01-DISM-ANALYZE-COMPONENT-STORE 
ECHO ...Step: STEP-02-01-DISM-ANALYZE-COMPONENT-STORE 
ECHO ...- DISM /online /cleanup-image /analyzecomponentstore
ECHO. 
DISM /online /cleanup-image /analyzecomponentstore


:STEP-02-02-DISM-CHECKHEALTH 
ECHO. 
ECHO. 
ECHO ...Step: STEP-02-02-DISM-CHECHK-HEALTH 
ECHO ...- [re: fast check], DISM.exe /Online /Cleanup-Image /CheckHealth 
ECHO. 
DISM.exe /Online /Cleanup-Image /CheckHealth



:STEP-02-03-DISM-SCANHEALTH
ECHO.
ECHO. 
ECHO ...Step: STEP-02-03-DISM-SCANHEALTH
ECHO ...- [re: deep check], DISM.exe /Online /Cleanup-Image /ScanHealth 
ECHO. 
DISM.exe /Online /Cleanup-Image /ScanHealth


REM ******************************************************************************************
REM REFERENCES: 
REM  https://support.microsoft.com/en-us/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e
REM 
REM 
:STEP-CHECK-SFC-EXISTS 
ECHO.
ECHO.
ECHO ...Step: CHECK-SFC-EXISTS
if exist "c:\Windows\System32\sfc.exe" (
ECHO ...- Confirmed: SFC exists 
) else (
set ERROR_MESSAGE="ERROR - sfc.exe NOT FOUND"
goto ERROR_ABORT 
)


:STEP-RUN-SFC-VERIFYONLY 
ECHO.
ECHO.
ECHO ...Step: STEP-RUN-SFC-VERIFYONLY
ECHO ...- About to run command: sfc /VERIFYONLY
ECHO. 
sfc /VERIFYONLY


GOTO JOB_END 


REM ****************************************************************************
REM Step: ERROR_ABRT
REM 
REM Handle Error Messages 
REM 
REM
:ERROR_ABORT
ECHO.
ECHO ***********************************************************************
ECHO Job Step: ERROR_ABORT 
ECHO.
ECHO ERROR Job Step: %ERROR_JOB_STEP%
ECHO  
ECHO Copy failed with exit code %ERRORLEVEL%!
ECHO. 
ECHO Error Message: %ERROR_MESSAGE%
ECHO ***********************************************************************
ECHO. 


REM ****************************************************************************
REM Step: JOB_END 
REM 
REM
:JOB_END
ECHO.
ECHO Job Step: JOB_END
powershell -c Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"
ECHO %JOB_NAME% Finished!
popd