rem Delete old release
del "Release.zip" /q

rem Open folder with application
cd "Application\"

rem Create Release archive
set Zip=..\..\..\7za.exe
"%Zip%" a "..\Release.zip" -ssw