# Personal.Windows.Utils
This is a collection of personal Windows utility scripts (CMD, PowerShell, etc.) - that may be benefit to others


## Shazam.bat
- A CMD batch script intended to help automate the steps in the process of verifying (and correcting) that condition of a Windows OS install. 
- Steps in the automated script:
  * STEP-1.0: Check systeminfo before starting clean-up steps...
  * STEP-2: Create Restore Point
  * STEP-3.0: Scan and Fix any Disk Errors
  * STEP-4.0: Anti-Virus Scan 
    * STEP-4.1: Update Anti-Virus Signature Definitions
    * STEP-4.2: Run Full Anti-Virus Scan
  * STEP-5.0: Run DISM to repair an image of Windows 10
    * STEP-5.1: First, Check health of Windows Image
    * STEP-5.2: Second, Restore health of Windows Image
  * STEP-6.0: Run SFC to repair installation problems of Windows 10
  * STEP-7.0: Force Windows Update
  * STEP-8.0: Check systeminfo after forced update...
  * STEP-9.0: REVIEW Windows Update results in %windir%/Logs/CBS/CBS.log


