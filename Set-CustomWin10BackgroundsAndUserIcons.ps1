# File Name: Set-CustomWin10BackgroundsAndUserIcons.ps1
# Summary: Simple copy script to drop in replacement background and user images before a user ever logs on (used during OSD).
# Created by: Matt Zaske, based heavily on Trevor Jones's work:
#   Originally stolen from and based on Trevor Jones's article:
#   https://smsagent.wordpress.com/2017/07/06/setting-the-default-wallpaper-for-windows-10-during-configmgr-osd/
# Version 1.0

# $ImagePath and $IconPath are the local folder names (relative to $PSScriptRoot and this script) containing the images
$ImagePath = 'Backgrounds'
$IconPath = 'UserIcons'
# Remove old wallpaper
Remove-Item $env:windir\Web\Wallpaper\Windows\img0.jpg -Force -Confirm:$false

# Copy new default wallpaper
Copy-Item $PSScriptRoot\$ImagePath\img0.jpg $env:windir\Web\Wallpaper\Windows -Force
Copy-Item $PSScriptRoot\$ImagePath\customlogon.jpg $env:windir\Web\Wallpaper\Windows -Force

# Define image file list
$Images = @(
    'customlogon.jpg'
    'img0.jpg'
    'img0_1024x768.jpg'
    'img0_1200x1920.jpg'
    'img0_1366x768.jpg'
    'img0_1600x2560.jpg'
    'img0_2160x3840.jpg'
    'img0_2560x1600.jpg'
    'img0_3840x2160.jpg'
    'img0_768x1024.jpg'
    'img0_768x1366.jpg'
)

# Copy each 4K image
Foreach ($Image in $Images)
{
    Copy-Item "$PSScriptRoot\$ImagePath\$Image" $env:windir\Web\4K\Wallpaper\Windows -Force
}

# Set Machine Default for the lock screen (this is also accomplished by way of GPO, but we do it here too)
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" 
$img =  "$env:windir\Web\Wallpaper\Windows\customlogon.jpg"

# Apply Registry Keys
If (!(Test-Path $path))
{
    New-Item -Path $path -Force
    New-ItemProperty -Path $path -Name LockScreenImage -Value $img
} else {
    Set-ItemProperty -Path $path -Name LockScreenImage -Value $img
}

# USER ICONS
#
# Define image file list
$UserImages = @(
    'user.png'
    'user.bmp'
    'user-32.png'
    'user-40.png'
    'user-48.png'
    'user-192.png'
)

# Copy each User Icon
Foreach ($Image in $UserImages)
{
    Copy-Item "$PSScriptRoot\$IconPath\$Image" "$env:ProgramData\Microsoft\User Account Pictures" -Force
}