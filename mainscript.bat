@echo off

:Start
::Display welcome message and instructions
echo This script copies project's directories and files from your local computer to the server. 
pause

:menu
::Clear screen to make some space and display menu with selection list
cls
echo.
echo Select the action you want to perform :
echo ==========================================
echo.
echo [A] Copy DryTest data to Houfile5.
echo [B] Copy Survey resources documents to Houfile5.
echo [C] Copy post-survey documents and MRK folder to Houfile5.
echo [D] Copy Raw data to Houfile1.
echo.
echo ==========================================


:MakeSelection
::Prompt user to enter selection
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

::in the following sections validate and diplay selection
:ActionA
echo.
echo You selected option %SelectOption% : backup T1 folder
echo.
echo ==========================
call drytestbkp.bat
goto End

:ActionB
echo.
echo Running option %SelectOption% : backup tool documents
echo.
echo ==========================
call tooldocbkp.bat
goto End


:ActionC
echo.
echo Running option %SelectOption% : backup survey documents and MRK data to Houfile5
echo.
echo ==========================
call surveydocbkp.bat
goto End


:ActionD
echo.
echo Running option %SelectOption% : backup actual survey (Raw) data to Houfile1 for evaluation
echo.
echo ==========================
call rawdatabkp.bat
goto End

:Error
echo.
echo wrong selection made! Please enter "A", "B", "C" or "D".
echo Or close the program to exit.
pause
goto menu


:End
echo.
echo Would like to perform another action ?
set /p EndSelect= Please enter your selection [Y / N] : 

if /I "%EndSelect%" EQU "Y" goto :menu
::if /I "%EndSelect%" NEQ "Y" 
echo Thank you ! See you next time.