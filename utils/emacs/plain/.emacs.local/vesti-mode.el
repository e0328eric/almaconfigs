;;; vesti-mode.el --- Major Mode for vesti (TS-aware) -*- lexical-binding: t; -*-

;;; Commentary:
;; - If the Tree-sitter grammar 'vesti' is available, `vesti-ts-mode` is used.
;; - Otherwise, it falls back to classic `vesti-mode` with regex highlighting.
;;
;; Optional: set a custom path where your compiled grammar lives:
;;   (setq vesti-treesit-extra-load-path '("~/.emacs.d/tree-sitter/"))
;; or push it into `treesit-extra-load-path` yourself.

;;; Code:

(defgroup vesti nil
  "Vesti language support."
  :group 'languages)

(defcustom vesti-treesit-extra-load-path nil
  "Extra directories to search for the Vesti Tree-sitter grammar (.so/.dll/.dylib)."
  :type '(repeat directory))

;; ------------------------------
;; Utilities
;; ------------------------------

(defun vesti--ensure-treesit-path ()
  "Ensure `treesit-extra-load-path` includes `vesti-treesit-extra-load-path`."
  (when (and (boundp 'treesit-extra-load-path) vesti-treesit-extra-load-path)
    (dolist (p vesti-treesit-extra-load-path)
      (cl-pushnew (expand-file-name p) treesit-extra-load-path :test #'string-equal))))

(defun vesti--treesit-grammar-available-p ()
  "Non-nil if tree-sitter and the 'vesti' grammar are available."
  (when (require 'treesit nil t)
    (vesti--ensure-treesit-path)
	;; Load this before you try to create the parser
	(add-to-list 'treesit-load-name-override-list
				 '(vesti "vesti" "tree_sitter_vesti"))
    (and (fboundp 'treesit-available-p)
         (treesit-available-p)
         (ignore-errors (treesit-language-available-p 'vesti)))))

;; ------------------------------
;; Classic (regex) mode
;; ------------------------------

(defconst vesti-mode-syntax-table
  (with-syntax-table (copy-syntax-table)
    (modify-syntax-entry ?% "<")
    (modify-syntax-entry ?\n ">")
    (syntax-table))
  "Syntax table for `vesti-mode` and as a base for TS mode.")

(defun vesti-syntax-propertize-function (start end)
  (goto-char start)
  (funcall
   (syntax-propertize-rules
    ;; block comments %* ... *%
    ("\\(%\\)\\(\\*\\)"
     (1 "< b")    ; % is start of a block comment
     (2 "< b"))   ; * is start of a block comment
    ("\\(\\*\\)%"
     (1 "> b")))  ; * is end of a block comment
   start end))

(defun vesti-keywords ()
  '("docclass" "importpkg" "importmod" "copyfile" "importves" "useltx3"
    "getfp" "startdoc" "useenv" "begenv" "endenv" "makeatletter" "makeatother"
    "ltx3on" "ltx3off" "nonstopmode" "mathmode" "compty" "pycode"))

(defun vesti-font-lock-keywords ()
  (list
   ;; \commands
   '("\\\\[a-zA-Z@]+" . font-lock-function-name-face)
   ;; $...$ and $$...$$ math chunks
   '("\\$\\([^$]+\\)\\$" 1 font-lock-string-face)
   '("\\$\\$\\([^$]+\\)\\$\\$" 1 font-lock-string-face)
   ;; simple directives after a keyword
   '("docclass *\\([a-zA-Z\\-]+\\)" 1 font-lock-variable-name-face)
   '("importpkg *\\([a-zA-Z\\-]+\\)" 1 font-lock-variable-name-face)
   `(,(regexp-opt (vesti-keywords) 'symbols) . font-lock-keyword-face)))

;;;###autoload
(define-derived-mode vesti-mode prog-mode "Vesti"
  "Major mode for the Vesti language (regex highlighter)."
  :syntax-table vesti-mode-syntax-table
  (setq-local syntax-propertize-function #'vesti-syntax-propertize-function)
  (setq-local font-lock-defaults '(vesti-font-lock-keywords))
  (setq-local comment-start "% ")
  ;; force 4-spaces indentation
  (setq-local tab-width 4)
  (setq-local indent-tabs-mode nil))

;; ------------------------------
;; Tree-sitter mode (if available)
;; ------------------------------

;; Minimal TS font-lock: keep regex font-lock for now (robust regardless of node names).
;; If you later add Emacs TS queries, you can set `treesit-font-lock-settings` here.
(when (vesti--treesit-grammar-available-p)
  ;; Register the language source (handy for `treesit-install-language-grammar`, even if you built manually)
  (add-to-list 'treesit-language-source-alist
               '(vesti "https://github.com/e0328eric/tree-sitter-vesti.git"))

  ;; Define TS major mode
  (define-derived-mode vesti-ts-mode prog-mode "Vesti[TS]"
    "Tree-sitter major mode for the Vesti language."
    :syntax-table vesti-mode-syntax-table
    (vesti--ensure-treesit-path)
    (unless (treesit-parser-create 'vesti)
      (user-error "Vesti Tree-sitter grammar found but parser creation failed"))
    ;; Use the same regex font-lock to guarantee good defaults
    ;; (You can switch to `treesit-font-lock-settings` later when you add queries.)
    (setq-local font-lock-defaults '(vesti-font-lock-keywords))
    (setq-local syntax-propertize-function #'vesti-syntax-propertize-function)
    (setq-local comment-start "% ")
    (setq-local tab-width 4)
    (setq-local indent-tabs-mode nil)
    ;; Optional: basic TS-based syntax navigation hooks can go here later.
    )

  ;; Prefer TS mode automatically when grammar is present
  (add-to-list 'major-mode-remap-alist '(vesti-mode . vesti-ts-mode)))

;; ------------------------------
;; File association
;; ------------------------------

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ves\\'" . vesti-mode))

(provide 'vesti-mode)
;;; vesti-mode.el ends here

