@echo off
setlocal
cd /d "%~dp0"

where mvn >nul 2>nul
if errorlevel 1 (
  echo Error: Maven (mvn) is not installed or not in PATH.
  echo Install Maven 3.8+ and Java 11, then retry.
  exit /b 1
)

echo Downloading Maven dependencies...
call mvn -q -DskipTests dependency:go-offline
if errorlevel 1 exit /b 1

echo Compiling project...
call mvn -q -DskipTests clean compile
if errorlevel 1 exit /b 1

echo Project is ready.
exit /b 0
