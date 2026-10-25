# shenzhou-themes — development tasks
emacs   := env_var_or_default("EMACS", "emacs")
lib     := "shenzhou-themes.el"
src     := "shenzhou-themes.el blackwall-theme.el blackwall-2077-theme.el"
themes  := "blackwall blackwall-2077"
elpa    := ".packages"
covfile := env_var_or_default("COVERAGE_FILE", "lcov.info")

# Elisp prelude: point package.el at the sandbox, add MELPA, initialize.
# Uses (quote ...) instead of ' so the whole form survives shell single-quoting.
setup := '(progn (setq package-user-dir (expand-file-name "' + elpa + '")) (require (quote package)) (add-to-list (quote package-archives) (quote ("melpa" . "https://melpa.org/packages/")) t) (package-initialize))'

# Make the themes loadable the way the autoload cookie does at runtime.
paths := '(progn (add-to-list (quote load-path) default-directory) (add-to-list (quote custom-theme-load-path) default-directory) (setq custom-safe-themes t))'

# List available recipes.
default:
    @just --list

# Install lint dependencies into the local sandbox.
# modus-themes is NOT installed: Emacs 30.1+ bundles a copy that
# `require-theme' finds, which is the fallback path the library uses anyway.
deps:
    {{emacs}} -Q --batch \
      --eval '{{setup}}' \
      --eval '(unless package-archive-contents (package-refresh-contents))' \
      --eval '(unless (package-installed-p (quote package-lint)) (package-install (quote package-lint)))'

# Byte-compile (prints warnings, does not fail on them).
compile:
    {{emacs}} -Q --batch -L . -f batch-byte-compile {{src}}

# Documentation style check.
checkdoc:
    #!/usr/bin/env sh
    set -e
    for f in {{src}}; do
      {{emacs}} -Q --batch --eval "(checkdoc-file \"$f\")"
    done

# Does loading each theme bork a clean Emacs?  Starts -Q, puts this directory
# on both paths, loads every theme in turn and fails on any error or warning.
# This is the regression guard for a palette entry the shared face list
# references but a theme forgets to define -- that is a void-variable at
# `load-theme' time, i.e. a broken startup.
# Depends on `clean': without it a stale .elc from `lint' is loaded in
# preference to the source, and the smoke test silently passes on old bytecode.
smoke: clean
    #!/usr/bin/env sh
    set -e
    for t in {{themes}}; do
      echo "--- load-theme $t"
      {{emacs}} -Q --batch \
        --eval '(setq load-prefer-newer t)' \
        --eval '{{paths}}' \
        --eval "(progn (load-theme (quote $t) t) \
                       (unless (memq (quote $t) custom-enabled-themes) \
                         (error \"$t did not enable\")) \
                       (message \"    ok\"))"
    done
    echo "--- all themes load in a clean Emacs"

# Full lint: checkdoc, package-lint on the library, then byte-compile with
# warnings as errors.
lint: clean deps checkdoc
    {{emacs}} -Q --batch \
      --eval '{{setup}}' \
      -l package-lint -f package-lint-batch-and-exit {{lib}}
    {{emacs}} -Q --batch -L . \
      --eval '(setq byte-compile-error-on-warn t)' \
      -f batch-byte-compile {{src}}

# Run the ERT test suite.  Needs no sandbox: the bundled modus-themes is enough.
# load-prefer-newer avoids loading a stale .elc over freshly edited source.
test: clean
    {{emacs}} -Q --batch \
      --eval '{{paths}}' \
      --eval '(setq load-prefer-newer t)' \
      -L . -l ert -l test/shenzhou-themes-test.el \
      -f ert-run-tests-batch-and-exit

# Line-coverage report via undercover. FORMAT: text (default) | lcov | simplecov
# | codecov | coveralls. text prints %% to the console; the file formats write to
# `covfile' (default lcov.info, override with COVERAGE_FILE=... or just covfile=PATH).
coverage format="text": clean deps
    UNDERCOVER_FORCE=true {{emacs}} -Q --batch \
      --eval '{{setup}}' \
      --eval '(unless (package-installed-p (quote undercover)) (package-refresh-contents) (package-install (quote undercover)))' \
      --eval '(require (quote undercover))' \
      --eval '{{paths}}' \
      --eval '(undercover "{{lib}}" (:report-format (quote {{format}})) (:send-report nil){{ if format == "text" { "" } else { ' (:report-file "' + covfile + '")' } }})' \
      -L . -l ert -l test/shenzhou-themes-test.el \
      -f ert-run-tests-batch-and-exit

# Everything CI should run.
ci: lint smoke test

# Regenerate CHANGELOG.md from the conventional commit history.
changelog:
    git-cliff --bump --output CHANGELOG.md

# Remove build artifacts (keeps the dependency sandbox).
clean:
    rm -f *.elc test/*.elc
    rm -f {{covfile}}

# Remove build artifacts and the dependency sandbox.
clean-all: clean
    rm -rf {{elpa}}
