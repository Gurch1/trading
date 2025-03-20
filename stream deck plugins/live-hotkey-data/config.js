/**
 * Stream Deck Position Size Plugin Configuration
 * 
 * This file contains default settings for the plugin.
 * Users can override these settings through the Property Inspector.
 */

const CONFIG = {
    // Plugin metadata
    plugin: {
        name: "Position Size",
        description: "Displays trading position size from a configuration file",
        version: "1.0.3",
        author: "Gurch"
    },
    
    // Action configuration
    action: {
        name: "Position Size",
        tooltip: "Displays current position size from a configuration file",
        supportedInMultiActions: false
    },
    
    // Display settings
    display: {
        title: "Size", // Label shown on the button
        titleAlignment: "middle",
        fontSize: "15",
        fontFamily: "Arial",
        color: "#FFFFFF", // Default text color
        backgroundColor: "", // Empty for default background
        successColor: "#00FF00", // Color when value is successfully loaded
        errorColor: "#FF0000", // Color when there's an error reading the value
        backgroundImage: "", // URL or local path to custom background image
        useBackgroundImage: false // Whether to use custom background image
    },
    
    // File and update settings
    settings: {
        // Default path to the configuration file that contains position size
        defaultConfigPath: "C:/Trading/config.ini",
        
        // How often to check for updates to the position size (in milliseconds)
        updateInterval: 1000,
        
        // Regular expression to extract position size from config file
        // The first capture group will be used as the position size
        positionSizeRegex: /\$positionsize=([0-9.]+)/,
        
        // Display format options
        showPercentage: false, // Whether to add % sign after the value
        decimalPlaces: 2, // Number of decimal places to display
        
        // Debug mode
        debug: true // Enable detailed logging for troubleshooting
    }
};

// Export configuration for use in other files
if (typeof module !== 'undefined') {
    module.exports = CONFIG;
}