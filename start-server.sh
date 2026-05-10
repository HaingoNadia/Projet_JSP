#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
# PDF (OpenPDF) : évite libawt_xawt si JDK headless ; sinon installer openjdk-11-jdk (complet)
export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:+$JAVA_TOOL_OPTIONS }-Djava.awt.headless=true"
echo "Starting Jetty on http://127.0.0.1:9080/MonProjetJSP/"
echo "Leave this terminal open. Press Ctrl+C to stop."
exec mvn jetty:run
