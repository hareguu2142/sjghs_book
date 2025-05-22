@echo off
setlocal

REM ========================================================
REM pull_or_clone_repo.bat
REM Pulls latest changes from the sjghs_book repository
REM or clones it if it doesn't exist locally.
REM ========================================================

title Pull or Clone sjghs_book Repository
set "REPO_URL=https://github.com/hareguu2142/sjghs_book.git"
set "EXPECTED_REPO_DIR_NAME=sjghs_book"

REM Get the name of the current directory for comparison
for %%i in ("%CD%") do set "CURRENT_DIR_NAME=%%~ni"

REM Scenario 1: The script is run from INSIDE the repository directory
if /I "%CURRENT_DIR_NAME%"=="%EXPECTED_REPO_DIR_NAME%" (
    if exist ".git" (
        echo Repository 'sjghs_book' found in current directory ("%CD%").
        echo Pulling latest changes...
        git pull origin main
        if errorlevel 1 (
            echo Error: Failed to pull changes for sjghs_book.
            pause
            exit /b 1
        )
        goto :UpdateComplete
    )
)

REM Scenario 2: The repository exists as a subdirectory in the current location
if exist "%EXPECTED_REPO_DIR_NAME%\.git" (
    echo Repository 'sjghs_book' found in subdirectory: "%CD%\%EXPECTED_REPO_DIR_NAME%".
    echo Pulling latest changes...
    pushd "%EXPECTED_REPO_DIR_NAME%"
    git pull origin main
    if errorlevel 1 (
        echo Error: Failed to pull changes for sjghs_book.
        popd
        pause
        exit /b 1
    )
    popd
    goto :UpdateComplete
)

REM Scenario 3: Repository not found, proceed to clone
echo Repository 'sjghs_book' not found locally.
echo Cloning "%REPO_URL%" into directory "%EXPECTED_REPO_DIR_NAME%"...
git clone "%REPO_URL%" "%EXPECTED_REPO_DIR_NAME%"
if errorlevel 1 (
    echo Error: Failed to clone repository sjghs_book.
    pause
    exit /b 1
)
echo Successfully cloned 'sjghs_book' into "%CD%\%EXPECTED_REPO_DIR_NAME%".

:UpdateComplete
echo.
echo ✅ Update complete for sjghs_book.
pause
endlocal
exit /b 0
