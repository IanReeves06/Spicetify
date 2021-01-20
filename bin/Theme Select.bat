@echo off
setlocal enableDelayedExpansion
title Theme Select
color 0a

:menu0
cls
cd %userprofile%\.spicetify\Themes

::THEME_SELECTION
set themeCnt0=0
for /f "eol=: delims=" %%F in ('dir /b /ad *') do (
  set /a themeCnt0+=1
  set "theme0!themeCnt0!=%%F"
)

for /l %%N in (1 1 %themeCnt0%) do echo %%N - !theme0%%N!
echo(

set selection0=
set /p selection0= Enter Theme number (exit: 0): 
set themeSel0=!theme0%selection0%!

IF %selection0% == 0 EXIT 
IF %selection0% == 19 GOTO menu1

::PREVIEW
set /P M=Show Preview? (Y/N): 
  goto :preview0_%M% 2>nul || (
    echo Something else
  )
  goto :end

:preview0_Y
"%userprofile%\Spicetify\bin\Gallerie\%themeSel0%.png"
:preview0_N
::SWITCH
set /P M=Choose this Theme? (Y/N): 
  goto :apply0_%M% 2>nul || (
    echo Something else
  )
  goto :end

:apply0_Y
cls
::THEME_INSTALLATION
PowerShell.exe -Command "spicetify restore"
rmdir %userprofile%\.spicetify /s /q
mkdir %userprofile%\.spicetify 
xcopy "%userprofile%\.spicetifyBackup" "%userprofile%\.spicetify" /s/h/e/k/f/c>nul
cls
cd %userprofile%\.spicetify\Themes\%themeSel0%
PowerShell.exe -Command "spicetify config current_theme %themeSel0%"
PowerShell.exe -Command "spicetify config inject_css 1 replace_colors 1 overwrite_assets 1"
echo.
cls
PowerShell.exe -Command "spicetify backup"
echo.
PowerShell.exe -Command "spicetify apply"

:apply0_N
GOTO menu0






:menu1
cls
cd %userprofile%\.spicetify\Themes\%themeSel0%

::SKIN_SELECTION
set themeCnt1=0
for /f "eol=: delims=" %%F in ('dir /b /a *.png') do (
  set /a themeCnt1+=1
  set "theme2!themeCnt1!=%%F"
)

for /l %%N in (1 1 %themeCnt1%) do echo %%N - !theme2%%N:~0,-4!
echo(

set selection1=
set /p selection1= Enter Theme number (return: 0): 

IF %selection1% == 0 GOTO menu0

set themeSel1=!theme2%selection1%!

::PREVIEW
set /P M=Show Preview? (Y/N): 
  goto :preview1_%M% 2>nul || (
    echo Something else
  )
  goto :end

:preview1_Y
"%userprofile%\Spicetify\bin\Gallerie\%themeSel0% - %themeSel1%"
:preview1_N
::SWITCH
set /P M=Choose This Theme? (Y/N): 
  goto :apply1_%M% 2>nul || (
    echo Something else
  )
  goto :end

:apply1_Y

cd %userprofile%
cls
::SKIN_INSTALLATION
PowerShell.exe -Command "spicetify restore"
rmdir %userprofile%\.spicetify /s /q
mkdir %userprofile%\.spicetify 
xcopy "%userprofile%\.spicetifyBackup" "%userprofile%\.spicetify" /s/h/e/k/f/c>nul
cls
cd %userprofile%\.spicetify\Themes\%themeSel0%
PowerShell.exe -Command "Copy-Item dribbblish.js ..\..\Extensions"
echo.
PowerShell.exe -Command "spicetify config extensions dribbblish.js"
PowerShell.exe -Command "spicetify config current_theme %themeSel0% color_scheme %themeSel1:~0,-4%"
PowerShell.exe -Command "spicetify config inject_css 1 replace_colors 1 overwrite_assets 1"
echo.
cls
PowerShell.exe -Command "spicetify backup"
echo.
PowerShell.exe -Command "spicetify apply"
cls
GOTO menu0

:apply1_N
GOTO menu1