@echo off
setlocal
cd /d "%~dp0"

set "SQL=src\main\resources\setup-mysql-dev.sql"
if not exist "%SQL%" (
  echo Error: SQL file not found: %SQL%
  exit /b 1
)

set "MYSQL_CMD=mysql"
where mysql >nul 2>nul
if errorlevel 1 (
  if exist "C:\wamp64\bin\mysql\mysql8.0.31\bin\mysql.exe" set "MYSQL_CMD=C:\wamp64\bin\mysql\mysql8.0.31\bin\mysql.exe"
  if exist "C:\wamp64\bin\mysql\mysql8.0.34\bin\mysql.exe" set "MYSQL_CMD=C:\wamp64\bin\mysql\mysql8.0.34\bin\mysql.exe"
  if exist "C:\wamp64\bin\mysql\mysql8.1.0\bin\mysql.exe" set "MYSQL_CMD=C:\wamp64\bin\mysql\mysql8.1.0\bin\mysql.exe"
  if exist "C:\wamp64\bin\mysql\mysql8.2.0\bin\mysql.exe" set "MYSQL_CMD=C:\wamp64\bin\mysql\mysql8.2.0\bin\mysql.exe"
  if exist "C:\xampp\mysql\bin\mysql.exe" set "MYSQL_CMD=C:\xampp\mysql\bin\mysql.exe"
)

if "%MYSQL_CMD%"=="mysql" (
  where mysql >nul 2>nul
  if errorlevel 1 (
    echo Error: mysql client not found in PATH, WAMP, or XAMPP.
    echo Set MYSQL_CMD manually and retry. Example:
    echo   set MYSQL_CMD=C:\wamp64\bin\mysql\mysql8.0.31\bin\mysql.exe
    exit /b 1
  )
)

echo Using mysql client: %MYSQL_CMD%

echo Creating database/user/table demo data (taptapsend^)...

if not "%MYSQL_ROOT_PASSWORD%"=="" (
  call "%MYSQL_CMD%" -u root -p%MYSQL_ROOT_PASSWORD% < "%SQL%"
) else (
  echo MYSQL_ROOT_PASSWORD not set.
  echo You will be prompted for the MySQL root password.
  call "%MYSQL_CMD%" -u root -p < "%SQL%"
)

if errorlevel 1 (
  echo.
  echo Failed to apply SQL.
  echo Manual retry:
  echo   "%MYSQL_CMD%" -u root -p ^< "%CD%\%SQL%"
  exit /b 1
)

echo.
echo Success.
echo Test:
echo   "%MYSQL_CMD%" -u taptapsend -ptaptapsend -e "USE taptapsend; SELECT mail FROM client;"
exit /b 0
