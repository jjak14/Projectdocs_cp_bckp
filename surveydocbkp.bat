@echo off

:Start
::display message and instructions to user
echo.
echo Let's backup some post-survey data in Houfile5. 
echo.
echo The following will be copied to the "Survey" Folder in Houfile5.
echo MRK  folder : TSR files, AGMs files(rem and mpf), Pictures(zip folder) and Documents folder(If available).
echo DHA folder : A1.par and marker evaluation file(if exist).
echo Statistics folder: Data, Index, DistCalc and Gyro(if exist) as zip.
echo.
echo Please make sure the needed files are available !
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
SET Dhapath=C:\Proj0\%projnum%\%linename%\%techn%\R1\DHA
SET Statdatapath=C:\Proj0\%projnum%\%linename%\%techn%\R1\Statistics\Data
SET StatDistCpath=C:\Proj0\%projnum%\%linename%\%techn%\R1\Statistics\DistCalc
SET StatIndexpath=C:\Proj0\%projnum%\%linename%\%techn%\R1\Statistics\Index
SET StatGyropath=C:\Proj0\%projnum%\%linename%\%techn%\R1\Statistics\Gyro
SET Docpath=C:\Proj0\%projnum%\%linename%\%techn%\R1\MRK\Documents
SET Picturespath=C:\Proj0\%projnum%\%linename%\%techn%\R1\MRK\Pictures
SET Mrkpath=C:\Proj0\%projnum%\%linename%\%techn%\R1\MRK
::------- End build sources paths.

::---------- Build Destinations paths and create necessary folders
SET Dhadestpath=o:\0-1000-%projnum%\Execution\%linename%\Survey\%techn%\R1\DHA
mkdir %Dhadestpath% 2>NUL

SET Statsdestpath=o:\0-1000-%projnum%\Execution\%linename%\Survey\%techn%\R1\Statistics
mkdir %Statsdestpath% 2>NUL

SET Mrkdestpath=o:\0-1000-%projnum%\Execution\%linename%\Survey\%techn%\R1\MRK
mkdir %Mrkdestpath% 2>NUL
::---------- End Build Destinations paths


:: ================ Handling COPY below ===================
::----------copy DHA folder
robocopy %Dhapath% %Dhadestpath% /E /S /z
::--------- End copy DHA 

::------- Copy Statistics : zip of Data, DistCalc, Index and Gyro 
robocopy %Statdatapath% %Statsdestpath% Data.zip /mt /z
robocopy %StatDistCpath% %Statsdestpath% DistCalc.zip /mt /z
robocopy %StatIndexpath% %Statsdestpath% Index.zip /mt /z
:: check if there's a gyro folder locally available before copy
if exist %StatGyropath% robocopy %StatGyropath% %Statsdestpath% Gyro.zip /mt /z
::------- End Copy Statistics 

::------- Copy MRK (only before and after TSR) 
robocopy %Mrkpath% %Mrkdestpath% *.tsr /mt /z
robocopy %Mrkpath% %Mrkdestpath% *.rem /mt /z
robocopy %Mrkpath% %Mrkdestpath% *.mpf /mt /z
robocopy %Mrkpath% %Mrkdestpath% Pictures.zip /mt /z
if exist %% robocopy %Docpath% %Mrkdestpath% /E /S /z
::------- End Copy MRK 
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