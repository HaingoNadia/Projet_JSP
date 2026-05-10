#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
SQL="src/main/resources/setup-mysql-dev.sql"
ABS_SQL="$(pwd)/$SQL"

echo "Creates database taptapsend, MySQL user taptapsend (password: taptapsend), tables, and demo rows."
echo ""

apply_sql() {
  local label="$1"
  shift
  echo "Trying: $label ..."
  if "$@" < "$ABS_SQL"; then
    echo "Success ($label)."
    return 0
  fi
  return 1
}

# 1) Ubuntu/Debian: maintenance user (often works when plain "sudo mysql" fails with password NO)
if sudo test -r /etc/mysql/debian.cnf && apply_sql "sudo mysql --defaults-file=/etc/mysql/debian.cnf" sudo mysql --defaults-file=/etc/mysql/debian.cnf; then
  :
# 2) Typical install: socket auth as OS root
elif apply_sql "sudo mysql" sudo mysql; then
  :
# 3) MariaDB client name
elif command -v mariadb >/dev/null 2>&1 && apply_sql "sudo mariadb" sudo mariadb; then
  :
# 4) MySQL root password (export MYSQL_ROOT_PASSWORD before running)
elif [[ -n "${MYSQL_ROOT_PASSWORD:-}" ]] && apply_sql "mysql -u root (MYSQL_ROOT_PASSWORD)" mysql -u root -p"${MYSQL_ROOT_PASSWORD}"; then
  :
else
  echo ""
  echo "None of the automatic methods worked. Run ONE of these manually (you will be prompted for a password if needed):"
  echo ""
  echo "  A) Maintenance user (Ubuntu / Debian, often works when 'sudo mysql' does not):"
  echo "     sudo mysql --defaults-file=/etc/mysql/debian.cnf < \"$ABS_SQL\""
  echo ""
  echo "  B) MySQL root password:"
  echo "     mysql -u root -p < \"$ABS_SQL\""
  echo ""
  echo "  C) Then re-run tests:"
  echo "     mysql -u taptapsend -ptaptapsend -e \"USE taptapsend; SELECT mail FROM client;\""
  echo ""
  exit 1
fi

echo ""
echo "Test: mysql -u taptapsend -ptaptapsend -e 'USE taptapsend; SELECT mail FROM client;'"
