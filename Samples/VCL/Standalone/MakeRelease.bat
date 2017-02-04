rem Delete old release
del "Release.zip" /q

rem Open folder with application
cd "Application\"

rem Delete old VclStandalone.exe.old
del "VclStandalone.exe.old" /q

rem Create Release archive
set Zip=..\..\..\7za.exe
"%Zip%" a "..\Release.zip" -ssw

exit