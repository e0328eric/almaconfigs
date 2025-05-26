;; melpa package settings
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq custom-file "~/.emacs.custom.el")
(add-to-list 'load-path "~/.emacs.local/")
(add-to-list 'load-path "~/.emacs.local/simpc-mode")
(setq backup-directory-alist '((".*" . "~/.emacs.d/backups")))

;; default settings
(setq-default inhibit-splash-screen t)
(setq-default tab-width 4)
(setq-default display-line-numbers-type 'relative)
(setq-default visible-bell (eq system-type 'windows-nt))
(setq-default fill-column 80)
;(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; open new buffer with horizontal mode
(add-to-list 'display-buffer-alist
			 '("^\\*compilation\\*"
			   (display-buffer-reuse-window display-buffer-at-bottom)
			   (window-height . 0.3)))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode 1)

;; UTF-8 "is" the standard!
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; setting fonts
(when (member "JetBrainsMono NFM Medium" (font-family-list))
  (set-frame-font "JetBrainsMono NFM Medium-11" nil t))

;; enable hard line wrap at both latex mode and tex mode
(add-hook 'TeX-mode-hook 'auto-fill-mode)
(add-hook 'tex-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'latex-mode-hook 'auto-fill-mode)

;; utility functions
(defun add-newline-at-top ()
  (interactive)
  (beginning-of-line)
  (newline-and-indent)
  (previous-line))

(defun add-newline-at-bottom ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun forward-chunk ()
  "Forward to the end of the 'word at point' (vim-like)."
  (interactive)
  (skip-syntax-forward "-")
  (skip-syntax-forward "^-"))

(defun backward-chunk ()
  "Backward to the start of the 'word at point' (vim-like)."
  (interactive)
  (skip-syntax-backward "-")
  (skip-syntax-backward "^-"))


;; copied this function from here:
;; https://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; Keybindings
(global-unset-key (kbd "C-\\"))
(global-unset-key (kbd "M-\\"))
(global-unset-key (kbd "C-q"))
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "<M-up>") 'scroll-down-command)
(global-set-key (kbd "<M-down>") 'scroll-up-command)
(global-set-key (kbd "<M-left>") 'smarter-move-beginning-of-line)
(global-set-key (kbd "<M-right>") 'move-end-of-line)
(global-set-key (kbd "C-x C-x") 'set-mark-command)
(global-set-key (kbd "<M-S-left>") 'backward-chunk)
(global-set-key (kbd "<M-S-right>") 'forward-chunk)
(global-set-key (kbd "C-\\") 'add-newline-at-top)
(global-set-key (kbd "M-\\") 'add-newline-at-bottom)
(global-set-key (kbd "C-x C-.") 'recentf-open)
(global-set-key (kbd "C-x C-d") 'dired)

;; define ESC related keybindings (ESC-t is the prefix of the tremacs)
(global-set-key (kbd "<escape> c") 'compile)
(global-set-key (kbd "<escape> s") 'prettify-symbols-mode)
(global-set-key (kbd "<escape> a") 'auto-fill-mode)
(global-set-key (kbd "<escape> q") 'quoted-insert)
(global-set-key (kbd "<escape> b r") 'revert-buffer)

;; set the default mode for files
(require 'simpc-mode)
(require 'vesti-mode)
(require 'fasm-mode)

(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.tex\\'" . plain-TeX-mode))
(add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))

;;================================================================================
;;                               PACKAGE CONFIGS
;;================================================================================
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom))

(use-package smex
  :ensure t
  :bind
  (("M-x" . 'smex)
   ("M-X" . 'smex-major-mode-commands)
   ("C-c C-c M-x" . 'execute-extended-command)))

(use-package timu-caribbean-theme
  :ensure t
  :config
  (load-theme 'timu-caribbean t))

(use-package auto-complete
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'auto-complete-mode))

(use-package org-auto-tangle
  :ensure t)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "M-l") ;; Alt+l as prefix
  :hook
  (;; Whitelist for lsp
   (zig-mode . lsp-mode)
   (rustic-mode . lsp-mode)
   (lean4-mode . lsp-mode)
   ;; Blacklist for lsp
   (emacs-lisp-mode . (lambda () (lsp-mode -1)))
   (text-mode . (lambda () (lsp-mode -1)))
   (latex-mode . (lambda () (lsp-mode -1)))
   (plain-TeX-mode . (lambda () (lsp-mode -1)))))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :bind
  ("<escape> h h" . lsp-ui-doc-show))

(setq lsp-ui-doc-enable t)             ;; Enable hover doc
(setq lsp-ui-doc-show-with-cursor nil) ;; Show only on hover, not on cursor move
(setq lsp-ui-doc-show-with-mouse t)    ;; Show on mouse hover (optional)
(setq lsp-ui-doc-delay 0.5)            ;; How fast to show doc (seconds)
(setq lsp-ui-doc-position 'at-point)   ;; Show tooltip at point (other options: top, bottom, etc.)

;; alternative for ido mode
(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "[%d/%d] "))

(use-package magit
  :ensure t
  :pin melpa
  :bind
  (("C-x g" . magit-status)))

;; better performance using latex
;; see the below link for more information
;; https://michaelneuper.com/posts/efficient-latex-editing-with-emacs/
(use-package cdlatex
  :ensure t
  :config
  (define-key cdlatex-mode-map (kbd "<C-return>") nil)
  (define-key cdlatex-mode-map (kbd "TAB") nil)
  (define-key cdlatex-mode-map (kbd "<tab>") nil)
  (setq cdlatex-paired-parens "$"))

;; yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs '("~/.emacs.local/snippets"))
  (define-key yas-minor-mode-map [(tab)] nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (yas-reload-all)
  :bind
  ("C-q" . #'yas-expand))

;; another great snippet pcakage
(require 'texmathp)
(use-package aas
  :ensure t
  :hook (latex-mode . aas-activate-for-major-mode)
  :hook (tex-mode . aas-activate-for-major-mode)
  :hook (vesti-mode . aas-activate-for-major-mode)
  :config
  (aas-set-snippets 'vesti-mode
	"MK"  (lambda () (interactive)
		    (yas-expand-snippet "\\$$1\\$$0")))
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

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-z C-l") 'mc/edit-lines)
  (global-set-key (kbd "C-z C-a") 'mc/mark-all-like-this)
  (global-set-key (kbd "C-z C-z") 'mc/mark-next-like-this-word)
  (global-set-key (kbd "<C-down>") 'mc/mark-next-like-this)
  (global-set-key (kbd "<C-up>") 'mc/mark-previous-like-this)
  (global-unset-key (kbd "M-<down-mouse-1>"))
  (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  ;; Prevent undo tree files from polluting your git repo
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  :bind
  ("C-x C-/" . 'undo-tree-redo))

(use-package zig-mode
  :ensure t)

(use-package lean4-mode
  :commands lean4-mode
  :vc (:url "https://github.com/leanprover-community/lean4-mode.git"
	   :rev :last-release))

(cond
 ((eq system-type 'windows-nt)
  (load-file "~/.emacs.local/msvc_env.el")))
