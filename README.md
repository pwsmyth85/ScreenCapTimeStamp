# ScreenCapTimeStamp

A PowerShell script that takes screen captures and adds a timestamp and user in a black bar at the top.

When you right click the ps1 file it might not run the script. To fix this you could open powershell as administrator and run this command: 

Get-ExecutionPolicy 

If it doesn't say RemoteSigned or Unrestricted then 

Set-ExecutionPolicy RemoteSigned

If you don't want to change your execution policy or don't have admin rights the script will also run if you copy it into powershell.

Edit the script and replace ADDYOURSAVEDIRECTORY with your save directory.

The script will ask you to choose a screen if you have two or more screens.

Then you will be asked if you want a fullscreen capture.

If not you will be shown your screens dimensions in pixles and asked to specify possition of rectangle and its dimensions. It does take a bit of playing around with to get it right. (Still working on this part)

This was made because on my MSC course I need to add date and time to screencaps in my coursework. I couldn't find a free suitable program that I trusted to do this.





