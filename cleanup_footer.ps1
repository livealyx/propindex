$path = Join-Path $PSScriptRoot "index.html"
$content = Get-Content -Path $path -Raw

# Remove the orphaned old-footer fragment that sits after </footer> (first occurrence)
# Strategy: keep everything up to and including the first </footer>, then jump to the script tag
$firstFooterEnd = $content.IndexOf("</footer>")
$scriptTagStart = $content.IndexOf("<script>", $firstFooterEnd)

if ($firstFooterEnd -ge 0 -and $scriptTagStart -ge 0) {
    $before = $content.Substring(0, $firstFooterEnd + "</footer>".Length)
    $after   = $content.Substring($scriptTagStart)
    $cleaned = $before + "`n`n    " + $after
    Set-Content -Path $path -Value $cleaned -Encoding UTF8
    Write-Host "Cleaned. File saved."
} else {
    Write-Host "Could not locate markers. No changes made."
}
