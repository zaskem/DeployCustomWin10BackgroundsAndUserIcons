# DeployCustomWin10BackgroundsAndUserIcons
A simple Powershell script used during OSD to "install" (overwrite) the default Windows 10 backgrounds (used for desktop and lock screen) and user icons.

The idea for this process was originally stolen from and based on [Trevor Jones's article](https://smsagent.wordpress.com/2017/07/06/setting-the-default-wallpaper-for-windows-10-during-configmgr-osd/)
## Purpose
The script copies a set of custom desktop background (and a custom logon/lock screen) images and default user icons to the appropriate locations on a Windows 10 workstation and also sets the default lock screen image via the registry. This script/process is implemented during the task sequence so as to lay down all of the files well before a user ever logs on to a machine.