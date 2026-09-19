REM ****************************************************************************
REM my_checksum.cmd
REM A general purpose utility to compute SHA512 or SHA256, for a given 
REM parameter (filename) passed to this script - based on the presence of 
REM a corresponding <filename.sha256> or <filename.sha512> in the same 
REM directory. 
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


REM
REM
REM ****************************************************************************
REM Parameter Definitions
REM
:PARAMETER_DEFINITIONS
set JOB_NAME=my_checksum.cmd 
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
ECHO CTL-C to ABORT this script. 
ECHO. 
ECHO. 
ECHO Hit [enter] to proceed.
pause 



:STEP_VERIFY_FILE_EXISTS
ECHO.
ECHO. 
ECHO ...File to examine: [%1]
if exist "%1" goto STEP_ROUTE_BY_CHECKSUM_FILE
goto ERROR_Binary_Not_Found 


:STEP_ROUTE_BY_CHECKSUM_FILE 
ECHO.
ECHO. 
ECHO Checking for either SHA512 or SHA256 file suffixes in this directory

if exist "%1.sha512" (goto PROCESS_SHA512_CHECKSUM)

if exist "%1.sha256" (goto PROCESS_SHA256_CHECKSUM)

set ERROR_MESSAGE=No valid %1.sha512 or %1.sha256 files found"
goto ERROR_ABORT 



REM 
REM 
REM *********************************************************************************************
REM 
:PROCESS_SHA512_CHECKSUM
ECHO.
ECHO.  
ECHO ...Step: PROCESS_SHA512_CHECKSUM
ECHO ...- Found matching SHA512 file: (%1.sha512)
ECHO. 
ECHO ...- Generating SHA512 for (%1)
ECHO....- powershell -c "Get-FileHash -Algorithm SHA512 %1 | Format-List"
ECHO.
powershell -c "Get-FileHash -Algorithm SHA512 %1 | Format-List"

ECHO. 
ECHO. 
ECHO ...- The above generated 512 checksum should match the value below, provided by the publisher of the binary:
ECHO. 
tail "%1.sha512"
ECHO.
ECHO. 

goto JOB_END


REM 
REM 
REM *********************************************************************************************
REM 
:PROCESS_SHA256_CHECKSUM
ECHO.
ECHO.
ECHO ...Job Step: PROCESS_SHA256_CHECKSUM
ECHO ...- Found matching SHA256 file: (%1.sha256)
ECHO. 
ECHO ...- Generating SHA256 for (%1): 
ECHO....- powershell -c "Get-FileHash -Algorithm SHA256 %1 | Format-List"
ECHO.
powershell -c "Get-FileHash -Algorithm SHA256 %1 | Format-List"

ECHO. 
ECHO. 
ECHO ...- The above generated SHA256 checksum should match the value below, provided by the publisher of the binary:
ECHO. 
tail "%1.sha256"
ECHO.
ECHO. 

goto JOB_END



:ERROR_Binary_Not_found
ECHO.
ECHO ERROR: Unable to find binary file [%1] for analysis

goto JOB_END 


:ERROR_No_Checksum_Matching_File
ECHO.
ECHO. 
ECHO ERROR: Unable to find checksum file for comparison
ECHO Note: Expected file suffix of one of the following: .sha512, .sha256, sah1, or .md5
dir "%1.*"


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
