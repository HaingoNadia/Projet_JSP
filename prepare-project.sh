#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v mvn >/dev/null 2>&1; then
  echo "Error: Maven (mvn) is not installed or not in PATH."
  echo "Install Maven 3.8+ and Java 11, then retry."
  exit 1
fi

echo "Downloading Maven dependencies..."
mvn -q -DskipTests dependency:go-offline
echo "Compiling project..."
mvn -q -DskipTests clean compile
echo "Project is ready."
