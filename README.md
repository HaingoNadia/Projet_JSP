# MonProjetJSP - Quick Start (Linux & Windows)

This project is ready to run with simple scripts on both Linux and Windows.

## Prerequisites

- Java 11+ (Java 17 works)
- Maven 3.8+
- MySQL Server + MySQL client (`mysql` command)

---

## 1) Clone

```bash
git clone <YOUR_REPO_URL>
cd Projet_JSP
```

---

## 2) Prepare dependencies/packages

### Linux

```bash
chmod +x prepare-project.sh start-server.sh setup-database.sh
./prepare-project.sh
```

### Windows (CMD)

```bat
prepare-project.bat
```

### Windows (PowerShell)

```powershell
.\prepare-project.ps1
```

This downloads dependencies and compiles the project.

---

## 3) Setup database

The SQL creates:
- database: `taptapsend`
- user: `taptapsend`
- password: `taptapsend`
- tables + demo data

### Linux

```bash
./setup-database.sh
```

### Windows (CMD)

```bat
setup-database.bat
```

### Windows (PowerShell)

```powershell
.\setup-database.ps1
```

### Windows WAMP/XAMPP note

- The Windows setup scripts now auto-detect `mysql.exe` in common WAMP/XAMPP locations.
- If your version path is different, set it manually:

CMD:
```bat
set MYSQL_CMD=C:\wamp64\bin\mysql\mysql8.0.xx\bin\mysql.exe
setup-database.bat
```

PowerShell:
```powershell
$env:MYSQL_CMD="C:\wamp64\bin\mysql\mysql8.0.xx\bin\mysql.exe"
.\setup-database.ps1
```

If you want non-interactive root auth, set root password in env var first:

### Linux

```bash
export MYSQL_ROOT_PASSWORD=your_root_password
```

### Windows CMD

```bat
set MYSQL_ROOT_PASSWORD=your_root_password
```

### Windows PowerShell

```powershell
$env:MYSQL_ROOT_PASSWORD="your_root_password"
```

---

## 4) Start server

### Linux

```bash
./start-server.sh
```

### Windows (CMD)

```bat
start-server.bat
```

### Windows (PowerShell)

```powershell
.\start-server.ps1
```

App URL:

- [http://127.0.0.1:9080/MonProjetJSP/](http://127.0.0.1:9080/MonProjetJSP/)

---

## Useful notes

- The start scripts enable `-Djava.awt.headless=true` for PDF compatibility.
- If MySQL is not in PATH, install MySQL client or add it to PATH.
- If Maven is not in PATH, install Maven and reopen terminal.

---

## Fast path (recommended)

### Linux

```bash
./prepare-project.sh && ./setup-database.sh && ./start-server.sh
```

### Windows CMD

```bat
prepare-project.bat && setup-database.bat && start-server.bat
```

### Windows PowerShell

```powershell
.\prepare-project.ps1; if ($?) { .\setup-database.ps1 }; if ($?) { .\start-server.ps1 }
```
