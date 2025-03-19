# Position Size Plugin for Stream Deck

A Stream Deck plugin that displays trading position size information from a configuration file on a Stream Deck button. This plugin is designed for traders who want to keep track of their current position size without switching applications.

## Features

- Displays current position size on a Stream Deck button
- Automatically updates when the position size changes
- Customizable background image from URL or local file
- Highly configurable appearance (colors, fonts, title)
- Customizable update interval
- Configurable position size format (decimal places, percentage)
- Visual feedback through color changes
- Support for both local and network paths

## Use Cases

This plugin is particularly useful for:

- Cryptocurrency traders using cTrader
- Stock traders who need to monitor position sizes
- Any trader who automates position sizing with scripts that write to a config file

## Requirements

- Elgato Stream Deck hardware
- Stream Deck software (v4.1 or later)
- Windows 10 or macOS 10.11 or later
- Trading software that writes position size to a configuration file

## Installation

### From Release

1. Download the latest release from the [Releases](https://github.com/yourusername/streamdeck-positionsize/releases) page
2. Double-click the downloaded file to install it to your Stream Deck

### Manual Installation

1. Download or clone this repository
2. Copy the entire `com.gurch.positionsize.sdPlugin` folder to:
   - Windows: `%appdata%\Elgato\StreamDeck\Plugins`
   - macOS: `~/Library/Application Support/com.elgato.StreamDeck/Plugins`
3. Restart the Stream Deck software

## Configuration

After adding the button to your Stream Deck, you can configure the following settings:

### Configuration

- **Config Path**: Path to the file containing the position size information
- **Update Interval**: How often to check for updates (in milliseconds)
- **Position Size Regex**: Regular expression with a capture group to extract the position size
- **Display Format**: Control decimal places and whether to show as percentage
- **Debug Mode**: Enable detailed logging for troubleshooting file path issues

### Appearance

- **Title**: Text label shown above the position size value
- **Title Alignment**: Positioning of text on the button (top, middle, bottom)
- **Font Size**: Size of the text
- **Font Family**: Font used for the text
- **Text Color**: Normal color of the text
- **Success Color**: Color when position size is successfully loaded
- **Error Color**: Color when there's an error reading the position size

### Background Image

- **Use Background**: Toggle to enable/disable custom background image
- **Image URL/Path**: URL to an online image or local file path to use as background
- **Preview**: Shows how the background will look on your button

The background image will be automatically resized to fit the Stream Deck button (144×144 pixels). Both online URLs and local file paths are supported.

## How It Works

1. The plugin reads a configuration file at a specified location
2. It extracts the position size using a regular expression
3. The position size is displayed on a Stream Deck button
4. The plugin periodically checks for changes to the position size

## Default Configuration Format

By default, the plugin expects to find a line like this in the configuration file:

```
$positionsize=0.5
```

The position size value (0.5 in this example) will be displayed on the button.

## Customizing the Regex Pattern

If your trading software uses a different format for storing position size, you can modify the regex pattern in the plugin settings:

Default: `/\$positionsize=([0-9.]+)/`

The part inside the parentheses `([0-9.]+)` is what gets captured and displayed on the button.

## File Path Handling

The plugin supports both local and network paths:

### Local paths:
```
C:/Trading/config.ini
```

### Network or mapped drive paths:
```
W:/Stream Deck/Trading/ctrader ATP autohotkeys/config.ini
```

If you run into issues with file paths, enable Debug Mode to see detailed logging in the Stream Deck console.

## Background Image Ideas

You can use any image as your button background. Here are some ideas:

- Trading platform logos
- Currency/stock symbols
- Custom indicators (green/red patterns)
- Personal branding elements
- Charts or graph patterns

Background images should ideally be 144×144 pixels, but the plugin will automatically resize larger images.

## Examples

### cTrader Format
```
$positionsize=0.5
```
Use regex: `\$positionsize=([0-9.]+)`

### MetaTrader Global Variable
```
GlobalVariableSet("PositionSize", 0.75);
```
Use regex: `PositionSize", ([0-9.]+)`

### TradingView Pine Script
```
strategy.risk.size_in_dollars = 500
```
Use regex: `size_in_dollars = ([0-9.]+)`

## Troubleshooting

If the position size is not showing:

1. Verify the config file path is correct
2. Check that the file is accessible by the Stream Deck application
3. Test the connection using the "Test Connection" button
4. Verify the regex pattern matches your configuration file format
5. Enable Debug Mode to see detailed logging
6. Check the browser console in Stream Deck (right-click on Stream Deck window → Inspect Element → Console)

### Background Image Issues

If your background image isn't showing:
1. Make sure "Use Background" is checked
2. For local paths, verify the file exists and is accessible
3. For URLs, ensure the image is publicly accessible
4. Check for typos in the path or URL
5. Some image hosts may block hotlinking - try downloading the image locally

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

If you encounter any issues or have questions, please submit an issue on GitHub.