# BTC Position Size Updater

A PowerShell script for quickly updating trading position sizes in your cTrader configuration file.

## Overview

This script provides a simple GUI interface that allows traders to easily update their position size parameter in a configuration file. It's designed to work with cTrader ATP autohotkeys for Bitcoin trading setups.

## Features

- Clean, modern user interface
- Input validation for proper numeric values
- Immediate feedback on successful updates
- Auto-close functionality after successful updates
- Always stays on top of other windows for easy access
- Error handling for common issues
- Default value handling (0.1) if no input is provided

## Requirements

- Windows operating system
- PowerShell 5.1 or higher
- .NET Framework (included with Windows)
- Write access to the configuration file location

## Installation

1. Save the `Update-PositionSize.ps1` script to your desired location
2. Make sure your PowerShell execution policy allows running scripts
3. If needed, modify the default config file path in the script

## Usage

### Running the Script

There are multiple ways to run the script:

1. **Direct PowerShell execution:**
   ```powershell
   .\Update-PositionSize.ps1
   ```

2. **With a custom config file path:**
   ```powershell
   .\Update-PositionSize.ps1 -ConfigFile "C:\path\to\your\config.ini"
   ```

3. **From Windows Explorer:**
   - Right-click the script
   - Select "Run with PowerShell"

4. **From Stream Deck or similar macro tool:**
   - Configure a button to execute the PowerShell script

### Using the Interface

1. Enter your desired position size (e.g., 0.5, 1.25, 2)
2. Click "Update" or press Enter to save changes
3. Click "Cancel" or press Esc to exit without changes

## Configuration

By default, the script uses the following configuration file path:
```
W:\Stream Deck\Trading\ctrader ATP autohotkeys\btc-config.ini
```

You can change this by:
- Editing the default path in the script
- Specifying a different path when running the script with the `-ConfigFile` parameter

## Troubleshooting

- **"Config file not found" error:**
  Verify the config file path is correct and accessible

- **"Invalid Input" warning:**
  Ensure you're entering a valid numeric value (e.g., 0.5, 1, 2.75)

- **"Error updating file" message:**
  Check that you have write permissions to the config file

## Integration with Trading Workflows

This tool is designed to be integrated with:
- Stream Deck buttons for quick trading adjustments
- cTrader ATP autohotkey scripts
- Bitcoin trading setups

## License

This script is provided as-is for personal trading use.

## Author

Created for Bitcoin trading workflow optimization.
