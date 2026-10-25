;;; blackwall-theme.el --- Cyberpunk 2077 Blackwall, the ICE barrier -*- lexical-binding: t; -*-

;; Copyright (C) 2026 neonmei

;; Author: neonmei <releng@neonmei.cloud>
;; Maintainer: neonmei <releng@neonmei.cloud>
;; URL: https://github.com/neonmei/shenzhou-emacs-themes
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

;; The wall as pure ICE: black, greys and crimson only.  Syntax is separated
;; by intensity and weight rather than hue, and strings recede into the noise.
;;
;; Usage:
;;
;;     (add-to-list 'custom-theme-load-path "/path/to/this/directory")
;;     (load-theme 'blackwall t)

;;; Code:

(require 'shenzhou-themes)

(shenzhou-themes-deftheme blackwall
  "Cyberpunk 2077 Blackwall: the ICE barrier itself.
Monochrome crimson static -- hue-constrained to the red family plus
greys, with syntax separated by intensity rather than color, and strings
receding into the noise."
  (void         "#050508")
  (panel        "#0A0A0F")
  (raise        "#101016")
  (edge         "#1E1E26")
  (ice          "#BFC6D1")
  (steel        "#9AA3AE")
  (dim          "#6B7380")
  (static       "#4E5563")

  (wall-crimson "#FF2E4C")
  (wall-deep    "#B3413A")
  (wall-blood   "#7A1220")
  (ember        "#FF5C3B")
  (cp-yellow    "#FF9470")
  (neon-cyan    "#E0B4B4")
  (ice-teal     "#C8707A")
  (hot-magenta  "#D2566B")
  (violet       "#A86A72")
  (acid         "#9AA3AE")

  (crimson-lit  "#FF7A8C")
  (acid-lit     "#C4CBD6")
  (yellow-lit   "#FFB49A")
  (violet-lit   "#C99098")
  (magenta-lit  "#E88494")
  (cyan-lit     "#EDD0D0")
  (ice-lit      "#E6EAF0")

  (bg-completion       "#140F12")
  (bg-hl-line          "#0D0D12")
  (bg-region           "#2A1E22")
  (bg-hover            "#2E1A1F")
  (bg-hover-secondary  "#1E1418")

  (bg-mode-line-active "#1C0609")
  (fg-mode-line-active "#F0C8CC")

  (fg-line-number-active   wall-crimson)
  (fg-line-number-inactive "#3A3A45")

  (bg-added            "#141A14")
  (bg-added-refine     "#1E2A1E")
  (bg-changed          "#241A10")
  (bg-changed-refine   "#38281A")
  (bg-removed          "#2A0810")
  (bg-removed-refine   "#45101E")

  (keyword      wall-crimson)
  (fnname       ember)
  (fnname-call  ember)
  (type         cp-yellow)
  (builtin      wall-deep)
  (constant     neon-cyan)
  (string       steel)
  (variable     ice)
  (variable-use ice)
  (property     ice-teal)
  (number       hot-magenta)
  (comment      static)
  (docstring    dim)
  (info         steel)

  (fg-heading-0 wall-crimson)
  (fg-heading-1 ember)
  (fg-heading-2 cp-yellow)
  (fg-heading-3 wall-deep)
  (fg-heading-4 neon-cyan)
  (fg-heading-5 ice-teal)
  (fg-heading-6 steel)
  (fg-heading-7 hot-magenta)
  (fg-heading-8 dim))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;;; blackwall-theme.el ends here
