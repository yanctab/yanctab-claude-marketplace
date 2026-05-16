#!/usr/bin/env bash
# Tests for the Makefile submodules target
# Each test function returns 0 for pass, non-zero for fail.

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MAKEFILE="$REPO_ROOT/Makefile"

pass=0
fail=0

run_test() {
    local name="$1"
    local result="$2"
    if [ "$result" -eq 0 ]; then
        echo "PASS: $name"
        pass=$((pass + 1))
    else
        echo "FAIL: $name"
        fail=$((fail + 1))
    fi
}

# Criterion 1: --remote flag is absent from the git submodule update invocation
test_no_remote_flag() {
    if grep -q -- '--remote' "$MAKEFILE"; then
        return 1
    fi
    return 0
}

run_test "submodules target has no --remote flag" "$(test_no_remote_flag; echo $?)"

echo ""
echo "Results: $pass passed, $fail failed"
[ "$fail" -eq 0 ]
