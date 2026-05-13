#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v mvn >/dev/null 2>&1; then
  echo "Error: Maven (mvn) is not installed or not in PATH."
  echo "Install Maven 3.8+ and Java 11, then retry."
  exit 1
fi

echo "Preparing Maven dependencies (go-offline)..."
mvn -q -DskipTests dependency:go-offline

# PDF (OpenPDF) : évite libawt_xawt si JDK headless ; sinon installer openjdk-11-jdk (complet)
export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:+$JAVA_TOOL_OPTIONS }-Djava.awt.headless=true"
echo "Starting Jetty on http://127.0.0.1:9080/MonProjetJSP/"
echo "Leave this terminal open. Press Ctrl+C to stop."
exec mvn jetty:run
