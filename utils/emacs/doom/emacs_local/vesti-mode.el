;;; vesti-mode.el -- vesti mode for emacs
;;;
;;; Commentary:
;;;
;;; Code:

(require 'make-regexp)

(defconst vesti-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\\ "\\" table)
    (modify-syntax-entry ?% "< 14b" table)
    (modify-syntax-entry ?* ". 23b" table)
    (modify-syntax-entry ?\n "> b" table)
    (modify-syntax-entry ?\^m "> b" table)
    table))

(defconst vesti-font-lock-defaults
  (list
    '((regexp-opt '("docclass" "import" "startdoc" "useenv" "begenv" "endenv" "mtxt" "etxt") t) . font-lock-keyword-face)
    '((regexp-opt '("#!" "$!") t) . font-lock-preprocessor-face)))

(defalias 'vesti-parent-mode
 (if (fboundp 'prog-mode) 'prog-mode 'fundamental-mode))

;;;###autoload
(define-derived-mode vesti-mode fundamental-mode "vesti"
  :set-syntax-table vesti-mode-syntax-table
  (setq-local font-lock-defaults '(vesti-font-lock-defaults)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ves\\'" . vesti-mode))

(provide 'vesti-mode)
