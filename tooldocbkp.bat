@echo off

:Start
::display message and instructions to user
echo Let's backup your tool data to the "Resources" Folder in Houfile5.
echo.
echo Please make sure at the minimum all resources documents (see below the list) are stored in a "Document" folder. 
echo The document folder is to be stored in your "T1" folder following the usual project path on your laptop.
echo.
echo The following documents and directory are needed at a minimum to be Houfile5 compliant in R3 :
echo ==========================================
echo.
echo [1] Tool certification file
echo [2] Tool Preparation Report
echo [3] Tool Consumption Calculator
echo [4] Before Run tool Pictures (as BR Tool Pictures.zip)
echo [5] Tool folder (named after the tool) with calibration folder and files 
echo [6] Tool manual document (can also be store in tool folder)
echo [7] Tool specs. sheet (can also be store in tool folder)
echo.
echo ==========================================
pause

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


:entertoolname
::prompt user to enter tool name
SET /P toolname=Please enter tool name (ie: C10-1.IF, B06-1.Q, ...) :
::handle error in typing toolname. using workaround with regex

::print out toolname entered and try to match it against regex
echo %toolname%| findstr /r "^[a-zA-Z][0-5][0-9]-[0-9].[a-zA-Z][a-zA-Z]$">nul

::if there is a match errorlevel should return 0 otherwise 1 and 2
::if errorlevel is 0 go to next section of the project
if %errorlevel% EQU 0 (
    ::if errorlevel is 0 go to next section of the project
    GOTO pathsetup
)

::if errorlevel is 1, repeat print out toolname entered and try to match it against second regex
echo %toolname%| findstr /r "^[a-zA-Z][0-5][0-9]-[0-9].[a-zA-Z]$">nul

if %errorlevel% NEQ 0 (
    ::if errorlevel is 0 there is a match below action will be ignored
    GOTO errormessage4
)

:pathsetup
::build source and destination path.
SET docpathlocal=C:\Proj0\%projnum%\%linename%\%techn%\T1\MRK\Documents
SET destpath=o:\0-1000-%projnum%\Resources\%linename%\R1\%toolname%
mkdir %destpath% 2>NUL
echo All tool documents will be copied 
echo from : %docpathlocal% 
echo to : %destpath%
pause

::handle copy using robocopy tool
robocopy %docpathlocal% %destpath% /E /S /z

::disply complete message
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

:errormessage4
echo Tool name should follow the naming convention for tools. Please try again or close the program.
GOTO entertoolname

::end of the script
:End