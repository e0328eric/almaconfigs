;; vesti-mode.el -- vesti mode for emacs

; (require 'rx)

(defconst vesti-mode-syntax-table
  (let ((table (make-syntax-table)))
	(modify-syntax-entry ?\\ "\\" table)

	(modify-syntax-entry ?# "< 14b" table)
	(modify-syntax-entry ?* ". 23b" table)
	(modify-syntax-entry ?\n "> b" table)
	(modify-syntax-entry ?\^m "> b" table)

	table))

(defconst vesti-keywords
  '("docclass" "import" "startdoc" "begenv" "endenv" "mtxt" "etxt"))

(defconst vesti-special-symbols
  '("#!" "$!"))

(defconst vesti-font-lock-defaults
  '(
	;; keywords
	(,(regexp-opt vesti-keywords 'symbols) . font-lock-keyword-face)
	;; special symbols
	(,(regexp-opt vesti-special-symbols 'symbols) . font-lock-preprocessor-face)
	))

(defalias 'vesti-parent-mode
 (if (fboundp 'prog-mode) 'prog-mode 'fundamental-mode))

;;;###autoload
(define-derived-mode vesti-mode vesti-parent-mode "vesti"
  :syntax-table vesti-mode-syntax-table
  :group 'vesti-mode
  (setq-local font-lock-defaults '(vesti-font-lock-defaults))

  (font-lock-fontify-buffer))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ves\\'" . vesti-mode))

(provide 'vesti-mode)
