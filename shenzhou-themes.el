;;; shenzhou-themes.el --- Dark themes for the shenzhou configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2026 neonmei

;; Author: neonmei <releng@neonmei.cloud>
;; Maintainer: neonmei <releng@neonmei.cloud>
;; URL: https://github.com/neonmei/shenzhou-emacs-themes
;; Version: 0.1.0
;; Package-Requires: ((emacs "30.1") (modus-themes "5.0.0"))
;; Keywords: faces, themes

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Themes for the shenzhou Emacs configuration, built on the Modus themes
;; infrastructure (modus-vivendi base) so every theme inherits its full face
;; coverage.  This file is the library: it holds the Blackwall ink set, the
;; shared custom faces for the packages Modus does not reach, and
;; `shenzhou-themes-deftheme'.
;;
;; The themes themselves live in blackwall-theme.el (`blackwall') and
;; blackwall-2077-theme.el (`blackwall-2077').

;;; Code:

(eval-and-compile
  (unless (require 'modus-themes nil :noerror)
    (require-theme 'modus-themes)))

(defgroup shenzhou-themes nil
  "Themes for the shenzhou Emacs configuration."
  :group 'faces)

;;;; Palette

(defconst shenzhou-themes-blackwall-palette
  (append
   '(
;;;;; Inks
     (void         "#060910")
     (panel        "#0B0F18")
     (raise        "#11161F")
     (edge         "#1D2535")
     (ice          "#C6D2E2")
     (steel        "#9AA7B8")
     (dim          "#6E7A8C")
     (static       "#55607A")

     (wall-crimson "#FF2E4C")
     (wall-deep    "#B3122E")
     (wall-blood   "#6E0A1C")
     (ember        "#FF6A3D")
     (cp-yellow    "#FCEE0A")
     (neon-cyan    "#00E5FF")
     (ice-teal     "#2CE8C8")
     (hot-magenta  "#FF2BD6")
     (violet       "#A26BFF")
     (acid         "#9CFF3D")

     (crimson-lit  "#FF6B80")
     (acid-lit     "#C8FF8A")
     (yellow-lit   "#FFF88A")
     (violet-lit   "#C9A6FF")
     (magenta-lit  "#FF8AE6")
     (cyan-lit     "#5CD9FF")
     (ice-lit      "#F0F6FF")

;;;;; Basic values
     (bg-main     void)
     (bg-dim      panel)
     (bg-active   raise)
     (bg-inactive panel)
     (border      edge)
     (fg-main     ice)
     (fg-dim      dim)
     (fg-alt      steel)
     (fringe      void)

;;;;; Modus named hues re-pointed at the ink set
     (red              wall-crimson)
     (red-warmer       ember)
     (red-cooler       "#FF4F7A")
     (red-faint        "#C4566A")
     (red-intense      "#FF0033")
     (green            acid)
     (green-warmer     "#C6FF4A")
     (green-cooler     ice-teal)
     (green-faint      "#7FA86A")
     (green-intense    "#5CFF00")
     (yellow           cp-yellow)
     (yellow-warmer    ember)
     (yellow-cooler    "#FFD24A")
     (yellow-faint     "#BFAF5A")
     (yellow-intense   "#FFF700")
     (blue             violet)
     (blue-warmer      "#8A7BFF")
     (blue-cooler      neon-cyan)
     (blue-faint       "#6E7FB8")
     (blue-intense     "#4A6BFF")
     (magenta          hot-magenta)
     (magenta-warmer   "#FF5CB0")
     (magenta-cooler   violet)
     (magenta-faint    "#C07AB8")
     (magenta-intense  "#FF00C8")
     (cyan             neon-cyan)
     (cyan-warmer      ice-teal)
     (cyan-cooler      cyan-lit)
     (cyan-faint       "#6FA8B8")
     (cyan-intense     "#00FFF0")
     (rust             "#B3412E")
     (gold             "#C9A227")
     (olive            "#8A9A3B")
     (slate            "#4A5A78")
     (indigo           "#6B5CFF")
     (maroon           wall-deep)
     (pink             "#FF7A9C")

;;;;; Tinted backgrounds
     (bg-red-intense     "#6E0A1C")
     (bg-green-intense   "#0A4A1E")
     (bg-yellow-intense  "#4A3A00")
     (bg-blue-intense    "#2A1A6E")
     (bg-magenta-intense "#5A0A4A")
     (bg-cyan-intense    "#064A5A")
     (bg-red-subtle      "#3A0A14")
     (bg-green-subtle    "#07280F")
     (bg-yellow-subtle   "#2A2000")
     (bg-blue-subtle     "#161040")
     (bg-magenta-subtle  "#300A28")
     (bg-cyan-subtle     "#042830")
     (bg-red-nuanced     "#1A060C")
     (bg-green-nuanced   "#04140A")
     (bg-yellow-nuanced  "#141000")
     (bg-blue-nuanced    "#0C0A20")
     (bg-magenta-nuanced "#180614")
     (bg-cyan-nuanced    "#021418")

;;;;; Special purpose
     (bg-completion       "#0E1724")
     (bg-hl-line          "#0C1119")
     (bg-region           "#1E2A3A")
     (fg-region           ice)
     (bg-popup            panel)
     (bg-hover            "#15283C")
     (bg-hover-secondary  "#101C2C")
     (bg-paren-match      wall-deep)
     (fg-paren-match      ice)
     (bg-paren-expression "#1A1405")

;;;;; Mode line
     (bg-mode-line-active       "#1A0710")
     (fg-mode-line-active       "#FFD2DA")
     (border-mode-line-active   wall-deep)
     (bg-mode-line-inactive     panel)
     (fg-mode-line-inactive     dim)
     (border-mode-line-inactive edge)
     (modeline-err     wall-crimson)
     (modeline-warning cp-yellow)
     (modeline-info    neon-cyan)

;;;;; Tab bar
     (bg-tab-bar     panel)
     (bg-tab-current void)
     (bg-tab-other   panel)

;;;;; Line numbers
     (fg-line-number-active   neon-cyan)
     (bg-line-number-active   unspecified)
     (fg-line-number-inactive "#39445A")
     (bg-line-number-inactive void)

;;;;; Diffs
     (bg-added           "#06220F")
     (bg-added-faint     "#04180B")
     (bg-added-refine    "#0A3A19")
     (bg-added-fringe    acid)
     (fg-added           acid)
     (fg-added-intense   acid-lit)
     (bg-changed         "#1A1405")
     (bg-changed-faint   "#120E03")
     (bg-changed-refine  "#2E2408")
     (bg-changed-fringe  cp-yellow)
     (fg-changed         cp-yellow)
     (fg-changed-intense yellow-lit)
     (bg-removed         "#2A0810")
     (bg-removed-faint   "#1C050A")
     (bg-removed-refine  "#45101E")
     (bg-removed-fringe  wall-crimson)
     (fg-removed         crimson-lit)
     (fg-removed-intense wall-crimson)
     (bg-diff-context    panel)

;;;;; General mappings
     (cursor     wall-crimson)
     (keybind    cp-yellow)
     (name       neon-cyan)
     (identifier violet)
     (err        wall-crimson)
     (warning    cp-yellow)
     (info       ice-teal)

     (underline-err     wall-crimson)
     (underline-warning cp-yellow)
     (underline-note    ice-teal)

     (bg-prominent-err     wall-blood)
     (fg-prominent-err     crimson-lit)
     (bg-prominent-warning "#4A3A00")
     (fg-prominent-warning yellow-lit)
     (bg-prominent-note    "#064A5A")
     (fg-prominent-note    ice-teal)

     (bg-active-argument "#2A0810")
     (fg-active-argument wall-crimson)
     (bg-active-value    "#06220F")
     (fg-active-value    acid)

;;;;; Code mappings
     (builtin      hot-magenta)
     (comment      static)
     (constant     cp-yellow)
     (docstring    dim)
     (docmarkup    steel)
     (fnname       neon-cyan)
     (fnname-call  neon-cyan)
     (keyword      wall-crimson)
     (preprocessor ember)
     (property     ice-teal)
     (string       acid)
     (type         ice-teal)
     (variable     violet)
     (variable-use violet)
     (number       ember)
     (operator     steel)
     (punctuation  steel)
     (bracket      steel)
     (delimiter    steel)
     (rx-backslash ember)
     (rx-construct hot-magenta)

;;;;; Accent mappings
     (accent-0 neon-cyan)
     (accent-1 wall-crimson)
     (accent-2 cp-yellow)
     (accent-3 hot-magenta)

;;;;; Completion mappings
     (fg-completion-match-0 neon-cyan)
     (fg-completion-match-1 wall-crimson)
     (fg-completion-match-2 cp-yellow)
     (fg-completion-match-3 ice-teal)
     (bg-completion-match-0 unspecified)
     (bg-completion-match-1 unspecified)
     (bg-completion-match-2 unspecified)
     (bg-completion-match-3 unspecified)

;;;;; Search mappings
     (bg-search-current wall-crimson)
     (fg-search-current void)
     (bg-search-lazy    "#1E2A3A")
     (fg-search-lazy    neon-cyan)
     (bg-search-static  raise)
     (fg-search-static  cp-yellow)
     (bg-search-replace wall-deep)
     (fg-search-replace ice-lit)

;;;;; Mark mappings
     (bg-mark-delete "#2A0810")
     (fg-mark-delete wall-crimson)
     (bg-mark-select "#042830")
     (fg-mark-select neon-cyan)
     (bg-mark-other  "#2A2000")
     (fg-mark-other  cp-yellow)

;;;;; Prompt mappings
     (bg-prompt unspecified)
     (fg-prompt wall-crimson)

;;;;; Link mappings
     (fg-link          neon-cyan)
     (fg-link-visited  violet)
     (fg-link-symbolic ice-teal)

;;;;; Prose mappings
     (bg-prose-block-contents  panel)
     (bg-prose-block-delimiter panel)
     (fg-prose-block-delimiter static)
     (fg-prose-verbatim        acid)
     (fg-prose-code            ice-teal)
     (fg-prose-macro           hot-magenta)
     (prose-done               acid)
     (prose-todo               wall-crimson)
     (prose-tag                hot-magenta)
     (prose-metadata           static)
     (prose-metadata-value     steel)
     (prose-table              steel)
     (prose-table-formula      cp-yellow)

;;;;; Heading mappings
     (fg-heading-0 wall-crimson)
     (fg-heading-1 cp-yellow)
     (fg-heading-2 neon-cyan)
     (fg-heading-3 hot-magenta)
     (fg-heading-4 ice-teal)
     (fg-heading-5 violet)
     (fg-heading-6 acid)
     (fg-heading-7 ember)
     (fg-heading-8 steel)

;;;;; Date mappings
     (date-common    neon-cyan)
     (date-deadline  wall-crimson)
     (date-event     steel)
     (date-holiday   hot-magenta)
     (date-now       cp-yellow)
     (date-range     ice-teal)
     (date-scheduled ember)
     (date-weekday   neon-cyan)
     (date-weekend   wall-crimson)

;;;;; Rainbow mappings
     (rainbow-0 neon-cyan)
     (rainbow-1 wall-crimson)
     (rainbow-2 cp-yellow)
     (rainbow-3 hot-magenta)
     (rainbow-4 ice-teal)
     (rainbow-5 violet)
     (rainbow-6 acid)
     (rainbow-7 ember)
     (rainbow-8 steel)

;;;;; Terminal mappings
     (bg-term-black           void)
     (fg-term-black           void)
     (bg-term-black-bright    static)
     (fg-term-black-bright    static)
     (bg-term-red             wall-crimson)
     (fg-term-red             wall-crimson)
     (bg-term-red-bright      crimson-lit)
     (fg-term-red-bright      crimson-lit)
     (bg-term-green           acid)
     (fg-term-green           acid)
     (bg-term-green-bright    acid-lit)
     (fg-term-green-bright    acid-lit)
     (bg-term-yellow          cp-yellow)
     (fg-term-yellow          cp-yellow)
     (bg-term-yellow-bright   yellow-lit)
     (fg-term-yellow-bright   yellow-lit)
     (bg-term-blue            violet)
     (fg-term-blue            violet)
     (bg-term-blue-bright     violet-lit)
     (fg-term-blue-bright     violet-lit)
     (bg-term-magenta         hot-magenta)
     (fg-term-magenta         hot-magenta)
     (bg-term-magenta-bright  magenta-lit)
     (fg-term-magenta-bright  magenta-lit)
     (bg-term-cyan            neon-cyan)
     (fg-term-cyan            neon-cyan)
     (bg-term-cyan-bright     ice-teal)
     (fg-term-cyan-bright     ice-teal)
     (bg-term-white           ice)
     (fg-term-white           ice)
     (bg-term-white-bright    ice-lit)
     (fg-term-white-bright    ice-lit))
   modus-themes-vivendi-palette)
  "Base palette shared by every Blackwall variant.

Entries here take precedence over `modus-themes-vivendi-palette', which
supplies every named color and semantic mapping not listed.  A variant
palette prepends its own deltas to this list, so the first match wins.")

;;;; Custom face overrides

(defconst shenzhou-themes-faces
  '(
;;;;; Modus user-option equivalents, baked in
    `(modus-themes-bold ((,c :inherit bold)))
    `(modus-themes-slant ((,c :inherit italic)))
    `(modus-themes-prompt ((,c :inherit bold :background ,bg-prompt :foreground ,fg-prompt)))
;;;;; Modus structural specs a standalone derivative drops
    `(tab-bar ((,c :background ,bg-tab-bar :foreground ,fg-dim :box nil)))
    `(tab-bar-tab ((,c :background ,bg-tab-current :foreground ,wall-crimson :weight bold :underline nil :box nil)))
    `(tab-bar-tab-inactive ((,c :background ,bg-tab-other :foreground ,dim :box nil)))
    `(tab-bar-tab-group-current ((,c :background ,bg-tab-current :foreground ,cp-yellow :box nil)))
    `(tab-bar-tab-group-inactive ((,c :background ,bg-tab-other :foreground ,static :box nil)))
    `(separator-line ((,c :height 0.1 :background ,edge :underline nil)))
    `(log-edit-headers-separator ((,c :height 0.1 :background ,edge :extend t)))
;;;;; meow
    `(meow-normal-indicator ((,c :background ,wall-crimson :foreground ,void :weight bold)))
    `(meow-normal-cursor ((,c :background ,wall-crimson)))
    `(meow-insert-indicator ((,c :background ,cp-yellow :foreground ,void :weight bold)))
    `(meow-insert-cursor ((,c :background ,cp-yellow)))
    `(meow-motion-indicator ((,c :background ,neon-cyan :foreground ,void :weight bold)))
    `(meow-motion-cursor ((,c :background ,neon-cyan)))
    `(meow-keypad-indicator ((,c :background ,hot-magenta :foreground ,void :weight bold)))
    `(meow-keypad-cursor ((,c :background ,hot-magenta)))
    `(meow-beacon-indicator ((,c :background ,ice-teal :foreground ,void :weight bold)))
    `(meow-beacon-cursor ((,c :background ,ice-teal)))
    `(meow-beacon-fake-cursor ((,c :background ,ice-teal :foreground ,void)))
    `(meow-beacon-fake-selection ((,c :background ,bg-region)))
    `(meow-kmacro-cursor ((,c :background ,ember)))
    `(meow-unknown-cursor ((,c :background ,static)))
    `(meow-search-indicator ((,c :foreground ,cp-yellow)))
    `(meow-search-highlight ((,c :background ,bg-search-lazy :foreground ,fg-search-lazy)))
    `(meow-position-highlight-number ((,c :foreground ,cp-yellow :weight bold)))
    `(meow-position-highlight-number-1 ((,c :foreground ,neon-cyan :weight bold)))
    `(meow-position-highlight-number-2 ((,c :foreground ,hot-magenta :weight bold)))
    `(meow-position-highlight-number-3 ((,c :foreground ,ice-teal :weight bold)))
    `(meow-position-highlight-reverse-number-1 ((,c :foreground ,neon-cyan)))
    `(meow-position-highlight-reverse-number-2 ((,c :foreground ,hot-magenta)))
    `(meow-position-highlight-reverse-number-3 ((,c :foreground ,ice-teal)))
    `(meow-region-cursor-1 ((,c :background ,neon-cyan :foreground ,void)))
    `(meow-region-cursor-2 ((,c :background ,hot-magenta :foreground ,void)))
    `(meow-region-cursor-3 ((,c :background ,ice-teal :foreground ,void)))
    `(meow-cheatsheet-command ((,c :foreground ,fg-main)))
    `(meow-cheatsheet-highlight ((,c :foreground ,wall-crimson :weight bold)))
    `(meow-keypad-cannot-display ((,c :foreground ,static)))
;;;;; mood-line
    `(mood-line-buffer-name ((,c :foreground ,fg-mode-line-active :weight bold)))
    `(mood-line-major-mode ((,c :foreground ,neon-cyan)))
    `(mood-line-encoding ((,c :foreground ,dim)))
    `(mood-line-buffer-status-modified ((,c :foreground ,wall-crimson :weight bold)))
    `(mood-line-buffer-status-read-only ((,c :foreground ,cp-yellow)))
    `(mood-line-buffer-status-narrowed ((,c :foreground ,hot-magenta)))
    `(mood-line-frame-status-client ((,c :foreground ,ice-teal)))
;;;;; neotree
    `(neo-banner-face ((,c :foreground ,wall-crimson :weight bold)))
    `(neo-header-face ((,c :foreground ,fg-main)))
    `(neo-root-dir-face ((,c :foreground ,cp-yellow :weight bold)))
    `(neo-dir-link-face ((,c :foreground ,neon-cyan)))
    `(neo-file-link-face ((,c :foreground ,fg-main)))
    `(neo-expand-btn-face ((,c :foreground ,static)))
    `(neo-button-face ((,c :underline nil)))
    `(neo-vc-default-face ((,c :foreground ,fg-main)))
    `(neo-vc-user-face ((,c :foreground ,wall-crimson :slant italic)))
    `(neo-vc-up-to-date-face ((,c :foreground ,dim)))
    `(neo-vc-edited-face ((,c :foreground ,cp-yellow)))
    `(neo-vc-needs-merge-face ((,c :foreground ,ember)))
    `(neo-vc-needs-update-face ((,c :underline t)))
    `(neo-vc-added-face ((,c :foreground ,acid)))
    `(neo-vc-conflict-face ((,c :foreground ,wall-crimson :weight bold)))
    `(neo-vc-missing-face ((,c :foreground ,wall-crimson)))
    `(neo-vc-ignored-face ((,c :foreground ,static)))
    `(neo-vc-removed-face ((,c :foreground ,wall-crimson :strike-through t)))
    `(neo-vc-unlocked-changes-face ((,c :foreground ,hot-magenta)))
    `(neo-vc-unregistered-face ((,c :foreground ,steel)))
;;;;; org-modern
    `(org-modern-label ((,c :height 0.9 :width condensed :weight regular :underline nil)))
    `(org-modern-block-name ((,c :foreground ,static :weight light)))
    `(org-modern-todo ((,c :inherit org-modern-label :background ,wall-crimson :foreground ,void :weight bold)))
    `(org-modern-done ((,c :inherit org-modern-label :background ,panel :foreground ,acid)))
    `(org-modern-priority ((,c :inherit org-modern-label :background ,panel :foreground ,cp-yellow)))
    `(org-modern-date-active ((,c :inherit org-modern-label :background ,raise :foreground ,neon-cyan)))
    `(org-modern-time-active ((,c :inherit org-modern-label :background ,neon-cyan :foreground ,void)))
    `(org-modern-date-inactive ((,c :inherit org-modern-label :background ,panel :foreground ,dim)))
    `(org-modern-time-inactive ((,c :inherit org-modern-label :background ,edge :foreground ,steel)))
    `(org-modern-habit ((,c :inherit org-modern-label)))
    `(org-modern-statistics ((,c :foreground ,ice-teal)))
    `(org-modern-progress-complete ((,c :background ,ice-teal :foreground ,void)))
    `(org-modern-progress-incomplete ((,c :background ,edge :foreground ,steel)))
    `(org-modern-horizontal-rule ((,c :strike-through ,edge)))
    `(org-modern-symbol ((,c :foreground ,hot-magenta)))
    `(org-modern-radio-target ((,c :foreground ,violet :underline t)))
    `(org-modern-internal-target ((,c :foreground ,violet)))
;;;;; eat
    `(eat-shell-prompt-annotation-running ((,c :foreground ,cp-yellow)))
    `(eat-shell-prompt-annotation-success ((,c :foreground ,acid)))
    `(eat-shell-prompt-annotation-failure ((,c :foreground ,wall-crimson)))
;;;;; cov
    `(cov-none-face ((,c :foreground ,wall-crimson)))
    `(cov-light-face ((,c :foreground ,ember)))
    `(cov-med-face ((,c :foreground ,cp-yellow)))
    `(cov-heavy-face ((,c :foreground ,acid)))
    `(cov-coverage-not-run-face ((,c :foreground ,wall-crimson)))
    `(cov-coverage-run-face ((,c :foreground ,acid)))
;;;;; dape
    `(dape-breakpoint-face ((,c :foreground ,wall-crimson :weight bold)))
    `(dape-breakpoint-until-face ((,c :foreground ,cp-yellow)))
    `(dape-exception-description-face ((,c :foreground ,wall-crimson :weight bold)))
    `(dape-expression-face ((,c :foreground ,hot-magenta)))
    `(dape-hits-face ((,c :foreground ,neon-cyan)))
    `(dape-log-face ((,c :foreground ,ice-teal)))
    `(dape-source-line-face ((,c :background ,bg-hl-line :extend t)))
    `(dape-repl-error-face ((,c :foreground ,wall-crimson :weight bold)))
    `(dape-inlay-hint-face ((,c :background ,panel :foreground ,dim)))
    `(dape-inlay-hint-highlight-face ((,c :background ,raise :foreground ,neon-cyan)))
    `(dape-minibuffer-hint-separator-face ((,c :foreground ,edge)))
    `(dape-header-line-active-face ((,c :foreground ,wall-crimson :weight bold)))
    `(dape-header-line-inactive-face ((,c :foreground ,dim)))
    `(dape-header-line-hover-face ((,c :foreground ,neon-cyan :underline t)))
;;;;; consult-gh
    `(consult-gh-default ((,c :foreground ,fg-main)))
    `(consult-gh-repo ((,c :foreground ,neon-cyan)))
    `(consult-gh-user ((,c :foreground ,violet)))
    `(consult-gh-package ((,c :foreground ,ice-teal)))
    `(consult-gh-issue ((,c :foreground ,cp-yellow)))
    `(consult-gh-pr ((,c :foreground ,hot-magenta)))
    `(consult-gh-branch ((,c :foreground ,acid)))
    `(consult-gh-tags ((,c :foreground ,ember)))
    `(consult-gh-visibility ((,c :foreground ,steel)))
    `(consult-gh-date ((,c :foreground ,dim)))
    `(consult-gh-sha ((,c :foreground ,static)))
    `(consult-gh-url ((,c :foreground ,neon-cyan :underline t)))
    `(consult-gh-code ((,c :background ,panel :foreground ,fg-main)))
    `(consult-gh-description ((,c :foreground ,steel)))
    `(consult-gh-highlight-match ((,c :inherit match)))
    `(consult-gh-preview-match ((,c :inherit isearch)))
    `(consult-gh-success ((,c :foreground ,acid :weight bold)))
    `(consult-gh-warning ((,c :foreground ,cp-yellow :weight bold)))
    `(consult-gh-error ((,c :foreground ,wall-crimson :weight bold)))
    `(consult-gh-dired-directory ((,c :foreground ,neon-cyan :weight bold)))
    `(consult-gh-dired-file ((,c :foreground ,fg-main)))
    `(consult-gh-dired-symlink ((,c :foreground ,ice-teal :slant italic)))
    `(consult-gh-dired-commit ((,c :foreground ,static)))
;;;;; pr-review
    `(pr-review-title-face ((,c :foreground ,wall-crimson :weight bold :height 1.1)))
    `(pr-review-state-face ((,c :background ,steel :foreground ,void :weight bold)))
    `(pr-review-success-state-face ((,c :background ,acid :foreground ,void :weight bold)))
    `(pr-review-error-state-face ((,c :background ,wall-crimson :foreground ,void :weight bold)))
    `(pr-review-info-state-face ((,c :background ,neon-cyan :foreground ,void :weight bold)))
    `(pr-review-author-face ((,c :foreground ,violet :weight bold)))
    `(pr-review-branch-face ((,c :foreground ,acid)))
    `(pr-review-hash-face ((,c :foreground ,static)))
    `(pr-review-label-face ((,c :foreground ,hot-magenta :box t)))
    `(pr-review-link-face ((,c :foreground ,neon-cyan :underline t)))
    `(pr-review-button-face ((,c :inherit button)))
    `(pr-review-check-face ((,c :foreground ,ice-teal)))
    `(pr-review-reaction-face ((,c :foreground ,cp-yellow)))
    `(pr-review-timestamp-face ((,c :foreground ,dim)))
    `(pr-review-thread-item-title-face ((,c :foreground ,neon-cyan :weight bold)))
    `(pr-review-thread-comment-face ((,c :background ,panel :extend t)))
    `(pr-review-thread-diff-begin-face ((,c :foreground ,static :overline ,edge)))
    `(pr-review-thread-diff-body-face ((,c :background ,panel :extend t)))
    `(pr-review-thread-diff-end-face ((,c :foreground ,static :underline ,edge)))
    `(pr-review-in-diff-thread-title-face ((,c :foreground ,cp-yellow :weight bold)))
    `(pr-review-in-diff-pending-begin-face ((,c :foreground ,ember)))
    `(pr-review-in-diff-pending-body-face ((,c :background ,raise :extend t)))
    `(pr-review-in-diff-pending-end-face ((,c :foreground ,ember)))
    `(pr-review-fringe-comment-open ((,c :foreground ,cp-yellow)))
    `(pr-review-fringe-comment-pending ((,c :foreground ,ember)))
    `(pr-review-fringe-comment-resolved ((,c :foreground ,acid)))
    `(pr-review-listview-unread-face ((,c :foreground ,fg-main :weight bold)))
    `(pr-review-listview-read-face ((,c :foreground ,dim)))
    `(pr-review-listview-status-face ((,c :foreground ,neon-cyan)))
    `(pr-review-listview-important-activity-face ((,c :foreground ,wall-crimson)))
    `(pr-review-listview-unimportant-activity-face ((,c :foreground ,static)))
    `(pr-review-listview-unsubscribed-face ((,c :foreground ,static :slant italic)))
;;;;; agent-shell
    `(agent-shell-prompt ((,c :foreground ,wall-crimson :weight bold)))
    `(agent-shell-input ((,c :foreground ,fg-main)))
    `(agent-shell-chat-me-label ((,c :foreground ,neon-cyan :weight bold)))
    `(agent-shell-chat-agent-label ((,c :foreground ,wall-crimson :weight bold)))
    `(agent-shell-buffer-name ((,c :foreground ,cp-yellow :weight bold)))
    `(agent-shell-model ((,c :foreground ,violet)))
    `(agent-shell-secondary ((,c :foreground ,dim)))
    `(agent-shell-pending ((,c :foreground ,ember)))
    `(agent-shell-success ((,c :foreground ,acid)))
    `(agent-shell-warning ((,c :foreground ,cp-yellow)))
    `(agent-shell-error ((,c :foreground ,wall-crimson :weight bold)))
    `(agent-shell-link ((,c :foreground ,neon-cyan :underline t)))
    `(agent-shell-key-binding ((,c :foreground ,cp-yellow :weight bold)))
    `(agent-shell-section-heading ((,c :foreground ,hot-magenta :weight bold)))
    `(agent-shell-section-annotation ((,c :foreground ,static)))
    `(agent-shell-container-indicator ((,c :foreground ,ice-teal)))
    `(agent-shell-diff-changes-label ((,c :foreground ,cp-yellow :weight bold)))
    `(agent-shell-permission-title ((,c :foreground ,wall-crimson :weight bold)))
    `(agent-shell-thought-level ((,c :foreground ,violet)))
    `(agent-shell-thought-body ((,c :foreground ,steel :slant italic)))
    `(agent-shell-list-name ((,c :foreground ,neon-cyan)))
    `(agent-shell-list-value ((,c :foreground ,fg-main)))
    `(agent-shell-session-title ((,c :foreground ,fg-main :weight bold)))
    `(agent-shell-session-id ((,c :foreground ,static)))
    `(agent-shell-session-date ((,c :foreground ,dim)))
    `(agent-shell-session-directory ((,c :foreground ,ice-teal)))
    `(agent-shell-session-mode ((,c :foreground ,hot-magenta)))
    `(agent-shell-viewport-prompt ((,c :foreground ,wall-crimson)))
    `(agent-shell-viewport-status-busy ((,c :foreground ,cp-yellow)))
    `(agent-shell-viewport-status-edit ((,c :foreground ,ember)))
    `(agent-shell-viewport-status-view ((,c :foreground ,neon-cyan))))
  "Custom face overrides shared by every Blackwall variant.")

