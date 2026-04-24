$contactPath = Join-Path -Path $PSScriptRoot -ChildPath "contact.html"
$contactContent = Get-Content -Path $contactPath -Raw

$headRegex = '(?s)(<head>.*?</head>)'
$navRegex = '(?s)(<!-- Navigation -->.*?</nav>)'
$footerRegex = '(?s)(<!-- Footer -->.*?</footer>)'

$headMatch = [regex]::Match($contactContent, $headRegex)
$navMatch = [regex]::Match($contactContent, $navRegex)
$footerMatch = [regex]::Match($contactContent, $footerRegex)

if (-not $headMatch.Success -or -not $navMatch.Success -or -not $footerMatch.Success) {
    Write-Host "Could not find head, nav, or footer in contact.html"
    exit
}

$headContent = $headMatch.Value
$navContent = $navMatch.Value
$footerContent = $footerMatch.Value

# Get all html files
$htmlFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.html

foreach ($file in $htmlFiles) {
    if ($file.Name -eq "contact.html") { continue }
    
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
