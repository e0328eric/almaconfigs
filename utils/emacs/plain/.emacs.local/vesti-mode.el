(defvar vesti-mode-syntax-table
  (let ((table (make-syntax-table)))
	(modify-syntax-entry ?% ". 124b" table)
	(modify-syntax-entry ?* ". 23" table)
	(modify-syntax-entry ?\n "> b" table)
	table))

(defun vesti-keywords ()
  '("docclass" "importpkg" "importves" "importfile" "useltx3" "getfp"
	"startdoc" "useenv" "begenv" "endenv" "makeatletter" "makeatother"
	"ltx3on" "ltx3off" "nonstopmode" "luacode"))

(defun vesti-font-lock-keywords ()
  (list
   `("\\\\\\w+" . font-lock-fuction-name-face)
   `("\\$\\([^$]+\\)\\$" 1 font-lock-string-face)
   `("\\$\\$\\([^$]+\\)\\$\\$" 1 font-lock-string-face)
   `("docclass *\\([a-zA-Z\\-]+\\)" 1 font-lock-variable-name-face)
   `("importpkg *\\([a-zA-Z\\-]+\\)" 1 font-lock-variable-name-face)
   `(,(regexp-opt (vesti-keywords) 'symbols) . font-lock-keyword-face)))

(define-derived-mode vesti-mode prog-mode "vesti"
  :syntax-table vesti-mode-syntax-table
  (setq-local font-lock-defaults '(vesti-font-lock-keywords))
  (setq-local comment-start "% "))

(provide 'vesti-mode)
