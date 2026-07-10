$root = "C:\Users\auftrrafi\Downloads\opencode-dev\opencode-dev"

function IsExcluded($path) {
    return ($path -match "\\node_modules\\" -or $path -match "\\.git\\" -or
            $path -match "\\dist\\" -or $path -match "\\build\\" -or
            $path -match "\\.turbo\\")
}

# Collect all source files
$files = Get-ChildItem -Path $root -Recurse -File |
    Where-Object { -not (IsExcluded $_.FullName) } |
    Where-Object { $_.Extension -match '\.(ts|tsx|js|cjs|mjs|jsx|json|md|nix|yaml|yml|toml|txt|css|scss|html|hbs|svg|desktop|conf|cfg|env|editorconfig|gitignore|gitattributes|prettierrc|eslintrc|properties|plist|entitlements|code-workspace)$' }

Write-Host "=== Finding && Fixing env vars ==="

$envFixCount = 0
foreach ($file in $files) {
    try {
        $lines = Get-Content $file.FullName
        $changed = $false
        $newLines = @()
        foreach ($line in $lines) {
            $original = $line
            
            # GTAQCODE_API_KEY -> OPENCODE_API_KEY
            if ($line -match 'GTAQCODE_API_KEY') {
                $line = $line -replace 'GTAQCODE_API_KEY', 'OPENCODE_API_KEY'
            }
            
            # GTAQCODE_CHANNEL -> OPENCODE_CHANNEL
            if ($line -match 'GTAQCODE_CHANNEL') {
                $line = $line -replace 'GTAQCODE_CHANNEL', 'OPENCODE_CHANNEL'
            }
            
            if ($line -ne $original) { $changed = $true }
            $newLines += $line
        }
        if ($changed) {
            $newLines | Set-Content $file.FullName -Encoding UTF8
            $envFixCount++
            Write-Host "  $envFixCount. $($file.FullName)"
        }
    } catch {
        # skip binary files
    }
}
Write-Host "Fixed $envFixCount files for env vars"

# Fix specific issues in binary stub
Write-Host "`n=== Fixing binary stub ==="
$stub = Join-Path $root "packages/opencode/bin/opencode"
if (Test-Path $stub) {
    $lines = Get-Content $stub
    $newLines = @()
    $changed = $false
    foreach ($line in $lines) {
        $orig = $line
        
        # Fix .opencode" -> .gtaqcode"
        if ($line -match '\.opencode"') {
            $line = $line -replace '\.opencode"', '.gtaqcode"'
        }
        
        # Fix env var: GTAQCODE_BIN_PATH -> OPENCODE_BIN_PATH (revert)
        if ($line -match 'GTAQCODE_BIN_PATH') {
            $line = $line -replace 'GTAQCODE_BIN_PATH', 'OPENCODE_BIN_PATH'
        }
        
        # Fix error message: GTAQCODE CLI -> opencode CLI
        # Actually for the error message, we should say gtaqcode CLI since the binary is gtaqcode
        # But the user said keep OPENCODE_ env vars... hmm
        # The error message "opencode CLI" should become "gtaqcode CLI" for the fork
        if ($line -match 'GTAQCODE CLI') {
            $line = $line -replace 'GTAQCODE CLI', 'gtaqcode CLI'
        }
        
        if ($line -ne $orig) {
            $changed = $true
            Write-Host "  Fixed: $($line.Trim())"
        }
        $newLines += $line
    }
    if ($changed) {
        $newLines | Set-Content $stub -Encoding UTF8
        Write-Host "  Binary stub updated"
    }
}

# Fix lildax.cjs
$lildax = Join-Path $root "packages/cli/bin/lildax.cjs"
if (Test-Path $lildax) {
    $lines = Get-Content $lildax
    $newLines = @()
    $changed = $false
    foreach ($line in $lines) {
        $orig = $line
        if ($line -match 'GTAQCODE_BIN_PATH') {
            $line = $line -replace 'GTAQCODE_BIN_PATH', 'OPENCODE_BIN_PATH'
        }
        if ($line -ne $orig) { $changed = $true }
        $newLines += $line
    }
    if ($changed) {
        $newLines | Set-Content $lildax -Encoding UTF8
        Write-Host "  lildax.cjs updated"
    }
}

Write-Host "`n=== Checking for any remaining env var issues ==="
$remaining = Select-String -Path $root -Pattern "GTAQCODE_API_KEY|GTAQCODE_CHANNEL" -Recurse |
    Where-Object { $_.Path -notmatch "node_modules|\\\\.git|\\\\fork|\\\\fix-" } |
    Select-Object -First 20
if ($remaining) {
    Write-Host "Remaining GTAQCODE_ API/Channel env vars:"
    $remaining | ForEach-Object { Write-Host "  $($_.Path):$($_.LineNumber) - $($_.Line.Trim())" }
} else {
    Write-Host "  None found - all reverted!"
}

Write-Host "`n=== Done ==="
