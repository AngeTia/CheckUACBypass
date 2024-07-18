# Gompou Tia Ange
Full Stack Developer | CyberSecurity Enthusiast

## Description

`CheckUACBypass.ps1` is a PowerShell script designed to test if certain executables can be used to bypass User Account Control (UAC) on Windows systems. The script modifies the registry to temporarily redirect the execution of specified programs to a user-defined executable, attempting to gain elevated privileges.

## Usage

To use the script, run it in PowerShell with administrator privileges. The script accepts the following parameters:

- `-programPath`: The path to the program you want to execute with elevated privileges (default is `c:\users\user1\downloads\demon.x64.exe`).
- `-k`: The key representing the bypass executable (default is `fodhelper`).

### Example

```

powershell .\CheckUACBypass.ps1 -programPath "c:\path\to\your\program.exe" -k fodhelper

```

### Supported Bypass Executables

The script currently supports the following bypass executables:

- `fodhelper`: `C:\Windows\System32\fodhelper.exe`
- `eventvwr`: `C:\Windows\System32\eventvwr.exe`
- `compmgmt`: `C:\Windows\System32\compmgmt.msc`
- `taskschd`: `C:\Windows\System32\taskschd.msc`

### How It Works

1. **Registry Modification**: The script creates a registry entry under `HKCU:\Software\Classes\ms-settings\Shell\Open\command` to redirect the execution of the specified bypass executable to the user-defined program.
2. **UAC Bypass Attempt**: The script attempts to start the bypass executable.
3. **Clean Up**: The script removes the temporary registry entry after a short delay.

# Disclaimer of Liability

This script is provided for educational and research purposes only. Unauthorized use of this script to bypass security mechanisms on a system you do not own or have explicit permission to test is illegal and unethical. The authors and distributors of this script are not responsible for any damages or legal issues that may arise from its use. Use this script responsibly and in accordance with all applicable laws and regulations.

By using this script, you agree to take full responsibility for your actions and any consequences that may result from using the script. The authors and distributors disclaim all warranties, express or implied, and accept no liability for any damages or loss of data resulting from the use or misuse of this script.

- Ensure that you run the script with the necessary permissions and in a controlled environment.
- Always obtain proper authorization before attempting any kind of security testing.