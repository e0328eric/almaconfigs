;; melpa package settings
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; default emacs settings
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(toggle-scroll-bar 0)
(recentf-mode 1)
(set-frame-font "JetBrainsMono Nerd Font 13" nil t)
(setq backup-directory-alist '(("." . "~/.emacs_saves")))
(setenv "LANG" "en_US.UTF-8")
;;(setq-default cursor-type 'bar)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(setq-default indent-tab-mode nil)
(setq-default c-basic-offset 4)
(setq help-window-select t)
(if (eq system-type 'darwin)
  (progn (setq mac-command-modifier 'meta)
	     (setq mac-option-modifier 'super)
	     (setq mac-control-modifier 'control)
	     (setq ns-function-modifier 'hyper)))
 (set-frame-parameter (selected-frame) 'alpha '(85 . 50))
 (add-to-list 'default-frame-alist '(alpha . (85 . 50)))

;; Let TAB acts like vim does (a normal tab)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
