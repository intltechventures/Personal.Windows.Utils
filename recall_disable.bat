@ECHO OFF
cls
ECHO recall_disable.bat 
ECHO 
ECHO Author: Kelvin D. Meeks
ECHO https://www.linkedin.com/in/kelvinmeeks/ 
ECHO 
ECHO Purpose: A utility to execute DISM command to detect presence and status of Microsoft RECALL feature 
ECHO https://github.com/intltechventures/Personal.Windows.Utils/recall_disable.bat
ECHO Version: 1.0.0, 2025-06-12
ECHO.
REM OFF 
REM recall_disable.bat
REM
REM References:
REM https://answers.microsoft.com/en-us/windows/forum/all/how-to-check-whether-recall-function-is-on-with/7bcb33aa-3d18-4944-bd58-5c9689df64d3 
REM 
REM https://blogs.windows.com/windowsexperience/2024/06/07/update-on-the-recall-preview-feature-for-copilot-pcs/#
REM 
REM https://www.instagram.com/davidbombal/reel/DBMBB5vgvkL/
REM
REM
DISM /Online /Disable-Feature /FeatureName:Recall
