$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Maven (mvn) is not installed or not in PATH." -ForegroundColor Red
    Write-Host "Install Maven 3.8+ and Java 11, then retry."
    exit 1
}

Write-Host "Downloading Maven dependencies..."
mvn -q -DskipTests dependency:go-offline

Write-Host "Compiling project..."
mvn -q -DskipTests clean compile

Write-Host "Project is ready."
