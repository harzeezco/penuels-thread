# PowerShell script to replace all og:image content with peanul.jpg

# Define the search pattern for og:image meta tags
$ogImagePattern = 'property="og:image"\s+content="[^"]*"'
$replacement = 'property="og:image" content="https://penuelsthread.shop/peanul.jpg"'

# Also handle og:secure_url tags that reference the same images
$ogSecureUrlPattern = 'property="og:secure_url"\s+content="[^"]*"'
$secureUrlReplacement = 'property="og:secure_url" content="https://penuelsthread.shop/peanul.jpg"'

# Get all HTML files in the directory and subdirectories
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

Write-Host "Found $($htmlFiles.Count) HTML files to process..."

$fileCount = 0
$updatedCount = 0

foreach ($file in $htmlFiles) {
    $fileCount++
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Replace og:image content
    $content = $content -replace $ogImagePattern, $replacement
    
    # Replace og:secure_url content
    $content = $content -replace $ogSecureUrlPattern, $secureUrlReplacement
    
    # Check if content was changed
    if ($content -ne $originalContent) {
        try {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            $updatedCount++
            Write-Host "Updated: $($file.FullName)"
        }
        catch {
            Write-Warning "Failed to update: $($file.FullName) - $($_.Exception.Message)"
        }
    }
    
    # Progress indicator
    if ($fileCount % 50 -eq 0) {
        Write-Host "Processed $fileCount files..."
    }
}

Write-Host ""
Write-Host "Script completed!"
Write-Host "Total files processed: $fileCount"
Write-Host "Files updated: $updatedCount"
Write-Host "Files unchanged: $($fileCount - $updatedCount)"
