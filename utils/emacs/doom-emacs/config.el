;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Default Settings
(setq user-full-name "Sungbae Jeong"
      user-mail-address "almagest0328@gmail.com"
      doom-font (font-spec :family "Fira Code" :size 15 :weight 'medium)
      ;;doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 16)
      doom-theme 'doom-moonlight
      default-directory "~/"
      org-directory "~/Document/org/"
      display-line-numbers-type 'relative)

(setq temporary-file-directory "~/.tmp/")
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(cond (IS-MAC
       (setq mac-command-modifier      'meta
             mac-option-modifier       'alt
             mac-right-option-modifier 'super)))

(menu-bar-mode t)

(setq-default tab-width 4)
(setq-default flycheck-disabled-checkers '(c/c++-gcc c/c++-clang c/c++-cppcheck tex-chktex))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Function Declarations ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

(defun copy-clang-format-to-current-dir ()
  (interactive)
  (shell-command "cp ~/.config/.clang-format ."))

(use-package! clang-format
  :config
  (defun clang-format-and-save-buffer ()
    (interactive)
    (clang-format-buffer)
    (save-buffer)))

(defun my-yas-try-expanding-auto-snippets ()
    (when (and (boundp 'yas-minor-mode) yas-minor-mode)
        (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
        (yas-expand))))
(add-hook 'post-command-hook #'my-yas-try-expanding-auto-snippets)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Import Local Modes ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.local/")
(require 'glasm-mode)
(require 'asy-mode)
(require 'texmathp)

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "C-q"))

(defun c-cpp-configs ()
  (setq c-syntactic-indentation nil)
        (map! :leader :desc "Copy .clang-format file" :n "c F" #'copy-clang-format-to-current-dir)
        (map! :leader :desc "clang-format save buffer" :n "c f" #'clang-format-and-save-buffer))

(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "linux")))

(add-hook 'c-mode-hook 'c-cpp-configs)
(add-hook 'c++-mode-hook 'c-cpp-configs)

(map! :desc "Find files" :n "C-x ." #'find-file)
(map! :desc "Recent files" :n "C-x C-." #'consult-recent-file)
(map! :desc "Make Cursor Here" :n "g z c" #'evil-mc-make-cursor-here)
(map! :leader :desc "Open treemacs" "\\" #'treemacs)
(global-set-key (kbd "<M-left>") 'left-word)
(global-set-key (kbd "<M-right>") 'right-word)
(global-set-key (kbd "<M-up>") 'backward-list)
(global-set-key (kbd "<M-down>") 'forward-list)
(global-set-key (kbd "<C-left>") 'move-beginning-of-line)
(global-set-key (kbd "<C-right>") 'move-end-of-line)
(global-set-key (kbd "<C-up>") 'evil-mc-make-cursor-move-prev-line)
(global-set-key (kbd "<C-down>") 'evil-mc-make-cursor-move-next-line)
(global-set-key (kbd "<M-S-left>") 'backward-chunk)
(global-set-key (kbd "<M-S-right>") 'forward-chunk)
(global-set-key (kbd "<C-return>") 'add-newline-at-top)
(global-set-key (kbd "<M-return>") 'add-newline-at-bottom)
(global-set-key (kbd "C-x t l") 'tab-list)
(global-set-key (kbd "C-q r") 'query-replace)
(global-set-key (kbd "C-q a") 'query-replace-read-args)
(global-set-key (kbd "C-q e") 'query-replace-regexp)
(global-set-key (kbd "C-q C-e") 'query-replace-regexp-eval)

;;;;;;;;;;;;;;
;; Packages ;;
;;;;;;;;;;;;;;
(use-package! doom-snippets
  :load-path "~/.doom.d/snippets"
  :after yasnippet)

;; evil-vimish-fold
(use-package! vimish-fold
  :after evil)

(use-package! evil-vimish-fold
  :after vimish-fold
  :init
  (setq evil-vimish-fold-mode-lighter "  ")
  (setq evil-vimish-fold-target-modes '(prog-mode conf-mode text-mode))
  :config
  (global-evil-vimish-fold-mode))
