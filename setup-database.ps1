$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$sql = "src/main/resources/setup-mysql-dev.sql"
if (-not (Test-Path $sql)) {
    Write-Host "Error: SQL file not found: $sql" -ForegroundColor Red
    exit 1
}

if (-not (Get-Command mysql -ErrorAction SilentlyContinue)) {
    Write-Host "Error: mysql client is not installed or not in PATH." -ForegroundColor Red
    Write-Host "Install MySQL client, then retry."
    exit 1
}

Write-Host "Creating database/user/table demo data (taptapsend)..."

if ($env:MYSQL_ROOT_PASSWORD) {
    cmd /c "mysql -u root -p$env:MYSQL_ROOT_PASSWORD < `"$sql`""
} else {
    Write-Host "MYSQL_ROOT_PASSWORD not set."
    Write-Host "You will be prompted for the MySQL root password."
    cmd /c "mysql -u root -p < `"$sql`""
}

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "Failed to apply SQL." -ForegroundColor Red
    Write-Host "Manual retry:"
    Write-Host "  mysql -u root -p < ""$PWD\$sql"""
    exit 1
}

Write-Host ""
Write-Host "Success."
Write-Host "Test:"
Write-Host "  mysql -u taptapsend -ptaptapsend -e ""USE taptapsend; SELECT mail FROM client;"""
