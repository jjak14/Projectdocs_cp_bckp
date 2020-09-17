@echo off

:Start
:: print out message for user and give instructions
echo Let's backup your zipped DryTest Folder to "DryTest" in Houfile5.
echo Please make sure the T1 folder is zipped to T1.zip 
echo and stored next to the original T1 folder.
echo .
pause

:enterprojnum
::ask user to input project number
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
:: prompt user to enter technology
SET /P techn=Please enter 3 letters Technology (CBG, CDP, BMD, CDG, BMG, ...) :
::handle error in typing technology. using workaround with regex

::print out technology entered and try to match it against regex
echo %techn%| findstr /r "^[a-zA-Z][a-zA-Z][a-zA-Z]$">nul

::if there is a match errorlevel should return 0 otherwise 1 and 2
if %errorlevel% NEQ 0 (
    GOTO errormessage3
)


SET projectpath=C:\Proj0\%projnum%\%linename%\%techn%\
SET T1projectdest=o:\0-1000-%projnum%\Execution\%linename%\DryTest\
mkdir %T1projectdest% 2>NUL
echo T1.zip will be copied, 
echo from : %projectpath% 
echo to : %T1projectdest%

pause

robocopy %projectpath% %T1projectdest% T1.zip /mt /z

echo Copy complete !
pause
GOTO End


REM ***************** error handling *********************
:errormessage1
echo value entered should be 5 digit. Please try again or close the program.
GOTO enterprojnum

:errormessage2
echo Linename should be 8 characters starting with 2 digit size. Please try again or close the program.
GOTO enterlinename

:errormessage3
echo Technology should be 3 letters characters. Please try again or close the program.
GOTO entertechn

:End