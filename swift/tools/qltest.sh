#!/bin/bash

mkdir -p "$CODEQL_EXTRACTOR_SWIFT_TRAP_DIR"

exec "$CODEQL_EXTRACTOR_SWIFT_ROOT/tools/$CODEQL_PLATFORM/extractor"
