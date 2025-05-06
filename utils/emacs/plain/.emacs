;; melpa package settings
(require 'package)
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Default Settings
(setq backup-directory-alist '(("." . "~/.emacs_saves")))
(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq-default fill-column 80)

;; NOTE: M-x customize-variable exec-path to add PATH inside in emacs
;; NOTE: M-x customize-variable warning-minimum-level to supress warning messages
;; NOTE: M-x customize-variable tab-width to change the default tab with

;; transparent Emacs
(dolist (frame (frame-list))
  (set-frame-parameter frame 'alpha '(85 85))
  (add-to-list 'default-frame-alist '(alpha 85 85)))

;; UTF-8 "is" the standard!
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

(add-to-list 'load-path "~/.emacs.local")
(add-to-list 'load-path "~/.emacs.local/simpc-mode")

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
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.tex\\'" . plain-TeX-mode))
(add-to-list 'auto-mode-alist '("\\.ves\\'" . vesti-mode))

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

;; tree sitter emacs
(use-package tree-sitter-mode
  )

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

(use-package quelpa-use-package
  :ensure t)

;; Language Specific packages
(use-package rustic
  :quelpa (rustic :fetcher github
                  :repo "emacs-rustic/rustic"))

(use-package zig-mode
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default-frame-alist '((vertical-scroll-bars)))
 '(display-line-numbers-type 'relative)
 '(exec-path
   '("c:/Windows/system32" "C:/Windows" "C:/Windows/System32/Wbem" "C:/Windows/System32/WindowsPowerShell/v1.0/" "C:/Windows/System32/OpenSSH/" "C:/Program Files/Neovim/bin" "C:/Program Files (x86)/NVIDIA Corporation/PhysX/Common" "C:/Program Files/NVIDIA Corporation/NVIDIA NvDLISR" "C:/Program Files/starship/bin/" "C:/Program Files (x86)/Windows Kits/10/Windows Performance Toolkit/" "C:/Program Files/dotnet/" "C:/Program Files (x86)/ePapyrus/Papyrus-PlugIn-web" "C:/Program Files (x86)/ePapyrus/Papyrus-PlugIn-web/Addins" "C:/Program Files/Go/bin" "C:/WINDOWS/system32" "C:/WINDOWS" "C:/WINDOWS/System32/Wbem" "C:/WINDOWS/System32/WindowsPowerShell/v1.0/" "C:/WINDOWS/System32/OpenSSH/" "C:/Program Files/nodejs/" "C:/Program Files/Git/cmd" "C:/Program Files/Wolfram Research/WolframScript/" "c:/Program Files/Emacs/emacs-29.4/libexec/emacs/29.4/x86_64-w64-mingw32" "C:/Users/almag/.cargo/bin" "C:/Users/almag/.local/bin" "C:/Program Files/Microsoft Visual Studio/2022/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin" nil))
 '(global-display-line-numbers-mode t)
 '(mc/always-run-for-all t)
 '(package-selected-packages
   '(lsp-mode rustic license-templates org-make-toc org-auto-tangle magit zig-mode cdlatex pdf-tools multiple-cursors aas yasnippet smex which-key timu-caribbean-theme ivy))
 '(tab-always-indent 'complete)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(truncate-lines nil)
 '(warning-minimum-level :error)
 '(word-wrap nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "D2Coding ligature" :foundry "outline" :slant normal :weight regular :height 120 :width normal)))))

