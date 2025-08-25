;;; vesti-mode.el --- Major Mode for vesti -*- lexical-binding: t -*-

(defconst vesti-mode-syntax-table
  (with-syntax-table (copy-syntax-table)
	(modify-syntax-entry ?% "<")
	(modify-syntax-entry ?\n ">")
	(syntax-table))
  "Syntax table for `vesti-mode`.")

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
	"ltx3on" "ltx3off" "nonstopmode" "luacode" "mathmode" "compty"))

(defun vesti-font-lock-keywords ()
  (list
   `("\\\\[a-zA-Z@]+" . font-lock-function-name-face)
   `("\\$\\([^$]+\\)\\$" 1 font-lock-string-face)
   `("\\$\\$\\([^$]+\\)\\$\\$" 1 font-lock-string-face)
   `("docclass *\\([a-zA-Z\\-]+\\)" 1 font-lock-variable-name-face)
   `("importpkg *\\([a-zA-Z\\-]+\\)" 1 font-lock-variable-name-face)
   `(,(regexp-opt (vesti-keywords) 'symbols) . font-lock-keyword-face)))

;;;###autoload
(define-derived-mode vesti-mode prog-mode "vesti"
  :syntax-table vesti-mode-syntax-table
  (setq syntax-propertize-function #'vesti-syntax-propertize-function)
  (setq font-lock-defaults '(vesti-font-lock-keywords))
  (setq comment-start "% ")

  ;; force 4-spaces indentation
  (setq tab-width 4)
  (setq indent-tabs-mode nil))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ves\\'" . vesti-mode))

(provide 'vesti-mode)
