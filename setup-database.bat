@echo off
setlocal
cd /d "%~dp0"

set "SQL=src\main\resources\setup-mysql-dev.sql"
if not exist "%SQL%" (
  echo Error: SQL file not found: %SQL%
  exit /b 1
)

where mysql >nul 2>nul
if errorlevel 1 (
  echo Error: mysql client is not installed or not in PATH.
  echo Install MySQL client, then retry.
  exit /b 1
)

echo Creating database/user/table demo data (taptapsend^)...

if not "%MYSQL_ROOT_PASSWORD%"=="" (
  call mysql -u root -p%MYSQL_ROOT_PASSWORD% < "%SQL%"
) else (
  echo MYSQL_ROOT_PASSWORD not set.
  echo You will be prompted for the MySQL root password.
  call mysql -u root -p < "%SQL%"
)

if errorlevel 1 (
  echo.
  echo Failed to apply SQL.
  echo Manual retry:
  echo   mysql -u root -p ^< "%CD%\%SQL%"
  exit /b 1
)

echo.
echo Success.
echo Test:
echo   mysql -u taptapsend -ptaptapsend -e "USE taptapsend; SELECT mail FROM client;"
exit /b 0
