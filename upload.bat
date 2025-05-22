@echo off
REM ========================================================
REM upload_main.bat
REM Automate adding, committing, and pushing to main branch
REM for the sjghs_book repository.
REM IMPORTANT: Run this script from the ROOT of your
REM 'sjghs_book' local repository.
REM ========================================================

REM Change to the directory of this script (i.e. your repo root)
cd /d %~dp0

REM Stage all changes
echo Staging all changes for sjghs_book...
git add .

REM Prompt for a commit message
set /p COMMIT_MSG="Enter commit message for sjghs_book (leave blank for 'Auto-update'): "
if "%COMMIT_MSG%"=="" (
    set "COMMIT_MSG=Auto-update"
)

REM Commit
echo Committing with message: "%COMMIT_MSG%"
git commit -m "%COMMIT_MSG%"

REM Push to main branch on origin
REM This assumes 'origin' remote points to https://github.com/hareguu2142/sjghs_book.git
echo Pushing to origin/main (sjghs_book)...
git push origin main

REM Check for errors
if errorlevel 1 (
    echo.
    echo ERROR: Something went wrong during push.
    echo Please check your Git configuration and network.
    pause
    exit /b 1
)

echo.
echo ✅ Successfully pushed to main (sjghs_book)!
pause
