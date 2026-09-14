REM ***************************************************************************
REM my_system_info.cmd 
REM Created: 2019-07-01
REM 
REM Author: Kelvin D. Meeks
REM Email: kmeeks@intltechventures.com 
REM 
REM https://www.linkedin.com/in/kelvinmeeks/
REM https://intltechventures.blogspot.com/
REM http://www.intltechventures.com/
REM https://github.com/intltechventures
REM 
REM
REM Remote GitHub Repository:
REM https://github.com/intltechventures/Personal.Windows.Utils
REM 
REM Local Git Repository 
REM C:\gitRepository\git\Personal.Windows.Utils
REM
REM 
REM References:
REM https://github.com/intltechventures/Tips/blob/master/Tips.Windows.CMD.md
REM https://github.com/intltechventures/Tips/blob/master/Tips.Windows.PowerShell.md
REM
REM 
REM CHANGE LOG: 
REM 2026-09-11 WMIC removed from Windows 11, replaced calls with powershell commands
REM https://support.microsoft.com/en-us/servicing/os/windows/docs/2025/09/windows-management-instrumentation-command-line-wmic-removal-from-windows 
REM 
REM 
REM ****************************************************************************
REM Parameter Definitions
REM
set JOB_NAME=my_system_info.cmd 
set version=1.5.0
set LAST_UPDATED=2026-09-14
REM
REM
REM ****************************************************************************
REM Step: JOB_INITILIZATION 
REM

cls
@ECHO OFF 
:: This batch file reveals OS, hardware, and networking configuration.
TITLE %JOB_NAME%
:JOB_START
ECHO.
ECHO Starting %JOB_NAME%, version: %version%
ECHO (Last Updated: %LAST_UPDATED%)
ECHO. 
ECHO Job Step: JOB_START 
powershell -c Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"
ECHO. 
ECHO. 
ECHO.
:: Section-01: OS information.
ECHO ============================
ECHO OS INFO
ECHO ============================
ECHO.
ECHO Please wait... collecting system OS information.
ECHO.
systeminfo | findstr /c:"OS Name"
systeminfo | findstr /c:"OS Version"
systeminfo | findstr /c:"System Type"
systeminfo | findstr /c:"Hotfix"
ECHO.
ECHO.
powershell -c Get-CimInstance -ClassName Win32_BIOS
ECHO. 
ECHO.
:: Section-02: Hardware information.
ECHO ============================
ECHO HARDWARE INFO - Physical Memory, CPU
ECHO ============================
ECHO.
ECHO Physical and Virtual Memory
systeminfo | findstr /c:"Memory"
ECHO.
ECHO.
systeminfo | findstr /c:"Processor"
ECHO.
ECHO.
ECHO CPU Information
REM powershell -c "Get-CimInstance -ClassName Win32_Processor"
ECHO.
ECHO.
powershell -c "Get-CimInstance Win32_processor | ft -Property NumberOfCores, NumberOfLogicalProcessors, LoadPercentage"
ECHO.
ECHO.
powershell -c "Get-CimInstance Win32_Processor | Measure-Object -Property NumberOfCores, NumberOfLogicalProcessors, LoadPercentage -Sum -Average"
ECHO.
ECHO.
ECHO.
:: NETWORKING IFNO 
ECHO ============================
ECHO NETWORK INFO
ECHO ============================
ECHO.
ipconfig | findstr IPv4
ECHO.
ECHO.
ipconfig | findstr IPv6
ECHO.
ECHO.
ipconfig /all
:JOB_END
REM ****************************************************************************
REM Step: JOB_END 
REM 
REM
:JOB_END
ECHO.
ECHO Job Step: JOB_END
ECHO %JOB_NAME% Finished!
powershell -c Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"
