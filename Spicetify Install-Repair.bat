@echo off
setlocal enableDelayedExpansion
title Installing spicetify v1.1.0
color 0a

::REMOVE_OLD
cls
PowerShell.exe -Command "spicetify restore">nul

rmdir %userprofile%\.spicetify /s /q>nul
rmdir %userprofile%\.spicetifyBackup /s /q>nul
rmdir %userprofile%\spicetify-cli /s /q>nul
rmdir %userprofile%\Spicetify /s /q>nul
cls

::INSTALLATION
::CREATE FOLDER
mkdir %userprofile%\Spicetify>nul
cls

::COPY STRUCTURE
xcopy "%cd%" "%userprofile%\Spicetify" /t /q>nul
cls

::COPY FILES
xcopy "%cd%\bin\Library" "%userprofile%\Spicetify\bin\Library" /s /q>nul
xcopy "%cd%\bin\Gallerie" "%userprofile%\Spicetify\bin\Gallerie" /s /q>nul
cls

::COPY BATS
xcopy "%cd%\Spicetify Install-Repair.bat" "%userprofile%\Spicetify\bin" /q>nul
xcopy "%cd%\bin\Spicetify Update Reset.bat" "%userprofile%\Spicetify\bin" /q>nul
xcopy "%cd%\bin\Theme Select.bat" "%userprofile%\Spicetify" /q>nul
cls

::SPICETIFY START
PowerShell.exe -Command "Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.ps1" | Invoke-Expression"
"%userprofile%\spicetify-cli\spicetify"
xcopy "%userprofile%\Spicetify\bin\Library" "%userprofile%\.spicetify\Themes" /s /q>nul
mkdir %userprofile%\.spicetifyBackup>nul
xcopy "%userprofile%\.spicetify" "%userprofile%\.spicetifyBackup" /s/h/e/k/f/c>nul
cls
PowerShell.exe -Command "spicetify backup"
PowerShell.exe -Command "spicetify apply"
cls
call "%userprofile%\Spicetify\Theme Select"