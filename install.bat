@echo off
echo Starting Bolt.star installation...

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

echo Installation complete!
pause
