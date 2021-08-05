;; melpa package settings
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; default emacs settings
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(toggle-scroll-bar 0)
(ido-mode 1)
(recentf-mode 1)
(set-frame-font "Fira Code 15" nil t)
(setq backup-directory-alist '(("." . "~/.emacs_saves")))
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)

;; relative line numbering
(require 'nlinum-relative)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)
(setq nlinum-relative-current-symbol "->")
(setq nlinum-relative-offset 0)

;; smex keybinding
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; which key settings
(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)

;; define new keybindings
(global-set-key (kbd "C-c SPC") 'set-mark-command)
(global-set-key (kbd "C-c C-f") 'recentf-open-files)

;; emacs theme settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruvbox-dark-medium))
 '(custom-safe-themes
   '("7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(package-selected-packages
   '(which-key nlinum-relative lsp-mode vterm go-mode haskell-mode rustic gruvbox-theme smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

