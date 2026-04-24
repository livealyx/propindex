$indexPath = Join-Path -Path $PSScriptRoot -ChildPath "index.html"
$indexContent = Get-Content -Path $indexPath -Raw

# Extract parts using regex
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

# Replace title with placeholder
$headContent = $headContent -replace '(?s)<title>.*?</title>', '<!-- TITLE_PLACEHOLDER -->'

$pages = @(
    @{ file = 'buy-property.html'; title = 'Buy Property'; desc = 'Find your dream home from our vast collection of residential properties.' },
    @{ file = 'sell-property.html'; title = 'Sell Property'; desc = 'List your property to millions of potential buyers instantly.' },
    @{ file = 'rent-property.html'; title = 'Rent Property'; desc = 'Discover premium rental homes that fit your lifestyle.' },
    @{ file = 'post-property-free.html'; title = 'Post Property Free'; desc = 'Zero cost. Maximum reach. Post your property today.' },
    @{ file = 'pg-coliving.html'; title = 'PG / Co-living'; desc = 'Modern shared spaces for students and professionals.' },
    @{ file = 'plot-land.html'; title = 'Plot / Land'; desc = 'Invest in premium land plots across emerging corridors.' },
    @{ file = 'home-loans.html'; title = 'Home Loans'; desc = 'Compare and apply for home loans with the best interest rates.' },
    @{ file = 'emi-calculator.html'; title = 'EMI Calculator'; desc = 'Calculate your monthly mortgage payments instantly.' },
    @{ file = 'property-valuation.html'; title = 'Property Valuation'; desc = 'Get accurate AI-driven valuation for any property.' },
    @{ file = 'price-trends.html'; title = 'Price Trends'; desc = 'Analyze historical and future property price movements.' },
    @{ file = 'rent-receipt-generator.html'; title = 'Rent Receipt Generator'; desc = 'Generate valid rent receipts for your tax declarations.' },
    @{ file = 'rent-agreement.html'; title = 'Rent Agreement'; desc = 'Create legally binding digital rent agreements in minutes.' },
    @{ file = 'stamp-duty-calculator.html'; title = 'Stamp Duty Calculator'; desc = 'Estimate registration charges and stamp duty accurately.' },
    @{ file = 'tenant-verification.html'; title = 'Tenant Verification'; desc = 'Comprehensive background checks for complete peace of mind.' },
    @{ file = 'news-articles.html'; title = 'News & Articles'; desc = 'Latest updates and expert opinions from the real estate world.' },
    @{ file = 'research-reports.html'; title = 'Research Reports'; desc = 'In-depth market analysis and sector forecasts.' },
    @{ file = 'locality-reviews.html'; title = 'Locality Reviews'; desc = 'Real reviews from residents to help you choose the right neighborhood.' },
    @{ file = 'property-guide.html'; title = 'Property Guide'; desc = 'Everything you need to know about buying, selling, and renting.' },
    @{ file = 'legal-guide.html'; title = 'Legal Guide'; desc = 'Navigate complex real estate laws with our comprehensive guides.' },
    @{ file = 'interior-design.html'; title = 'Interior Design'; desc = 'Transform your house into a home with our design partners.' },
    @{ file = 'packers-movers.html'; title = 'Packers & Movers'; desc = 'Trusted relocation services for a seamless moving experience.' },
    @{ file = 'property-management.html'; title = 'Property Management'; desc = 'End-to-end management for your rental portfolio.' },
    @{ file = 'nri-corner.html'; title = 'NRI Corner'; desc = 'Specialized services for Non-Resident Indian investors.' },
    @{ file = 'login.html'; title = 'Login / Register'; desc = 'Access your saved properties and personalized recommendations.' },
    @{ file = 'profile.html'; title = 'My Profile'; desc = 'Manage your personal details and preferences.' },
    @{ file = 'my-listings.html'; title = 'My Listings'; desc = 'Track and manage properties you have listed on PropIndex.' },
    @{ file = 'mb-prime.html'; title = 'MB Prime'; desc = 'Upgrade to our premium membership for exclusive benefits.' },
    @{ file = 'contact.html'; title = 'Contact Us'; desc = 'Get in touch with our support and advisory teams.' },
    @{ file = 'about.html'; title = 'About Us'; desc = 'Learn about our mission to humanize real estate.' },
    @{ file = 'advertise.html'; title = 'Advertise With Us'; desc = 'Showcase your brand to millions of property seekers.' }
)

foreach ($page in $pages) {
    $filePath = Join-Path -Path $PSScriptRoot -ChildPath $page.file
    
    $customHead = $headContent -replace '<!-- TITLE_PLACEHOLDER -->', "<title>$($page.title) | PropIndex</title>"
    
    $pageHTML = @"
<!DOCTYPE html>
<html lang="en">
$customHead
<body class="font-sans flex flex-col min-h-screen">

$navContent

    <!-- Hero Section -->
    <section class="relative pt-32 pb-20 px-6 bg-surface-200 border-b border-surface-300">
        <div class="max-w-7xl mx-auto text-center relative z-10">
            <h1 class="text-5xl md:text-6xl font-bold text-brand-dark mb-6 animate-slide-up tracking-tight">$($page.title)</h1>
            <p class="text-xl text-brand-secondary max-w-2xl mx-auto animate-fade-in [animation-delay:200ms]">$($page.desc)</p>
        </div>
        <!-- Decorative blur -->
        <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-brand-accent/5 rounded-full blur-3xl z-0"></div>
    </section>

    <!-- Main Content Area Placeholder -->
    <main class="flex-grow py-24 px-6">
        <div class="max-w-7xl mx-auto">
            <div class="p-16 border-2 border-dashed border-surface-300 rounded-[3rem] flex flex-col items-center justify-center text-center bg-white/50 backdrop-blur-sm">
                <div class="w-20 h-20 bg-surface-200 rounded-3xl flex items-center justify-center text-brand-secondary mb-6 shadow-sm">
                    <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 002-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"/></svg>
                </div>
                <h3 class="text-2xl font-bold text-brand-dark mb-2">$($page.title) Module</h3>
                <p class="text-brand-secondary max-w-md">This section is currently under development. The humanized UI for this tool will be deployed in the next sprint.</p>
                <button class="mt-8 px-8 py-3 bg-brand-dark text-white rounded-pill font-bold hover:bg-brand-accent transition-all text-sm">Notify Me When Live</button>
            </div>
        </div>
    </main>

$footerContent

</body>
</html>
"@

    Set-Content -Path $filePath -Value $pageHTML -Encoding UTF8
    Write-Host "Generated: $($page.file)"
}

Write-Host "All missing pages generated successfully."
