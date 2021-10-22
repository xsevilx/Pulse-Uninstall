﻿#test for and uninstall Pulse Secure 5.3
if ((Test-Path "C:\Program Files (x86)\Pulse Secure\Pulse\PulseUninstall.exe" -PathType Leaf) -eq "true"){
    stop-process -name Pulse -Force
    stop-process -name PulseSecureService -Force
    cd "C:\Program Files (x86)\Pulse Secure\Pulse"
    .\PulseUninstall.exe /silent=1
    Start-Sleep 180
    }
else {Write-Host "PulseUninstall.exe does not exist."}

#geting all user profiles
$users = Get-ChildItem "C:\Users" -Directory

#Loop through each user profile and uninstall Pulse Secure Setup Client
foreach($user in $users) 
{
    if ((Test-Path "C:\Users\$user\AppData\Roaming\Pulse Secure\Setup Client\uninstall.exe" -PathType Leaf) -eq "true"){
        cd "C:\Users\$user\AppData\Roaming\Pulse Secure\Setup Client\"
        .\pulsesetupclient.exe -stop
        .\uninstall.exe /silent=1
        Start-Sleep 30
        Stop-Process -name "Au_" -Force
        }
    else {Write-Host "$user does not have uninstall.exe"}
    }

#check for and uninstall Pulse Secure Setup Client x64
if ((Test-Path "C:\WINDOWS\Downloaded Program Files\PulseSetupClientCtrlUninstaller64.exe" -PathType Leaf) -eq "true"){
    cd "C:\WINDOWS\Downloaded Program Files\"
    .\PulseSetupClientCtrlUninstaller64.exe /silent=1
    Start-Sleep 10
    Stop-Process -name "Au_" -Force
    }
else { Write-Host 'PulseSetupClientCtrlUninstaller64.exe does not exist'}

#check for and uninstall Pulse Secure Setup Client x86
if ((Test-Path "C:\WINDOWS\Downloaded Program Files\PulseSetupClientCtrlUninstaller.exe" -PathType Leaf) -eq "true"){
    .\PulseSetupClientCtrlUninstaller.exe /silent=1
    Start-Sleep 10
    Stop-Process -name "Au_" -Force
    }
else {Write-Host 'PulseSetupClientCtrlUninstaller.exe does not exist'}

#check if the Pulse Secure WmiObject still shows as installed and uninstall as needed
$Pulse = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "Pulse Secure"} | Select-Object -Property Name
if ($Pulse.name -eq "Pulse Secure"){
    $MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "Pulse Secure"}
    $MyApp.Uninstall()
    Write-Host "Pulse Secure has been completely uninstalled!"#this output means Pulse needed this extra step to be completely uninstalled
    }
Else {Write-Host "Pulse Secure is completely uninstalled!"}#this output means Pulse did not need this extra step to be completely uninstalled