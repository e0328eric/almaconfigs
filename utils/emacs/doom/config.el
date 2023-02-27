;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Sungbae Jeong"
      user-mail-address "almagest0328@gmail.com")

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq doom-font (font-spec :family "Comic Code Ligatures" :size 12)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font Mono" :size 12)
      doom-unicode-font (font-spec :family "D2Coding ligature" :size 12))

(setq doom-theme 'doom-gruvbox)

(setq display-line-numbers-type 'relative)
(setq org-directory "~/.config/emacs/org")

(add-to-list 'load-path (expand-file-name "~/.config/doom/emacs_local/"))
(require 'asy-mode)
(require 'texmathp)
(require 'vesti-mode)

(use-package aas
  :ensure t
  :hook (latex-mode .	aas-activate-for-major-mode)
  :hook (tex-mode	.	aas-activate-for-major-mode)
  :config
  (aas-set-snippets 'tex-mode
	"MK"  (lambda () (interactive)
		    (yas-expand-snippet "\\$$1\\$$0"))
	:cond #'texmathp ; expand only while in math
    ;; bind to functions!
    "//" (lambda () (interactive)
           (yas-expand-snippet "{$1 \\over $2}$0")))
  (aas-set-snippets 'latex-mode
	"MK"  (lambda () (interactive)
		    (yas-expand-snippet "\\$$1\\$$0"))
	:cond #'texmathp ; expand only while in math
    ;; bind to functions!
    "//" (lambda () (interactive)
           (yas-expand-snippet "\\frac{$1}{$2}$0")))
  ;; disable snippets by redefining them with a nil expansion
  (aas-set-snippets 'latex-mode
    "supp" nil))

(map! :desc "Move to the next tab" :g "C-x f ]" #'tab-next)
(map! :desc "Move to the previous tab" :g "C-x f [" #'tab-previous)

(map! :desc "Make a cursor below" :g "<C-down>" #'mc/mark-next-like-this)
(map! :desc "Make a cursor above" :g "<C-up>" #'mc/mark-previous-like-this)

(defun format-all-buffer-and-save ()
    "Format a buffer and save it"
  (interactive)
  (format-all-buffer)
  (save-buffer))
(map! :desc "Formatting Buffer" :ni "C-c C-f" #'format-all-buffer-and-save)
