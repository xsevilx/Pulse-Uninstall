# Pulse-Uninstall
PowerShell script to uninstall Pulse Secure 5.3

I wrote this script because my company was no longer using Pulse Secure and we needed to uninstall but when uninstalling
  Pulse using the installer it only removed the main client and leaves 3 "Pulse Secure Setup Client*" installs in the control
  panel, even though Pulse secure wouldnt show as installed anymore. If you uninstall these 3 parts manually you cna look at
  the detials of their uninstallers. I used those detials to script uninstalling those parts and then, becasue i found on a
  few machines pulse wouldnt be in control pannel but would still show as installed because it was in get-WmiObject, i added
  one step to remove "Pulse Secure" that way also.
