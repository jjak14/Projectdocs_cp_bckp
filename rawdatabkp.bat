@echo off

:Start
::display message and instructions to user
echo.
echo Let's backup your RAW data to Houfile1. 
echo.
echo The following will be copied to the "R3 Rundata" folder in Houfile5.
echo DDF  folder
echo DHA folder
echo MRK folder
echo LOG folder
echo.
pause

cls
echo.
:enterprojnum
::prompt user to enter project number
SET /P projnum=Please enter 5 digit project number (#####) : 
::handle error in typing project number. using workaround with regex

::print out project number entered and try to match it against regex
echo %projnum%| findstr /r "^[1-9][0-9][0-9][0-9][0-9]$">NUL

::if there is a match errorlevel should return 0 otherwise 1 and 2
if %errorlevel% NEQ 0 (
    GOTO errormessage1
)

:enterlinename
::prompt user to enter line name
SET /P linename=Please enter Linename (##LAUREC) :
::handle error in typing Linename. using workaround with regex

::print out linename entered and try to match it against regex
echo %linename%| findstr /r "^[0-5][0-9][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z]$">NUL

::if there is a match errorlevel should return 0 otherwise 1 and 2
if %errorlevel% NEQ 0 (
    GOTO errormessage2
)

:entertechn
::prompt user to enter technology
SET /P techn=Please enter 3 letters Technology (CBG, CDP, BMD, CDG, BMG, ...) :
::handle error in typing technology. using workaround with regex

::print out technology entered and try to match it against regex
echo %techn%| findstr /r "^[a-zA-Z][a-zA-Z][a-zA-Z]$">nul

::if there is a match errorlevel should return 0 otherwise 1 and 2
if %errorlevel% NEQ 0 (
    GOTO errormessage3
)


:pathsetup
::------- Build sources paths.
SET DHApath=C:\Proj0\%projnum%\%linename%\%techn%\R1\DHA
SET DDFpath=C:\Proj0\%projnum%\%linename%\%techn%\R1\DDF
SET MRKpath=C:\Proj0\%projnum%\%linename%\%techn%\R1\MRK
SET LOGpath=C:\Proj0\%projnum%\%linename%\%techn%\R1\LOG
::------- End build sources paths.

::---------- Build Destinations paths and create necessary folders
SET DHAdestpath=m:\Proj0\%projnum%\%linename%\%techn%\R1\DHA
mkdir %DHAdestpath% 2>NUL

SET DDFdestpath=m:\Proj0\%projnum%\%linename%\%techn%\R1\DDF
mkdir %DDFdestpath% 2>NUL

SET MRKdestpath=m:\Proj0\%projnum%\%linename%\%techn%\R1\MRK
mkdir %MRKdestpath% 2>NUL

SET LOGdestpath=m:\Proj0\%projnum%\%linename%\%techn%\R1\LOG
mkdir %LOGdestpath% 2>NUL
::---------- End Build Destinations paths


:: ================ Handling COPY below ===================

robocopy %DDFpath% %DDFdestpath% /E /S /z

robocopy %DHApath% %DHAdestpath% /E /S /z

robocopy %MRKpath% %MRKdestpath% /E /S /z

robocopy %LOGpath% %LOGdestpath% /E /S /z

:: ================ End Handling the copy below ===================


::display complete message
echo Copy completed !
pause
GOTO End


::***************** error handling *********************
:errormessage1
echo value entered should be 5 digit. Please try again or close the program.
GOTO enterprojnum

:errormessage2
echo Linename should be 8 characters starting with 2 digit size. Please try again or close the program.
GOTO enterlinename

:errormessage3
echo Technology should be 3 letters characters. Please try again or close the program.
GOTO entertechn

::end of the script
:End