# Check for administrative privileges
function Test-Admin {
    $currentIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($currentIdentity)
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Relaunch the script with administrative privileges if not already running as admin
if (-not (Test-Admin)) {
    $arguments = "& '" + $MyInvocation.MyCommand.Path + "'"
    Start-Process powershell -ArgumentList $arguments -Verb RunAs
    exit
}

# Load Windows Forms for file dialog
Add-Type -AssemblyName System.Windows.Forms

# Function to open a file dialog and select an executable
function Get-FileName {
    param (
        [string]$Filter = "Executable files (*.exe)|*.exe|All files (*.*)|*.*",
        [string]$Title = "Select the executable file"
    )

    $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $fileDialog.Filter = $Filter
    $fileDialog.Title = $Title

    if ($fileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $fileDialog.FileName
    }
    return $null
}

# Initialize an array to hold error messages
$errorMessages = @()

# Prompt the user to select an executable file
$exePath = Get-FileName

if (-not $exePath) {
    $errorMessages += "No executable file selected. Exiting."
}

# Define the task action
$action = New-ScheduledTaskAction -Execute $exePath

# Get the current user's SID
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$userSid = $currentUser.User.Value

# Define the principal (user context) using the current user
$principal = New-ScheduledTaskPrincipal -UserId $userSid -LogonType Interactive -RunLevel Highest

# Define the settings for the task
try {
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -ErrorAction Stop
} catch {
    $errorMessages += "Error creating task settings: $_"
}

# Create the scheduled task
try {
    $task = New-ScheduledTask -Action $action -Principal $principal -Settings $settings -ErrorAction Stop
} catch {
    $errorMessages += "Error creating the scheduled task: $_"
}

# Check if the task was created successfully
if ($null -eq $task) {
    $errorMessages += "Failed to create the scheduled task. Exiting."
}

# Register the task in Task Scheduler
try {
    Register-ScheduledTask -TaskName "HSR" -InputObject $task -ErrorAction Stop
    Write-Host "Scheduled task 'HSR' created successfully."
} catch {
    $errorMessages += "Error registering the scheduled task: $_"
}

# Create a shortcut to run the scheduled task
$shortcutPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), "Run HSR.lnk")
$shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($shortcutPath)

# Set the shortcut properties
$shortcut.TargetPath = "C:\Windows\System32\schtasks.exe"
$shortcut.Arguments = "/run /TN HSR"
$shortcut.WorkingDirectory = "C:\Windows\System32"
$shortcut.IconLocation = $exePath  # Set the icon to the selected executable
$shortcut.Save()

Write-Host "Shortcut 'Run HSR' created on the Desktop."

# Check if there were any errors and display them
if ($errorMessages.Count -gt 0) {
    Write-Host "The following errors occurred:"
    $errorMessages | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "All operations completed successfully."
}

# Prompt the user to press any key before exiting
Read-Host -Prompt "Press Enter to exit"
