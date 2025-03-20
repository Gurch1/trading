param (
    [Parameter(Mandatory=$false)]
    [string]$ConfigFile = "C:\trading\config.ini"
)

Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"

function Update-PositionSize {
    param (
        [string]$inputValue,
        [string]$filePath
    )
    
    # If the user didn't provide any input, set a default value
    if ([string]::IsNullOrWhiteSpace($inputValue)) {
        $replaceString = '$positionsize=0.1'
    } else {
        # Validate input is a proper number format
        if ($inputValue -match '^\d*\.?\d+$') {
            $replaceString = '$positionsize=' + $inputValue
        } else {
            [System.Windows.Forms.MessageBox]::Show("Please enter a valid number (e.g., 0.5, 1, 1.25)", "Invalid Input", 
                [System.Windows.Forms.MessageBoxButtons]::OK, 
                [System.Windows.Forms.MessageBoxIcon]::Warning)
            return $false
        }
    }

    # Check if file exists
    if (-not (Test-Path $filePath)) {
        [System.Windows.Forms.MessageBox]::Show("Config file not found: $filePath", "Error", 
            [System.Windows.Forms.MessageBoxButtons]::OK, 
            [System.Windows.Forms.MessageBoxIcon]::Error)
        return $false
    }

    try {
        # Read the file
        $content = Get-Content $filePath

        # Ensure the regex is applied correctly
        $content = $content | ForEach-Object {
            if ($_ -match '^\$positionsize=.*') {
                # If the line matches $positionsize, replace it
                $_ -replace '^\$positionsize=.*', $replaceString
            } else {
                # Otherwise, leave the line unchanged
                $_
            }
        }

        # Write the modified content back to the file
        Set-Content $filePath $content
        return $true
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Error updating file: $_", "Error", 
            [System.Windows.Forms.MessageBoxButtons]::OK, 
            [System.Windows.Forms.MessageBoxIcon]::Error)
        return $false
    }
}

# Create a form with improved styling
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Trading Position Size'
$form.Width = 350
$form.Height = 200
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)
$form.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
$form.TopMost = $true  # Keep window on top

# Create a panel for better organization
$panel = New-Object System.Windows.Forms.Panel
$panel.Dock = [System.Windows.Forms.DockStyle]::Fill
$panel.Padding = New-Object System.Windows.Forms.Padding(20)
$form.Controls.Add($panel)

# Create a label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Enter position size:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(0, 10)
$label.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Regular)
$panel.Controls.Add($label)

# Display current config file
$configLabel = New-Object System.Windows.Forms.Label
$configLabel.Text = "Config: $ConfigFile"
$configLabel.AutoSize = $true
$configLabel.Location = New-Object System.Drawing.Point(0, 35)
$configLabel.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Italic)
$configLabel.ForeColor = [System.Drawing.Color]::DarkGray
$panel.Controls.Add($configLabel)

# Create a textbox for input with styling
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(0, 65)
$textBox.Width = 300
$textBox.Height = 25
$textBox.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)
$textBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$panel.Controls.Add($textBox)

# Create button panel for alignment
$buttonPanel = New-Object System.Windows.Forms.Panel
$buttonPanel.Width = 300
$buttonPanel.Height = 40
$buttonPanel.Location = New-Object System.Drawing.Point(0, 105)
$panel.Controls.Add($buttonPanel)

# Create an OK button with styling
$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = 'Update'
$okButton.Width = 100
$okButton.Height = 30
$okButton.Location = New-Object System.Drawing.Point(0, 0)
$okButton.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 212)
$okButton.ForeColor = [System.Drawing.Color]::White
$okButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$okButton.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$buttonPanel.Controls.Add($okButton)

# Create a Cancel button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Text = 'Cancel'
$cancelButton.Width = 100
$cancelButton.Height = 30
$cancelButton.Location = New-Object System.Drawing.Point(110, 0)
$cancelButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$buttonPanel.Controls.Add($cancelButton)

# Add status label for feedback
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.AutoSize = $true
$statusLabel.Location = New-Object System.Drawing.Point(0, 145)
$statusLabel.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Regular)
$panel.Controls.Add($statusLabel)

# Event handler for OK button
$okButton.Add_Click({
    $result = Update-PositionSize -inputValue $textBox.Text.Trim() -filePath $ConfigFile
    if ($result) {
        $statusLabel.Text = "Position size updated successfully!"
        $statusLabel.ForeColor = [System.Drawing.Color]::Green
        # Auto-close after successful update (1.5 seconds)
        $timer = New-Object System.Windows.Forms.Timer
        $timer.Interval = 1500
        $timer.Add_Tick({
            $form.Close()
            $timer.Stop()
        })
        $timer.Start()
    }
})

# Event handler for Cancel button
$cancelButton.Add_Click({
    $form.Close()
})

# Set the form's AcceptButton to the OK button so Enter triggers it
$form.AcceptButton = $okButton
$form.CancelButton = $cancelButton

# Automatically focus the textBox when the form appears and force activation
$form.Add_Shown({
    $form.Activate()
    $textBox.Select()
    $textBox.Focus()
    
    # Ensure form is active and focused
    [System.Windows.Forms.Application]::DoEvents()
})

# Show the form
[void]$form.ShowDialog()
