;;; shenzhou-themes-test.el --- Tests for shenzhou-themes -*- lexical-binding: t; -*-
;;; Commentary:
;; ERT suite.  These themes are data, so the tests check the invariants that
;; actually break a startup:
;;
;; - every theme loads and enables in a clean Emacs;
;; - every colour name the shared face list references is defined by every
;;   theme, because `modus-themes-theme' evaluates that list in a lexical
;;   environment built from the palette -- a missing name is a void-variable
;;   at `load-theme' time;
;; - no palette mapping points at a name that does not resolve;
;; - the faces Modus does not cover are still specified;
;; - foreground on background clears WCAG AA.
;;
;; Face *attributes* are deliberately not asserted: the specs are guarded by
;; ((class color) (min-colors 256)), which a batch terminal does not match, so
;; `face-attribute' would report `unspecified' for every theme.
;;; Code:

(require 'ert)
(require 'cl-lib)
(require 'shenzhou-themes)

(defconst shenzhou-themes-test--themes '(blackwall blackwall-2077)
  "Themes shipped by this package.")

(defconst shenzhou-themes-test--uncovered-faces
  '(meow-normal-indicator
    meow-insert-cursor
    org-modern-todo
    neo-root-dir-face
    eat-shell-prompt-annotation-success
    agent-shell-prompt
    dape-breakpoint-face
    cov-heavy-face
    consult-gh-repo
    pr-review-title-face
    mood-line-buffer-name)
  "Representative faces Modus does not provide, which this package must.")

(defun shenzhou-themes-test--palette (theme)
  "Return the palette constant of THEME."
  (symbol-value (intern (format "%s-palette" theme))))

(defun shenzhou-themes-test--resolve (name palette)
  "Resolve NAME through PALETTE to a colour string, `unspecified' or nil.
Resolved here rather than with the Modus accessor, which was renamed from
`modus-themes--retrieve-palette-value' to
`shenzhou-themes-test--resolve' between 5.2 and 5.3."
  (let ((value (cadr (assq name palette)))
        (steps 0))
    (while (and value (symbolp value) (not (eq value 'unspecified)) (< steps 32))
      (setq value (cadr (assq value palette))
            steps (1+ steps)))
    value))

(defun shenzhou-themes-test--load-all ()
  "Load every theme without enabling it."
  (dolist (theme shenzhou-themes-test--themes)
    (unless (custom-theme-p theme)
      (load-theme theme :no-confirm :no-enable))))

(defun shenzhou-themes-test--unquoted-symbols (form)
  "Collect symbols appearing in unquote position inside FORM.
These are exactly the palette names a face spec depends on."
  (let (acc)
    (cl-labels ((walk (x)
                  (cond
                   ((not (consp x)) nil)
                   ((and (eq (car x) '\,) (symbolp (cadr x)))
                    (push (cadr x) acc))
                   (t (walk (car x)) (walk (cdr x))))))
      (walk form))
    (delete-dups acc)))

(defun shenzhou-themes-test--luminance (hex)
  "Relative luminance of HEX per WCAG 2.1."
  (let ((channels (mapcar (lambda (i)
                            (let ((c (/ (string-to-number
                                         (substring hex (1+ (* i 2)) (+ 3 (* i 2))) 16)
                                        255.0)))
                              (if (<= c 0.04045)
                                  (/ c 12.92)
                                (expt (/ (+ c 0.055) 1.055) 2.4))))
                          '(0 1 2))))
    (+ (* 0.2126 (nth 0 channels))
       (* 0.7152 (nth 1 channels))
       (* 0.0722 (nth 2 channels)))))

(defun shenzhou-themes-test--contrast (a b)
  "Contrast ratio between hex colours A and B."
  (let* ((la (shenzhou-themes-test--luminance a))
         (lb (shenzhou-themes-test--luminance b)))
    (/ (+ (max la lb) 0.05) (+ (min la lb) 0.05))))

;;; --- loading ---------------------------------------------------------

(ert-deftest shenzhou-themes-test-themes-load ()
  "Every theme loads without signalling."
  (dolist (theme shenzhou-themes-test--themes)
    (should (progn (load-theme theme :no-confirm :no-enable) t))
    (should (custom-theme-p theme))))

(ert-deftest shenzhou-themes-test-themes-enable ()
  "Every theme enables, and leaves a face spec behind."
  (dolist (theme shenzhou-themes-test--themes)
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme theme :no-confirm)
    (should (memq theme custom-enabled-themes))
    (should (assq theme (get 'default 'theme-face))))
  (mapc #'disable-theme custom-enabled-themes))

(ert-deftest shenzhou-themes-test-family-and-background ()
  "Themes register in the `shenzhou-themes' family and declare a dark background."
  (shenzhou-themes-test--load-all)
  (let ((known (modus-themes-get-all-known-themes 'shenzhou-themes)))
    (dolist (theme shenzhou-themes-test--themes)
      (should (memq theme known))
      (should (eq 'dark (plist-get (get theme 'theme-properties) :background-mode))))))

;;; --- palette ---------------------------------------------------------

(ert-deftest shenzhou-themes-test-core-mappings-resolve ()
  "The mappings every buffer depends on resolve to a hex colour."
  (shenzhou-themes-test--load-all)
  (dolist (theme shenzhou-themes-test--themes)
    (let ((palette (shenzhou-themes-test--palette theme)))
      (dolist (name '(bg-main fg-main cursor keyword string type fnname
                      comment constant builtin err warning info
                      bg-region bg-hl-line bg-mode-line-active fg-mode-line-active))
        (let ((value (shenzhou-themes-test--resolve name palette)))
          (should (stringp value))
          (should (string-match-p "\\`#[0-9A-Fa-f]\\{6\\}\\'" value)))))))

(ert-deftest shenzhou-themes-test-no-dangling-mappings ()
  "No palette entry points at a name that fails to resolve."
  (shenzhou-themes-test--load-all)
  (dolist (theme shenzhou-themes-test--themes)
    (let ((palette (shenzhou-themes-test--palette theme)))
      (dolist (entry palette)
        (let* ((name  (car entry))
               (value (shenzhou-themes-test--resolve name palette)))
          (should (or (stringp value) (eq value 'unspecified))))))))

(ert-deftest shenzhou-themes-test-face-names-are-defined ()
  "Every palette name the shared face list references exists in every theme.
This is the invariant that breaks startup when a new variant is added
without redefining an ink: `modus-themes-theme' evaluates the face list
with only the palette names bound."
  (shenzhou-themes-test--load-all)
  (let ((needed (delete-dups
                 (apply #'append
                        (mapcar #'shenzhou-themes-test--unquoted-symbols
                                shenzhou-themes-faces)))))
    ;; `c' is the display-class spec modus binds, not a palette entry.
    (setq needed (delq 'c needed))
    (should (> (length needed) 10))
    (dolist (theme shenzhou-themes-test--themes)
      (let ((palette (shenzhou-themes-test--palette theme)))
        (dolist (name needed)
          (should (assq name palette)))))))

;;; --- coverage --------------------------------------------------------

(ert-deftest shenzhou-themes-test-uncovered-faces-are-specified ()
  "Faces Modus does not provide are specified by this package."
  (shenzhou-themes-test--load-all)
  (dolist (theme shenzhou-themes-test--themes)
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme theme :no-confirm)
    (dolist (face shenzhou-themes-test--uncovered-faces)
      (should (assq theme (get face 'theme-face)))))
  (mapc #'disable-theme custom-enabled-themes))

;;; --- legibility ------------------------------------------------------

(ert-deftest shenzhou-themes-test-contrast-meets-wcag-aa ()
  "Default and comment foregrounds clear WCAG AA against the background."
  (shenzhou-themes-test--load-all)
  (dolist (theme shenzhou-themes-test--themes)
    (let* ((palette (shenzhou-themes-test--palette theme))
           (bg (shenzhou-themes-test--resolve 'bg-main palette)))
      ;; Body text: AA for normal text.
      (should (>= (shenzhou-themes-test--contrast
                   (shenzhou-themes-test--resolve 'fg-main palette) bg)
                  4.5))
      ;; Comments are allowed to recede, but must clear AA for large text so
      ;; they stay readable on a dim panel.
      (should (>= (shenzhou-themes-test--contrast
                   (shenzhou-themes-test--resolve 'comment palette) bg)
                  3.0))
      ;; ...and they must actually recede, or the hierarchy is lost.
      (should (< (shenzhou-themes-test--contrast
                  (shenzhou-themes-test--resolve 'comment palette) bg)
                 (shenzhou-themes-test--contrast
                  (shenzhou-themes-test--resolve 'fg-main palette) bg)))
      ;; Keywords carry the theme; they must be properly readable.
      (should (>= (shenzhou-themes-test--contrast
                   (shenzhou-themes-test--resolve 'keyword palette) bg)
                  4.5)))))

(provide 'shenzhou-themes-test)
;;; shenzhou-themes-test.el ends here
