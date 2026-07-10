$root = "C:\Users\auftrrafi\Downloads\opencode-dev\opencode-dev"
$logFile = Join-Path $root "fork-gtaqcode.log"
$msg = "Fork GTAQCODE - $(Get-Date)"
$msg | Out-File $logFile
Write-Host $msg

$excludeDirs = @(
    "\\node_modules\\", "\\.git\\", "\\dist\\", "\\build\\", "\\.turbo\\",
    "\\out\\", "\\storybook-static\\", "\\coverage\\", "\\.sst\\"
)

function Should-Exclude($path) {
    foreach ($p in $excludeDirs) { if ($path -match $p) { return $true } }
    return $false
}

function LogMsg($m) {
    $m | Out-File $logFile -Append
    Write-Host $m
}

# Gather all text files
$files = Get-ChildItem -Path $root -Recurse -File | Where-Object {
    -not (Should-Exclude $_.FullName)
} | Where-Object {
    $_.Extension -match '\.(ts|tsx|js|cjs|mjs|jsx|json|md|nix|yaml|yml|toml|txt|css|scss|html|hbs|svg|desktop|conf|cfg|env|editorconfig|gitignore|gitattributes|prettierrc|eslintrc|properties|plist|entitlements|code-workspace)$'
}

LogMsg "=== Found $($files.Count) files ==="

# --- PHASE 1: @gtaqcode/ -> @gtaqcode/ ---
LogMsg "`n=== PHASE 1: @gtaqcode/ -> @gtaqcode/ ==="
$count1 = 0
foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
        if ($content -match '@gtaqcode/') {
            $newContent = $content -replace '@gtaqcode/', '@gtaqcode/'
            if ($newContent -ne $content) {
                Set-Content $file.FullName $newContent -NoNewline -Encoding UTF8
                $count1++
            }
        }
    } catch {
        LogMsg "  SKIP: $($file.FullName)"
    }
}
LogMsg "  Phase 1: $count1 files"

# --- PHASE 2: OpenCode -> GTAQCODE ---
LogMsg "`n=== PHASE 2: OpenCode -> GTAQCODE ==="
$count2 = 0
foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
        if ($content -match 'OpenCode') {
            $newContent = $content -replace 'OpenCode', 'GTAQCODE'
            if ($newContent -ne $content) {
                Set-Content $file.FullName $newContent -NoNewline -Encoding UTF8
                $count2++
            }
        }
    } catch {
        # skip
    }
}
LogMsg "  Phase 2: $count2 files"

# --- PHASE 3: .opencode/ -> .gtaqcode/ ---
LogMsg "`n=== PHASE 3: .opencode/ -> .gtaqcode/ ==="
$count3 = 0
foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
        if ($content -match '\.opencode/') {
            $newContent = $content -replace '\.opencode/', '.gtaqcode/'
            if ($newContent -ne $content) {
                Set-Content $file.FullName $newContent -NoNewline -Encoding UTF8
                $count3++
            }
        }
    } catch { }
}
LogMsg "  Phase 3: $count3 files"

# --- PHASE 4: opencode-desktop -> gtaqcode-desktop ---
LogMsg "`n=== PHASE 4: opencode-desktop -> gtaqcode-desktop ==="
$count4 = 0
foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
        if ($content -match 'opencode-desktop') {
            $newContent = $content -replace 'opencode-desktop', 'gtaqcode-desktop'
            if ($newContent -ne $content) {
                Set-Content $file.FullName $newContent -NoNewline -Encoding UTF8
                $count4++
            }
        }
    } catch { }
}
LogMsg "  Phase 4: $count4 files"

# --- PHASE 5: opencode:// -> gtaqcode:// ---
LogMsg "`n=== PHASE 5: opencode:// -> gtaqcode:// ==="
$count5 = 0
foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
        if ($content -match 'opencode://') {
            $newContent = $content -replace 'opencode://', 'gtaqcode://'
            if ($newContent -ne $content) {
                Set-Content $file.FullName $newContent -NoNewline -Encoding UTF8
                $count5++
            }
        }
    } catch { }
}
LogMsg "  Phase 5: $count5 files"

