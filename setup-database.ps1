$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$sql = "src/main/resources/setup-mysql-dev.sql"
if (-not (Test-Path $sql)) {
    Write-Host "Error: SQL file not found: $sql" -ForegroundColor Red
    exit 1
}

$mysqlCmd = $null
if ($env:MYSQL_CMD -and (Test-Path $env:MYSQL_CMD)) {
    $mysqlCmd = $env:MYSQL_CMD
}
if (-not $mysqlCmd) {
    $mysqlCmd = (Get-Command mysql -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue)
}
if (-not $mysqlCmd) {
    $candidates = @(
        "C:\wamp64\bin\mysql\mysql8.0.31\bin\mysql.exe",
        "C:\wamp64\bin\mysql\mysql8.0.34\bin\mysql.exe",
        "C:\wamp64\bin\mysql\mysql8.0.21\bin\mysql.exe",
        "C:\wamp64\bin\mysql\mysql8.1.0\bin\mysql.exe",
        "C:\wamp64\bin\mysql\mysql8.2.0\bin\mysql.exe",
        "C:\xampp\mysql\bin\mysql.exe"
    )
    $mysqlCmd = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
}
if (-not $mysqlCmd) {
    Write-Host "Error: mysql client not found in PATH, WAMP, or XAMPP." -ForegroundColor Red
    Write-Host "Set a custom path and rerun, e.g.:"
    Write-Host "  `$env:MYSQL_CMD='C:\wamp64\bin\mysql\mysql8.0.31\bin\mysql.exe'"
    exit 1
}
Write-Host "Using mysql client: $mysqlCmd"

Write-Host "Creating database/user/table demo data (taptapsend)..."

if ($env:MYSQL_ROOT_PASSWORD) {
    cmd /c "`"$mysqlCmd`" -u root -p$env:MYSQL_ROOT_PASSWORD < `"$sql`""
} else {
    Write-Host "MYSQL_ROOT_PASSWORD not set."
    Write-Host "You will be prompted for the MySQL root password."
    cmd /c "`"$mysqlCmd`" -u root -p < `"$sql`""
}

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "Failed to apply SQL." -ForegroundColor Red
    Write-Host "Manual retry:"
    Write-Host "  `"$mysqlCmd`" -u root -p < ""$PWD\$sql"""
    exit 1
}

Write-Host ""
Write-Host "Success."
Write-Host "Test:"
Write-Host "  `"$mysqlCmd`" -u taptapsend -ptaptapsend -e ""USE taptapsend; SELECT mail FROM client;"""
