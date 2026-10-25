;;; blackwall-2077-theme.el --- Cyberpunk 2077 Blackwall, the full palette -*- lexical-binding: t; -*-

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

;; The deep void beyond the Blackwall: a near-black blue-tinted background,
;; crimson static for the wall itself, and Cyberpunk 2077's signature yellow
;; and neon cyan for everything that carries data.
;;
;; Usage:
;;
;;     (add-to-list 'custom-theme-load-path "/path/to/this/directory")
;;     (load-theme 'blackwall-2077 t)

;;; Code:

(require 'shenzhou-themes)

(shenzhou-themes-deftheme blackwall-2077
  "Cyberpunk 2077 Blackwall: the wall lit up, carrying data.
The full Cyberpunk 2077 palette on a near-black blue-tinted background --
crimson keywords, #FCEE0A yellow constants, neon cyan functions, teal
types and acid strings.  Louder than `blackwall', which drains the hue
out of the same ink set.")

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;;; blackwall-2077-theme.el ends here
