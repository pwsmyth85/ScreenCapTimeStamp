# Prompt the user to select a screen
$screens = [System.Windows.Forms.Screen]::AllScreens

Write-Host "Available Screens:"
for ($i = 0; $i -lt $screens.Count; $i++) {
    Write-Host ($i.ToString() + ": " + $screens[$i].DeviceName)
}

$screenIndex = Read-Host "Select Screen (Enter the index of the screen)"

# Check if the provided screen index is valid
if ($screenIndex -ge 0 -and $screenIndex -lt $screens.Count) {
    $selectedScreen = $screens[$screenIndex]
} else {
    Write-Host "Invalid screen index. Exiting."
    exit
}

# Prompt the user to select full-screen or specify rectangle
$fullscreen = Read-Host "Capture Fullscreen? (yes/no)"

if ($fullscreen -eq "yes") {
    # Capture full-screen
    $rectangleX = $selectedScreen.Bounds.X
    $rectangleY = $selectedScreen.Bounds.Y
    $rectangleWidth = $selectedScreen.Bounds.Width
    $rectangleHeight = $selectedScreen.Bounds.Height
} elseif ($fullscreen -eq "no") {
    # Print screen dimensions
    Write-Host "Selected Screen Dimensions:"
    Write-Host "Width: $($selectedScreen.Bounds.Width) pixels"
    Write-Host "Height: $($selectedScreen.Bounds.Height) pixels"
    
    # Prompt the user to specify position and size of the rectangle
    do {
        $rectangleX = Read-Host "Enter X-coordinate of the top-left corner of the rectangle"
    } while (-not [int]::TryParse($rectangleX, [ref]$null))

    do {
        $rectangleY = Read-Host "Enter Y-coordinate of the top-left corner of the rectangle"
    } while (-not [int]::TryParse($rectangleY, [ref]$null))

    do {
        $rectangleWidth = Read-Host "Enter Width of the rectangle"
    } while (-not [int]::TryParse($rectangleWidth, [ref]$null))

    do {
        $rectangleHeight = Read-Host "Enter Height of the rectangle"
    } while (-not [int]::TryParse($rectangleHeight, [ref]$null))
} else {
    Write-Host "Invalid input. Exiting."
    exit
}

# Specify the directory where you want to save the screenshot
$saveDirectory = "ADDYOURSAVEDIRECTORY"

# Create the directory if it doesn't exist
if (-not (Test-Path $saveDirectory)) {
    New-Item -ItemType Directory -Path $saveDirectory | Out-Null
}

# Capture screenshot of the specified rectangle
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$bitmap = New-Object System.Drawing.Bitmap ([int]$rectangleWidth), ([int]$rectangleHeight + 20)  # Increased height for the black row
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.FillRectangle([System.Drawing.Brushes]::Black, 0, 0, $rectangleWidth, 20)  # Drawing black row
$graphics.CopyFromScreen([int]$selectedScreen.Bounds.X + [int]$rectangleX, [int]$selectedScreen.Bounds.Y + [int]$rectangleY, 0, 20, $bitmap.Size)  # Shifted by 20 pixels to accommodate the black row

# Add timestamp and user name
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$userName = $env:USERNAME
$text = "$timestamp | User: $userName"
$font = New-Object System.Drawing.Font("Arial", 10)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$graphics.DrawString($text, $font, $brush, 10, 0)

# Save the screenshot
$bitmap.Save("$saveDirectory\screenshot_$timestamp.png", [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$graphics.Dispose()
$bitmap.Dispose()

Write-Host "Screenshot saved to: $saveDirectory\screenshot_$timestamp.png"
