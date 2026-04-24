$indexPath = Join-Path -Path $PSScriptRoot -ChildPath "index.html"
$indexContent = Get-Content -Path $indexPath -Raw

$headRegex = '(?s)(<head>.*?</head>)'
$navRegex = '(?s)(<!-- Navigation -->.*?</nav>)'
$footerRegex = '(?s)(<!-- Footer -->.*?</footer>)'

$headMatch = [regex]::Match($indexContent, $headRegex)
$navMatch = [regex]::Match($indexContent, $navRegex)
$footerMatch = [regex]::Match($indexContent, $footerRegex)

if (-not $headMatch.Success -or -not $navMatch.Success -or -not $footerMatch.Success) {
    Write-Host "Could not find head, nav, or footer in index.html"
    exit
}

$headContent = $headMatch.Value
$navContent = $navMatch.Value
$footerContent = $footerMatch.Value

# Add Alpine.js if not present
if ($headContent -notmatch "alpinejs") {
    $headContent = $headContent -replace '</head>', "    <script defer src=`"https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js`"></script>`n</head>"
}

# Update index.html head
$indexContent = $indexContent -replace '(?s)<head>.*?</head>', $headContent
Set-Content -Path $indexPath -Value $indexContent -Encoding UTF8

# Get all html files
$htmlFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.html

foreach ($file in $htmlFiles) {
    if ($file.Name -eq "index.html") { continue }
    
    $content = Get-Content -Path $file.FullName -Raw
    
    # Extract title
    $titleMatch = [regex]::Match($content, '<title>(.*?)</title>')
    $title = "PropIndex"
    if ($titleMatch.Success) {
        $title = $titleMatch.Groups[1].Value
    }
    
    # Generate new head
    $newHead = $headContent -replace '(?s)<title>.*?</title>', "<title>$title</title>"
    
    # Replace blocks
    $content = $content -replace '(?s)<head>.*?</head>', $newHead
    
    if ($content -match '(?s)<!-- Navigation -->.*?</nav>') {
        $content = $content -replace '(?s)<!-- Navigation -->.*?</nav>', $navContent
    } else {
        $content = $content -replace '(?s)<nav.*?</nav>', $navContent
    }
    
    if ($content -match '(?s)<!-- Footer -->.*?</footer>') {
        $content = $content -replace '(?s)<!-- Footer -->.*?</footer>', $footerContent
    } else {
        $content = $content -replace '(?s)<footer.*?</footer>', $footerContent
    }
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Updated $($file.Name)"
}
