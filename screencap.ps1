# Specify the directory where you want to save the screenshot
$saveDirectory = "C:\Users\pete\screencaps"

# Create the directory if it doesn't exist
if (-not (Test-Path $saveDirectory)) {
    New-Item -ItemType Directory -Path $saveDirectory | Out-Null
}

# Capture screenshot
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$bitmap = New-Object System.Drawing.Bitmap $screen.Bounds.Width, $screen.Bounds.Height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.CopyFromScreen($screen.Bounds.Location, [System.Drawing.Point]::Empty, $screen.Bounds.Size)

# Add timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$font = New-Object System.Drawing.Font("Arial", 12)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$graphics.DrawString($timestamp, $font, $brush, 10, 10)

# Save the screenshot
$bitmap.Save("$saveDirectory\screenshot_$timestamp.png", [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$graphics.Dispose()
$bitmap.Dispose()
