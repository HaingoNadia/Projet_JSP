$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Maven (mvn) is not installed or not in PATH." -ForegroundColor Red
    Write-Host "Install Maven 3.8+ and Java 11, then retry."
    exit 1
}

Write-Host "Preparing Maven dependencies (go-offline)..."
mvn -q -DskipTests dependency:go-offline

if ($env:JAVA_TOOL_OPTIONS) {
    $env:JAVA_TOOL_OPTIONS = "$($env:JAVA_TOOL_OPTIONS) -Djava.awt.headless=true"
} else {
    $env:JAVA_TOOL_OPTIONS = "-Djava.awt.headless=true"
}

Write-Host "Starting Jetty on http://127.0.0.1:9080/MonProjetJSP/"
Write-Host "Leave this terminal open. Press Ctrl+C to stop."
mvn jetty:run
