# Generates web/og-image.png (1200x630) for Open Graph social card sharing.
# Run from the project root:
#   pwsh -File tool/generate_og_image.ps1
# Or:
#   powershell -ExecutionPolicy Bypass -File tool/generate_og_image.ps1

Add-Type -AssemblyName System.Drawing

$outPath = Join-Path $PSScriptRoot '..\web\og-image.png'
$outPath = [System.IO.Path]::GetFullPath($outPath)

$width  = 1200
$height = 630

$bitmap = New-Object System.Drawing.Bitmap $width, $height
$g = [System.Drawing.Graphics]::FromImage($bitmap)
$g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

# --- Background: diagonal gradient (navy -> blue -> purple) ---
$bgRect = New-Object System.Drawing.Rectangle 0, 0, $width, $height
$bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $bgRect,
    [System.Drawing.Color]::FromArgb(255, 5, 10, 26),     # #050A1A
    [System.Drawing.Color]::FromArgb(255, 26, 17, 48),    # #1A1130
    45.0
)
$g.FillRectangle($bgBrush, $bgRect)

# --- Decorative blobs ---
function Draw-Blob ($x, $y, $size, $r, $g_, $b, $alpha) {
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddEllipse($x, $y, $size, $size)
    $brush = New-Object System.Drawing.Drawing2D.PathGradientBrush($path)
    $brush.CenterColor = [System.Drawing.Color]::FromArgb($alpha, $r, $g_, $b)
    $brush.SurroundColors = ,([System.Drawing.Color]::FromArgb(0, $r, $g_, $b))
    $g.FillEllipse($brush, $x, $y, $size, $size)
}
Draw-Blob -120 -120 700 64 196 255 80   # cyan
Draw-Blob ($width - 500) ($height - 380) 700 156 123 255 70   # purple
Draw-Blob 700 -200 500 255 215 0 50    # gold

# --- Brand text: "Mostafa Badr" ---
$nameFont = New-Object System.Drawing.Font('Segoe UI', 70, [System.Drawing.FontStyle]::Bold)
$nameBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
$g.DrawString('Mostafa Badr', $nameFont, $nameBrush, 80, 120)

# Underline gradient
$underlineRect = New-Object System.Drawing.Rectangle 80, 220, 280, 6
$underlineBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $underlineRect,
    [System.Drawing.Color]::FromArgb(255, 255, 215, 0),
    [System.Drawing.Color]::FromArgb(255, 64, 196, 255),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($underlineBrush, $underlineRect)

# --- Role line ---
$roleFont = New-Object System.Drawing.Font('Segoe UI Semibold', 40)
$roleBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 64, 196, 255))
$g.DrawString('Mid-Level Flutter Developer', $roleFont, $roleBrush, 80, 250)

# --- Tagline ---
$tagFont = New-Object System.Drawing.Font('Segoe UI', 26)
$tagBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 200, 200, 220))
$g.DrawString('Odoo ERP Specialist · Clean Architecture · Bilingual RTL', $tagFont, $tagBrush, 80, 320)

# --- Stats row ---
function Draw-Stat ($x, $value, $label, $r, $gc, $b) {
    $valueFont = New-Object System.Drawing.Font('Segoe UI', 56, [System.Drawing.FontStyle]::Bold)
    $valueBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, $r, $gc, $b))
    $g.DrawString($value, $valueFont, $valueBrush, $x, 420)

    $labelFont = New-Object System.Drawing.Font('Segoe UI', 16, [System.Drawing.FontStyle]::Bold)
    $labelBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 180, 180, 200))
    $g.DrawString($label, $labelFont, $labelBrush, $x, 500)
}
Draw-Stat 80  '6'    'LIVE APPS'        64 196 255
Draw-Stat 320 '4'    'ODOO ECOSYSTEM'   34 211 238
Draw-Stat 600 '2.5+' 'YEARS'            255 215 0

# --- "Available" pill (top-right) ---
$pillFont = New-Object System.Drawing.Font('Segoe UI', 18, [System.Drawing.FontStyle]::Bold)
$pillBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 52, 211, 153))
$pillBgBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(40, 52, 211, 153))
$pillRect = New-Object System.Drawing.RectangleF 900, 80, 240, 50
$g.FillRectangle($pillBgBrush, $pillRect)
$g.DrawString('● Available for hire', $pillFont, $pillBrush, 920, 92)

# --- Save ---
$bitmap.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bitmap.Dispose()

Write-Host "Generated: $outPath ($width x $height)"
