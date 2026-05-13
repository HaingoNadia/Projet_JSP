@echo off
setlocal
cd /d "%~dp0"

where mvn >nul 2>nul
if errorlevel 1 (
  echo Error: Maven (mvn) is not installed or not in PATH.
  echo Install Maven 3.8+ and Java 11, then retry.
  exit /b 1
)

echo Preparing Maven dependencies (go-offline^)...
call mvn -q -DskipTests dependency:go-offline
if errorlevel 1 exit /b 1

set "JAVA_TOOL_OPTIONS=%JAVA_TOOL_OPTIONS% -Djava.awt.headless=true"
echo Starting Jetty on http://127.0.0.1:9080/MonProjetJSP/
echo Leave this terminal open. Press Ctrl+C to stop.
call mvn jetty:run
exit /b %errorlevel%
