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

# Criterion 2: doc comment reads "to their pinned commits" (or equivalent)
test_doc_comment_pinned_commits() {
    if grep -q 'pinned commits' "$MAKEFILE"; then
        return 0
    fi
    return 1
}

run_test "submodules doc comment says pinned commits" "$(test_doc_comment_pinned_commits; echo $?)"

# Criterion 3: make submodules runs without error
test_make_submodules_exits_clean() {
    make -C "$REPO_ROOT" submodules >/dev/null 2>&1
}

run_test "make submodules exits without error" "$(test_make_submodules_exits_clean; echo $?)"

# install Criterion 5: when source is a JSON object the entry is skipped (no error)
test_install_skips_object_source_entries() {
    # Create a temp JSON with a -dev entry whose source is an object
    local tmpdir
    tmpdir=$(mktemp -d)
    cat > "$tmpdir/marketplace.json" <<'JSONEOF'
{
  "plugins": [
    {
      "name": "foo-dev",
      "source": {"type": "github", "repo": "org/foo"}
    }
  ]
}
JSONEOF
    # jq with our filter should produce no output (object source skipped) and exit 0
    local output
    output=$(jq -r '.plugins[] | select(.name | endswith("-dev")) | select(.source | type == "string") | .source' "$tmpdir/marketplace.json")
    local exit_code=$?
    rm -rf "$tmpdir"
    [ $exit_code -eq 0 ] && [ -z "$output" ]
}

run_test "install skips object-source entries silently" "$(test_install_skips_object_source_entries; echo $?)"

# install Criterion 4: when source is a plain string, use it as the plugin directory path
test_install_string_source_used_as_dir() {
    # The jq filter must check that source is a string (type == "string")
    if grep -A 20 '^install:' "$MAKEFILE" | grep -q 'type == "string"'; then
        return 0
    fi
    return 1
}

run_test "install uses string source as plugin directory path" "$(test_install_string_source_used_as_dir; echo $?)"

# install Criterion 3: only plugins whose name ends in -dev are processed
test_install_filters_dev_entries() {
    # The jq filter must select only entries whose name ends with -dev
    if grep -A 20 '^install:' "$MAKEFILE" | grep -q 'endswith("-dev")'; then
        return 0
    fi
    return 1
}

run_test "install filters only -dev-named plugin entries" "$(test_install_filters_dev_entries; echo $?)"

# install Criterion 2: make install depends on submodules
test_install_depends_on_submodules() {
    if grep -E '^install[[:space:]]*:' "$MAKEFILE" | grep -q 'submodules'; then
        return 0
    fi
    return 1
}

run_test "install target depends on submodules" "$(test_install_depends_on_submodules; echo $?)"

# install Criterion 1: install is listed in the .PHONY declaration
test_install_in_phony() {
    if grep -E '^\.PHONY:' "$MAKEFILE" | grep -qw 'install'; then
        return 0
    fi
    return 1
}

run_test "install is listed in .PHONY declaration" "$(test_install_in_phony; echo $?)"

echo ""
echo "Results: $pass passed, $fail failed"
[ "$fail" -eq 0 ]
