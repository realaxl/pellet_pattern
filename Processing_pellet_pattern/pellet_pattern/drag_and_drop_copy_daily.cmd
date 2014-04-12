@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo Script ..... %0%
echo.

set sortdate=%DATE:~-4%-%DATE:~-7,2%-%DATE:~-10,2%
set now=%TIME:~-11,2%-%TIME:~-8,2%
set now=%now: =0%

set sortdate=%sortdate% (%now%)

set delay_at_end=5

set fName=%1
if '%1' equ '' set /p fName=Enter file name:
 
for /f "tokens=* delims= " %%F in ('echo %fName%') do (
        echo IN ........ %%~nxF
        echo NO EXT .... %%~nF
        echo EXT ....... %%~xF
        echo.

        if not exist "%%~nF - Copy %sortdate%%%~xF" (
                echo Copy to "%%~nF - Copy %sortdate%%%~xF"
                copy "%%~nxF" "%%~nF - Copy %sortdate%%%~xF"
        ) else echo File exists ... not copied

        if exist "..\990 Archive\*" (
                echo.
                echo.
                echo ============================
                echo Sending a copy to ..\990 Archive
                echo ============================
                copy "%%~nxF" "..\990 Archive\%%~nF - Copy %sortdate%%%~xF"
        )
)

echo.
echo Auto-closing in %delay_at_end% seconds ...
ping -n %delay_at_end% 127.0.0.1 >nul

