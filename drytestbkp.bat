:EnterSelection
echo Let's backup your DryTest Folder to Houfile5.
echo Please make sure the T1 folder is zipped to T1.zip and stored next to the original T1 folder.
echo .

:enterprojnum
SET /P projnum=Please enter 5 digit project number (#####) : 
echo %projnum% | findstr /r "^[1-9][0-9]*$">nul
if %errorlevel% equ 0 (
    GOTO errormessage1
)
call :strlen result projnum
if %result% NEQ 5 (
    GOTO errormessage1
) 

:enterlinename
SET /P linename=Please enter Linename (##LAUREC) :
call :strlen result linename
if %result% NEQ 8 (
    GOTO errormessage2
) 

:entertechn
SET /P techn=Please enter 3 letters Technology (CBG, CDP, BMD, CDG, BMG, ...) :
call :strlen result techn
if %result% NEQ 3 (
    GOTO errormessage3
) 


SET projectpath=C:\Proj0\%projnum%\%linename%\%techn%\
SET T1projectdest=o:\0-1000-%projnum%\Execution\%linename%\DryTest\
mkdir %T1projectdest% 2>NUL
echo T1.zip will be copied from %projectpath% to %T1projectdest%

pause

robocopy %projectpath% %T1projectdest% T1.zip /mt /z

echo Copy completed !
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
echo Techology should be 3 letters characters. Please try again or close the program.
GOTO entertechn

:strlen <resultVar> <stringVar>
(   
    setlocal EnableDelayedExpansion
    (set^ tmp=!%~2!)
    if defined tmp (
        set "len=1"
        for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
            if "!tmp:~%%P,1!" NEQ "" ( 
                set /a "len+=%%P"
                set "tmp=!tmp:~%%P!"
            )
        )
    ) ELSE (
        set len=0
    )
)
( 
    endlocal
    set "%~1=%len%"
    exit /b
)


:End