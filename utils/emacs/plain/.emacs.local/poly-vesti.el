;;; poly-vesti.el --- Polymode for Vesti luacode blocks -*- lexical-binding: t; -*-

;; Requires: polymode, vesti-mode, lua-mode

(require 'polymode)
(require 'vesti-mode)
(require 'lua-mode)

;; Host: your normal vesti-mode buffer
(define-hostmode poly-vesti-hostmode
  :mode 'vesti-mode)

;; Inner: #lu: ... :lu#
;;
;; - Head is a line that starts with "#lu:" (allowing trailing spaces/comments)
;; - Tail is a line that starts with ":lu#"
;; - Body uses (poly-vesti--lua-mode)
;;
(define-innermode poly-vesti-lua-innermode
  :mode 'lua-mode
  :head-matcher "^#lu:[ \t]*\\(?:.*\\)?$"
  :tail-matcher "^:lu#[ \t]*$"
  :head-mode 'host
  :tail-mode 'host
  :body-indent-offset 0
  :protect-font-lock nil
  :indent-offset 0)

;; The combined polymode
(define-polymode poly-vesti-mode
  :hostmode 'poly-vesti-hostmode
  :innermodes '(poly-vesti-lua-innermode)
  (setq-local pm-chunkmode-name "lua"))

;;; Optional: auto-enable polymode for .ves / .vesti
;;; Comment these two lines out if you want to turn it on manually.
(add-to-list 'auto-mode-alist '("\\.ves\\'"   . poly-vesti-mode))
;;(add-to-list 'auto-mode-alist '("\\.vesti\\'" . poly-vesti-mode))

(provide 'poly-vesti)
;;; poly-vesti.el ends here