# --- PHASE 6: ai.opencode.desktop -> com.gtaqcode.desktop ---
LogMsg "`n=== PHASE 6: ai.opencode.desktop -> com.gtaqcode.desktop ==="
$count6 = 0
foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
        if ($content -match 'ai\.opencode\.desktop') {
            $newContent = $content -replace 'ai\.opencode\.desktop', 'com.gtaqcode.desktop'
            if ($newContent -ne $content) {
                Set-Content $file.FullName $newContent -NoNewline -Encoding UTF8
                $count6++
            }
        }
    } catch { }
}
LogMsg "  Phase 6: $count6 files"

# --- PHASE 7: package.json bin/name fields ---
LogMsg "`n=== PHASE 7: package.json name/bin ==="
$count7 = 0
$pkgFiles = Get-ChildItem -Path $root -Recurse -Filter "package.json" | Where-Object { -not (Should-Exclude $_.FullName) }
foreach ($file in $pkgFiles) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
        $changed = $false
        if ($content -match '"name":\s*"opencode"') {
            $content = $content -replace '"name":\s*"opencode"', '"name": "gtaqcode"'
            $changed = $true
            LogMsg "  name field: $($file.FullName)"
        }
        if ($content -match '"bin":\s*\{\s*"opencode"') {
            $content = $content -replace '"bin":\s*\{\s*"opencode"', '"bin": { "gtaqcode"'
            $changed = $true
            LogMsg "  bin field: $($file.FullName)"
        }
        if ($changed) {
            Set-Content $file.FullName $content -NoNewline -Encoding UTF8
            $count7++
        }
    } catch {
        LogMsg "  ERROR: $($file.FullName)"
    }
}
LogMsg "  Phase 7: $count7 files"

# --- PHASE 8: Binary stub files ---
LogMsg "`n=== PHASE 8: Binary stubs ==="

$stubFile = Join-Path $root "packages/opencode/bin/opencode"
if (Test-Path $stubFile) {
    $content = Get-Content $stubFile -Raw
    $orig = $content
    $content = $content -replace 'OPENCODE_BIN_PATH', 'GTAQCODE_BIN_PATH'
    $content = $content -replace '"opencode-"', '"gtaqcode-"'
    $content = $content -replace '"opencode\.exe"', '"gtaqcode.exe"'
    $content = $content -replace '"opencode"', '"gtaqcode"'
    if ($content -ne $orig) {
        Set-Content $stubFile $content -NoNewline -Encoding UTF8
        LogMsg "  Updated: packages/opencode/bin/opencode"
    }
}

$lildaxFile = Join-Path $root "packages/cli/bin/lildax.cjs"
if (Test-Path $lildaxFile) {
    $content = Get-Content $lildaxFile -Raw
    $orig = $content
    $content = $content -replace 'OPENCODE_BIN_PATH', 'GTAQCODE_BIN_PATH'
    if ($content -ne $orig) {
        Set-Content $lildaxFile $content -NoNewline -Encoding UTF8
        LogMsg "  Updated: packages/cli/bin/lildax.cjs"
    }
}

# --- PHASE 9: opencode-ai npm package ---
LogMsg "`n=== PHASE 9: opencode-ai npm package ==="
$count9 = 0
foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
        if ($content -match '(?<![@\-.])opencode-ai(?![\/\w])') {
            $newContent = $content -replace '(?<![@\-.])opencode-ai(?![\/\w])', 'gtaqcode'
            if ($newContent -ne $content) {
                Set-Content $file.FullName $newContent -NoNewline -Encoding UTF8
                $count9++
            }
        }
    } catch { }
}
LogMsg "  Phase 9: $count9 files"

# --- PHASE 10: Rename .opencode/ directory ---
LogMsg "`n=== PHASE 10: Rename .opencode/ -> .gtaqcode/ ==="
$oldDir = Join-Path $root ".opencode"
$newDir = Join-Path $root ".gtaqcode"
if (Test-Path $oldDir) {
    Rename-Item -Path $oldDir -NewName ".gtaqcode" -Force
    LogMsg "  Renamed: .opencode/ -> .gtaqcode/"
} else {
    LogMsg "  .opencode/ not found"
}

LogMsg "`n=== DONE $(Get-Date) ==="
LogMsg "Summary: Phase 1=$count1 Phase 2=$count2 Phase 3=$count3 Phase 4=$count4 Phase 5=$count5 Phase 6=$count6 Phase 7=$count7 Phase 9=$count9"
