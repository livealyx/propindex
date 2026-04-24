$folder = $PSScriptRoot
$files = Get-ChildItem -Path $folder -Filter "*.html"
$INR = [char]0x20B9  # Unicode Rupee sign: ₹

# Ordered replacements: specific first, generic last
$replacements = @(
    # --- Tenant verification pricing ---
    @('Identity Check \(\$19\)', "Identity Check (${INR}1,499)"),
    @('Comprehensive \(\$49\)',  "Comprehensive (${INR}3,999)"),
    @('Police Verification \(\$89\)', "Police Verification (${INR}6,999)"),
    @('\$19\b', "${INR}1,499"),
    @('\$49\b', "${INR}3,999"),
    @('\$89\b', "${INR}6,999"),
    # --- Rent values ---
    @('\$3,500 ', "${INR}35,000 "),
    @('\$3,500/mo', "${INR}35,000/mo"),
    @('\$10,500', "${INR}1,05,000"),
    @('\$1,800 ', "${INR}18,000 "),
    @('\$5,400', "${INR}54,000"),
    @('\$8,000', "${INR}8,000"),
    @('\$2,500', "${INR}2,500"),
    # --- Properties / Projects ---
    @('\$4,250,000', "${INR}3.5 Cr"),
    @('\$1,850,000', "${INR}1.5 Cr"),
    @('\$12\.4M', "${INR}10.2 Cr"),
    @('\$6\.5M',  "${INR}5.4 Cr"),
    @('\$4\.2M',  "${INR}3.5 Cr"),
    @('\$3\.5M',  "${INR}3 Cr"),
    @('\$2\.8M',  "${INR}2.3 Cr"),
    @('\$2\.1M',  "${INR}1.75 Cr"),
    @('\$1\.4M',  "${INR}1.2 Cr"),
    @('\$1\.2M',  "${INR}1 Cr"),
    @('\$1\.1M',  "${INR}90 L"),
    @('\$890k',   "${INR}74 L"),
    @('\$640k',   "${INR}54 L"),
    @('\$450k',   "${INR}38 L"),
    # --- Plot / Land ---
    @('Under \$50k',       "Under ${INR}50L"),
    @('\$50k - \$200k',    "${INR}50L - ${INR}2Cr"),
    @('\$200k - \$500k',   "${INR}2Cr - ${INR}5Cr"),
    @('Above \$500k',      "Above ${INR}5Cr"),
    @('\$120,000',         "${INR}1,20,000"),
    @('\$240/sq\.ft',      "${INR}240/sq.ft"),
    @('\$85,000',          "${INR}85,000"),
    @('\$85/sq\.ft',       "${INR}85/sq.ft"),
    @('\$120k',            "${INR}1.2 Cr"),
    @('\$85k',             "${INR}85 L"),
    # --- Stamp duty ---
    @('\$11,500', "${INR}11,500"),
    @('\$9,000',  "${INR}9,000"),
    @('\$1,500',  "${INR}1,500"),
    @('\$1,000',  "${INR}1,000"),
    # --- Price trends ---
    @('\$14,500',      "${INR}14,500"),
    @('\$12K - \$18K', "${INR}12K - ${INR}18K"),
    # --- Rent ranges (dropdowns) ---
    @('Under \$1K',   "Under ${INR}10K"),
    @('\$1K - \$3K',  "${INR}10K - ${INR}30K"),
    @('\$3K\+',       "${INR}30K+"),
    # --- PG / Co-living ---
    @('Under \$200',   "Under ${INR}5K"),
    @('\$200 - \$400', "${INR}5K - ${INR}10K"),
    @('\$400\+',       "${INR}10K+"),
    @('\$350 ',        "${INR}8,000 "),
    @('\$220 ',        "${INR}5,500 "),
    @('Dep: \$500',    "Dep: ${INR}15,000"),
    # --- Rent receipt ---
    @('\$\s*8,000/mo', "${INR}8,000/mo"),
    @('\$ 2,500',      "${INR} 2,500"),
    # --- Standalone $ input prefix icons ---
    @('>\$</', ">${INR}</"),
    @('">\$<', ">${INR}<"),
    # --- Catch-all: remaining $<digits> ---
    @('\$(\d)', "${INR}`$1")
)

$totalFiles = 0
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $original = $content

    foreach ($rule in $replacements) {
        $content = [regex]::Replace($content, $rule[0], $rule[1])
    }

    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated: $($file.Name)"
        $totalFiles++
    }
}

Write-Host ""
Write-Host "Done. $totalFiles file(s) updated to Indian Rupees."
