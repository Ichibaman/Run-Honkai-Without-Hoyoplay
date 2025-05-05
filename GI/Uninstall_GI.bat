@echo off
SET TASK_NAME=GI
SET SHORTCUT_NAME=Run GI.lnk
SET SHORTCUT_PATH="%USERPROFILE%\Desktop\%SHORTCUT_NAME%"

REM Check for administrative privileges
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo This script requires administrative privileges. Please allow it to run as administrator.
    pause
    PowerShell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit
)

echo Uninstalling scheduled task and shortcut...

REM Delete the scheduled task
echo Deleting scheduled task %TASK_NAME%...
schtasks /delete /tn %TASK_NAME% /f
if %errorLevel% == 0 (
    echo Scheduled task '%TASK_NAME%' has been deleted successfully.
) else (
    echo Failed to delete scheduled task '%TASK_NAME%'. It may not exist.
)

REM Check if the shortcut exists and delete it
IF EXIST %SHORTCUT_PATH% (
    del %SHORTCUT_PATH%
    if %errorLevel% == 0 (
        echo Shortcut '%SHORTCUT_NAME%' has been deleted successfully.
    ) else (
        echo Failed to delete shortcut '%SHORTCUT_NAME%'.
    )
) ELSE (
    echo Shortcut '%SHORTCUT_NAME%' does not exist.
)

echo Uninstall process completed.
echo.
echo Press Enter to close this window.
pause >nul
