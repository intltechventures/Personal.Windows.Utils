REM ****************************************************************************
REM my_chkdsk.cmd
REM My personal script for running analysis of the local hard disks
REM 
REM Utilities used:
REM - Microsoft Windows Commands:
REM   - chkdsk 
REM 
REM TODO: 
REM (more tools to be added...)
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
REM
REM References:
REM https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk 
REM 
REM ****************************************************************************


REM
REM
REM ****************************************************************************
REM Parameter Definitions
REM
:PARAMETER_DEFINITIONS
set JOB_NAME=my_chkdsk.cmd 
set VERSION=1.0.0
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


REM 
REM
REM ****************************************************************************
REM Step: JOB_START 
REM 
:JOB_START 
ECHO.
ECHO Starting %JOB_NAME%, version: %VERSION%
ECHO (Last Updated: %LAST_UPDATED%)
ECHO.
ECHO. 
ECHO Job Step: JOB_START 
powershell -c Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"
ECHO. 
ECHO. 

REM 
REM
REM ****************************************************************************
REM Step: STEP_RUN_CHKDSK
REM 
REM References: 
REM https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk
REM 
:STEP_RUN_CHKDSK
ECHO.
ECHO Running chkdsk c: /scan /perf /V
ECHO. 
c:
cd \
chkdsk c: /scan /perf /V

goto JOB_END 


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