(defconst shenzhou-themes-custom-variables nil
  "Custom variable overrides shared by every Blackwall variant.")

;;;; Variant definition

(defmacro shenzhou-themes-deftheme (name description &rest deltas)
  "Define the Blackwall variant NAME with DESCRIPTION.
DELTAS are palette entries prepended to `shenzhou-themes-blackwall-palette'."
  (let ((palette   (intern (format "%s-palette" name)))
        (user      (intern (format "%s-palette-user" name)))
        (overrides (intern (format "%s-palette-overrides" name)))
        (group     (intern (format "%s-theme" name))))
    `(progn
       (defgroup ,group nil
         ,(format "Options for the `%s' theme." name)
         :group 'shenzhou-themes)

       (defcustom ,user nil
         ,(format "Palette entries added to `%s'." palette)
         :group ',group
         :type '(repeat (list symbol (choice symbol string))))

       (defcustom ,overrides nil
         ,(format "Palette entries overriding `%s'." palette)
         :group ',group
         :type '(repeat (list symbol (choice symbol string))))

       (defconst ,palette (append ',deltas shenzhou-themes-blackwall-palette)
         ,(format "The entire palette of the `%s' theme." name))

       (modus-themes-theme
        ',name 'shenzhou-themes ,description 'dark
        ',palette ',user ',overrides
        'shenzhou-themes-faces 'shenzhou-themes-custom-variables))))

(provide 'shenzhou-themes)
;;; shenzhou-themes.el ends here
