@echo off

:Welcome
echo Hi, Welcome to the R3 UP process script. 
echo This script copies project's directories and files from your local computer, 
echo to Houfile5 and Houfile1 according to the UP PROCESS.
echo Please make sure the folders that needs to be zipped are indeed zipped,
echo and all files to be moved are saved in the right directories inside the project's folder.
pause


:menu
cls
echo.
echo Select the action you want to perform :
echo ==========================================
echo.
echo [A] To copy DryTest data to Houfile5 (backup T1 folder)
echo [B] To copy Survey resources documents to Houfile5 (backup tool documents)
echo [C] To copy post survey documents and MRK folder to Houfile5 (backup survey documents)
echo [D] To copy Raw data to Houfile1 (backup actual survey data to Houfile1 for evaluation)
echo.
echo ==========================================


:MakeSelection
set /p SelectOption= Please enter your selection : 

if /I "%SelectOption%" EQU "A" goto :ActionA
if /I "%SelectOption%" NEQ "A" goto :B
:B
if /I "%SelectOption%" EQU "B" goto :ActionB
if /I "%SelectOption%" NEQ "B" goto :C
:C
if /I "%SelectOption%" EQU "C" goto :ActionC
if /I "%SelectOption%" NEQ "C" goto :D
:D
if /I "%SelectOption%" EQU "D" goto :ActionD
if /I "%SelectOption%" NEQ "D" goto :Error

:ActionA
echo You selected option %SelectOption% : backup T1 folder
call drytestbkp.bat
goto End

:ActionB
echo Running option %SelectOption% : backup tool documents
call tooldocbkp.bat
goto End


:ActionC
echo Running option %SelectOption% : backup survey documents and MRK data to Houfile5
call surveydocbkp.bat
goto End


:ActionD
echo Running option %SelectOption% : backup actual survey (Raw) data to Houfile1 for evaluation
call rawdatabkp.bat
goto End

:Error
echo wrong selection made! Please enter "A", "B", "C" or "D".
echo Or close the program to exit.
pause
goto menu


:End
echo Would like to perform another action ?
set /p EndSelect= Please enter your selection [Y / N] : 

if /I "%EndSelect%" EQU "Y" goto :menu
if /I "%EndSelect%" NEQ "Y" OR "%EndSelect%" EQU "N" goto :closing

pause