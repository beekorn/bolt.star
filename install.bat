@echo off
echo Starting Bolt.custom installation...

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Node.js is not installed! Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM Initialize git if not already initialized
if not exist ".git" (
    echo Initializing git repository...
    git init
    git add .
    git commit -m "Initial commit"
)

REM Install dependencies using npm
echo Installing dependencies...
call npm install

REM Install Remix dependencies explicitly
echo Installing Remix dependencies...
call npm install --save-dev @remix-run/dev@latest @remix-run/node@latest @remix-run/react@latest @remix-run/serve@latest

REM Create the shortcut with full path displayed
echo Creating Bolt shortcut...
set "CURRENT_DIR=%CD%"
echo Creating shortcut at: %CURRENT_DIR%\bolt.lnk
echo Set oWS = WScript.CreateObject("WScript.Shell") > create_shortcut.vbs
echo sLinkFile = "%CURRENT_DIR%\bolt.lnk" >> create_shortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> create_shortcut.vbs
echo oLink.TargetPath = "%CURRENT_DIR%\run.bat" >> create_shortcut.vbs
echo oLink.WorkingDirectory = "%CURRENT_DIR%" >> create_shortcut.vbs
echo oLink.IconLocation = "%CURRENT_DIR%\icons\bolt.ico" >> create_shortcut.vbs
echo oLink.Save >> create_shortcut.vbs
cscript //nologo create_shortcut.vbs
del create_shortcut.vbs

if exist "%CURRENT_DIR%\bolt.lnk" (
    echo Shortcut created successfully at: %CURRENT_DIR%\bolt.lnk
) else (
    echo Failed to create shortcut!
)

echo Installation complete! You can now run the application by double-clicking bolt.lnk
pause