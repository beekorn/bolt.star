@echo off
echo Starting Bolt.custom development server...

REM Run the development server
echo Starting the development server...
echo Note: For best results, use Chrome Canary for local development

REM Start the server and browser in parallel
start /b npm run dev

REM Reduce timeout and check for server availability
set PORT=5173
set ATTEMPTS=0
:WAIT_FOR_SERVER
timeout /t 1 /nobreak > nul
set /a ATTEMPTS+=1
curl -f http://localhost:%PORT% >nul 2>&1
if errorlevel 1 (
    if %ATTEMPTS% leq 10 goto WAIT_FOR_SERVER
) else (
    if exist "%LOCALAPPDATA%\Google\Chrome SxS\Application\chrome.exe" (
        echo Opening Chrome Canary...
        start "" "%LOCALAPPDATA%\Google\Chrome SxS\Application\chrome.exe" "http://localhost:%PORT%"
    ) else (
        echo Chrome Canary not found! Please install it from: https://www.google.com/chrome/canary/
        echo Then open http://localhost:%PORT% in Chrome Canary
    )
)

echo Note: You may see some provider errors on startup - this is normal.
echo These errors just mean some AI providers aren't configured yet.
echo You can configure providers through the UI once the application loads.

echo       B O L T . S T A R
echo         ***  Welcome  ***

pause