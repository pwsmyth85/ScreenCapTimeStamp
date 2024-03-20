# ScreenCapTimeStamp

A PowerShell script that takes a full screen screen capture and adds a timestamp in the top left corner.

When you right click the ps1 file it might not run the script. To fix this you could open powershell as administrator and run this command: 

Get-ExecutionPolicy 

If it doesn't say RemoteSigned or Unrestricted then 

Set-ExecutionPolicy RemoteSigned

If you don't want to change your execution policy or don't have admin rights the script will also run if you copy it into powershell and then run it.

Edit the script and add in the save path for the files before using on line 2.

If you have two or more screens the script will target your main screen.

The date and time text is white but you could change this to another color that will be seen on your background. Before using you may need to possition windows / shortcuts ect on your screen so nothing is in the top left corner. 

This was made because one of my lecturers on my MSC course specifically wanted date and time added to screencaps in my coursework. I couldn't find a free suitable program that I trusted to do this.





