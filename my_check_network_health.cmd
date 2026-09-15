REM ****************************************************************************
REM my_check_network_health.cmd
REM 
REM Created: 2026-09-14 Monday 
REM 



REM ****************************************************************************
REM Parameter Definitions
REM
:PARAMETER_DEFINITIONS
set JOB_NAME=my_check_network_health.cmd 
set VERSION=1.0.0
set LAST_UPDATED=2026-09-14
set RESULTS_FILE=check_network_health_results.txt
REM 
REM 
REM ****************************************************************************
REM Step: JOB_INITILIZATION 
REM
:JOB_INITIALIZATION 
title %JOB_NAME%
@ECHO off
cls
pushd .


REM ****************************************************************************
REM Job Step: JOB_START 
REM 
:JOB_START 
ECHO.
ECHO Starting %JOB_NAME%, version: %VERSION%
ECHO (Last Updated: %LAST_UPDATED%)
ECHO. 
ECHO Job Step: JOB_START 
powershell -c Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"
ECHO. 
ECHO. 
ECHO This command file checks for network connection problems
ECHO and saves the output to: %RESULTS_FILE% 
ECHO. 
ECHO *** (Press [ENTER] to continue, CTL-C to ABORT) ***
pause 
ECHO. 
ECHO. 

REM ****************************************************************************
REM Job Step: STEP_GET_IPCONFIG_INFO 
REM 
REM View network connection details
REM 
:STEP_GET_IPCONFIG_INFO 
ECHO ...Step: STEP_GET_IPCONFIG_INFO 
ECHO. 
ipconfig /all > %RESULTS_FILE% 


REM ****************************************************************************
REM Job Step: STEP_PING_GOOGLE
REM 
REM Check if Google.com is reachable
REM 
:STEP_PING_GOOGLE
ECHO ...Step: STEP_PING_GOOGLE
ECHO. 
ping google.com >> %RESULTS_FILE% 


REM ****************************************************************************
REM Job Step: STEP_TRACERT_WIKIPEDIA
REM 
REM Run a traceroute to check the route to WIKIPEDIA 
REM
REM References:
REM https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tracert
REM 
:STEP_TRACERT_WIKIPEDIA
ECHO ...Step: STEP_TRACERT_WIKIPEDIA
ECHO. 
ECHO *** Skipping tracert (timeouts occuring after 3 hops on T-Mobile network...) 
ECHO *** Skipping tracert (timeouts occuring after 3 hops on T-Mobile network...) >> %RESULTS_FILE% 
ECHO. 
REM tracert /d /w 30 wikipedia.org >> results.txt



REM ****************************************************************************
REM Job Step: STEP_PING_GOOGLE
REM 
REM View Results 
REM 
:STEP_VIEW_RESULTS
ECHO ...Step: STEP_VIEW_RESULTS
ECHO. 
more /E /C %RESULTS_FILE% 


goto JOB_END 


REM ****************************************************************************
REM Job Step: ERROR_ABORT 
REM 
:ERROR_ABORT
ECHO.
ECHO Job Step: ERROR_ABORT 
ECHO. 
ECHO Error Level: %ERRORLEVEL%
ECHO Error Level: %ERRORLEVEL% >>  %RESULTS_FILE% 
ECHO. 
ECHO Error Message: %ERROR_MESSAGE%
ECHO Error Message: %ERROR_MESSAGE% >>  %RESULTS_FILE% 
ECHO. 
ECHO. 


REM ****************************************************************************
REM Job Step: JOB_END 
REM 
:JOB_END
ECHO.
ECHO Job Step: JOB_END
powershell -c Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"
ECHO %JOB_NAME% Finished!
popd


