rem Delete old release
del "Release.zip" /q

rem Open folder with application
cd "Application\"

rem Delete old VclApplication.exe.old
del "VclApplication.exe.old" /q
rem Delete old VclUpdate.exe.old
del "VclUpdate.exe.old" /q

rem Create Release archive
set Zip=..\..\..\7za.exe
"%Zip%" a "..\Release.zip" -ssw

exit