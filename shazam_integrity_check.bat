ECHO .
ECHO Running sfc scan...
ECHO .
sfc /scannow

pause
ECHO .  
ECHO Running chkdsk on C:\
ECHO .
chkdsk c: /scan /perf /V

pause
ECHO .
ECHO Running chkdsk on D:\
ECHO .
chkdsk d: /scan /perf /V



