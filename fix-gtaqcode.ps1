$root = "C:\Users\auftrrafi\Downloads\opencode-dev\opencode-dev"

function IsExcluded($path) {
    return ($path -match "\\node_modules\\" -or $path -match "\\.git\\" -or
            $path -match "\\dist\\" -or $path -match "\\build\\" -or
            $path -match "\\.turbo\\")
}

function ReplaceInFile($file, $old, $new, $caseSensitive) {
    try {
        $content = Get-Content $file -Raw -ErrorAction Stop
        if ($caseSensitive) {
            if ($content -match $old) {
                $newContent = $content -replace $old, $new
                if ($newContent -ne $content) {
                    Set-Content $file $newContent -NoNewline -Encoding UTF8
                    return $true
                }
            }
        } else {
            if ($content -imatch $old) {
                $newContent = $content -ireplace $old, $new
                if ($newContent -ne $content) {
                    Set-Content $file $newContent -NoNewline -Encoding UTF8
                    return $true
                }
            }
        }
    } catch {
        Write-Host "  ERROR: $file - $_"
    }
    return $false
}

# Fix package.json files
Write-Host "=== Fixing package.json files ==="
$pkgFiles = Get-ChildItem -Path $root -Recurse -Filter "package.json" |
    Where-Object { -not (IsExcluded $_.FullName) }

foreach ($file in $pkgFiles) {
    $changed = $false
    
    # Read raw content as text lines
    $lines = Get-Content $file.FullName
    $newLines = @()
    foreach ($line in $lines) {
        $original = $line
        
        # Fix name field: "name": "GTAQCODE" -> "name": "gtaqcode"
        if ($line -match '"name":\s*"GTAQCODE"') {
            $line = $line -replace '"GTAQCODE"', '"gtaqcode"'
        }
        
        # Fix bin field key: "GTAQCODE": -> "gtaqcode":
        if ($line -match '^\s*"GTAQCODE":\s*"\./bin/') {
            $line = $line -replace '"GTAQCODE"', '"gtaqcode"'
        }
        
        # Fix binary path: ./bin/GTAQCODE -> ./bin/gtaqcode
        if ($line -match '\./bin/GTAQCODE') {
            $line = $line -replace 'GTAQCODE', 'gtaqcode'
        }
        
        # Revert external packages that were over-replaced
        if ($line -match 'GTAQCODE-gitlab-auth') {
            $line = $line -replace 'GTAQCODE-gitlab-auth', 'opencode-gitlab-auth'
        }
        if ($line -match 'GTAQCODE-poe-auth') {
            $line = $line -replace 'GTAQCODE-poe-auth', 'opencode-poe-auth'
        }
        
        if ($line -ne $original) { $changed = $true }
        $newLines += $line
    }
    
    if ($changed) {
        $newLines | Set-Content $file.FullName -Encoding UTF8
        Write-Host "  Fixed: $($file.FullName)"
    }
}

Write-Host "=== Done ==="
