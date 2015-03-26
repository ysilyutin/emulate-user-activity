@echo off

:: 2 bytes
echo.>test.txt

:: 1Kb
for /L %%i in (1, 1, 9) do type test.txt>>test.txt

:: 1Mb
for /L %%i in (1, 1, 10) do type test.txt>>test.txt

:: 1Gb
for /L %%i in (1, 1, 10) do type test.txt>>test.txt

:: 4Gb
::for /L %%i in (1, 1, 4) do type test.txt>>file-4gb.txt


setlocal EnableDelayedExpansion

::Compress
set "FolderToCompress=..\test"
"C:\Program Files\7-Zip\7z.exe" a -mx=9 -r -tzip "..\test\zip\archive.zip" "%FolderToCompress%\*"
::rd /S /Q "%FolderToCompress%"
::md "%FolderToCompress%"
endlocal


for /L %%i IN (1,1,4000) do call :docopy %%i
goto end

:docopy
set FN=00%1
set FN=%FN:~-3%

copy test.txt test%FN%.txt
del test%FN%.txt

ECHO Waiting 1 second
PING 1.1.1.1 -n 1 -w 1000 > NUL

copy zip\archive.zip zip\archive%FN%.zip
del zip\archive%FN%.zip

ECHO Waiting 1 second
PING 1.1.1.1 -n 1 -w 1000 > NUL

:end

::del test.txt
::del file-4gb.txt
