# Run-Honkai-Without-Hoyoplay
Play your Hoyoverse Game without launch Hoyoplay

This project provides a PowerShell script and a batch file to run Honkai Impact without needing to launch Hoyoplay. The script creates a scheduled task that allows you to start the game directly from your desktop. Work with any Hoyoverse Games.

## Disclaimer

This script is provided as-is without any warranty. Use it at your own risk. Ensure that you trust the source of the executable file you select.

## Features

- **Administrative Privileges**: The script checks for administrative privileges and relaunches itself with elevated permissions if necessary.
- **File Selection**: Users can select the executable file for Honkai Impact through a file dialog.
- **Scheduled Task Creation**: The script creates a scheduled task to run the game, allowing it to run with the highest privileges.
- **Desktop Shortcut**: A shortcut is created on the desktop to easily launch the game.

## Prerequisites

- Windows operating system
- PowerShell (comes pre-installed with Windows)
- Administrative privileges to create scheduled tasks

## Usage

1. **Download the Repository**: Clone or Download ZIP this repository to your local machine.

   ```bash
   git clone https://github.com/Ichibaman/Run-Honkai-Without-Hoyoplay.git
   ```

2. **Navigate to the Directory**: Open a File Explorer and navigate to the directory where the files are located.

3. **Run the Batch File**: Execute the `Run.bat` file to start the PowerShell script.

   ```bash
   Run_Honkai.bat
   ```
   - **User Account Control (UAC)**: When prompted by User Account Control, click "Yes" to allow the script to run with administrative privileges.

4. **Select the Executable**: A file dialog will open. Navigate to the location of the Honkai Impact executable file (e.g., `D:\Honkai Impact 3 sea\Games\BH3.exe`) and select it. If you dont know where the executable file you can check in Hoyoplay "Game Settings" and "Open Directory".
![easysteps](https://github.com/Ichibaman/Run-Honkai-Without-Hoyoplay/blob/main/image/GameSettings.png)

5. **Wait** till script done and press enter to close script.

6. **Launch the Game**: A shortcut named "Run Honkai" will be created on your desktop. Double-click this shortcut to launch Honkai Impact directly. Enjoy your game with simple click.
![easysteps](https://github.com/Ichibaman/Run-Honkai-Without-Hoyoplay/blob/main/image/Shortcut.png)

## Error Handling

If any errors occur during the execution of the script, they will be displayed in the console. Ensure that you have selected the correct executable file and that you have the necessary permissions.

## Cleanup/Uninstall

To remove the scheduled task and the desktop shortcut, you can manually delete the shortcut and use the Task Scheduler to delete the task named "Honkai".

![easysteps](https://github.com/Ichibaman/Run-Honkai-Without-Hoyoplay/blob/main/image/TaskScheduler1.png)
![easysteps](https://github.com/Ichibaman/Run-Honkai-Without-Hoyoplay/blob/main/image/TaskScheduler.png)

## Contributing

Contributions are welcome! If you have suggestions for improvements or find any issues, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

