;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
(setq user-full-name "Sungbae Jeong"
      user-mail-address "almagest0328@gmail.com"
      doom-font (font-spec :family "Fira Code" :size 13 :weight 'medium)
      ;;doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 16)
      doom-theme 'doom-tomorrow-night
      default-directory "~/"
      org-directory "~/Document/org/"
      display-line-numbers-type 'relative)

(if (eq system-type 'darwin)
  (progn (setq mac-command-modifier 'meta)
        (setq mac-option-modifier 'super)
        (setq mac-control-modifier 'control)
        (setq ns-function-modifier 'hyper)))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq-default tab-width 4)
(setq-default flycheck-disabled-checkers '(c/c++-gcc c/c++-clang c/c++-cppcheck tex-chktex))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

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

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "C-q"))

(map! :desc "Find files" :n "C-x ." #'find-file)
(map! :desc "Recent files" :n "C-x C-." #'consult-recent-file)
(map! :desc "Make Cursor Here" :n "g z c" #'evil-mc-make-cursor-here)
(map! :leader :desc "Open treemacs" "\\" #'treemacs)
(map! :leader :desc "dired mode" "." #'dired)
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
