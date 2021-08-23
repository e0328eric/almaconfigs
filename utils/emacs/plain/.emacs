;; melpa package settings
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install Packages

(setq packages-to-install '(
	evil
	evil-multiedit
	exec-path-from-shell
	flycheck
	gruvbox-theme
	haskell-mode
	nlinum-relative
	lsp-mode
	rust-mode
	rustic
	smex
	transpose-frame
	undo-tree
	which-key
	yasnippet
))

(while packages-to-install
  (setq pkg (car packages-to-install))
  (setq packages-to-install (cdr packages-to-install))
  (unless (package-installed-p pkg)
    (package-install pkg)))

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
(setq indent-tab-mode nil)
(setq-default tab-width 4)
(setq interactive-haskell-mode t)
(exec-path-from-shell-initialize)

;; evil mode
(require 'evil)
(evil-mode 1)

;; evil multiedit
(require 'evil-multiedit)
(define-key evil-visual-state-map "R" 'evil-multiedit-match-all)
(define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
(define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
(define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)
(define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
(define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
(define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)
(define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
(define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
(define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
(define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)
(evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)

;; relative line numbering
(require 'nlinum-relative)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)
(setq nlinum-relative-current-symbol "->")
(setq nlinum-relative-offset 0)

;; Backup and Autosave Directories
(setq temporary-file-directory "~/.tmp/")
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; undo-tree mode settings
(require 'undo-tree)
(global-undo-tree-mode)
(global-set-key (kbd "C-x C-/") 'undo-tree-redo)

;; yasnippet mode settings
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/mySnippets"))
(define-key yas-minor-mode-map (kbd "TAB") nil)

;; transpose-frame mode settings
(require 'transpose-frame)

;; haskell-mode settings
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; smex keybinding
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "C-f") 'query-replace)

;; which key settings
(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)

;; define new keybindings
(global-set-key (kbd "C-x C-x") 'set-mark-command)
(global-set-key (kbd "C-c SPC") 'exchange-point-and-mark)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "C-M-x C-M-r") 'revert-buffer)

;; emacs theme settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#a1efe4" "#fcfcfa"])
 '(ansi-term-color-vector
   [unspecified "#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#a1efe4" "#fcfcfa"] t)
 '(compilation-message-face 'default)
 '(custom-enabled-themes '(gruvbox-dark-medium))
 '(custom-safe-themes
   '("fb83a50c80de36f23aea5919e50e1bccd565ca5bb646af95729dc8c5f926cbf3" "e3a1b1fb50e3908e80514de38acbac74be2eb2777fc896e44b54ce44308e5330" "b02eae4d22362a941751f690032ea30c7c78d8ca8a1212fdae9eecad28a3587f" "d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" "b6269b0356ed8d9ed55b0dcea10b4e13227b89fd2af4452eee19ac88297b0f99" "24168c7e083ca0bbc87c68d3139ef39f072488703dcdd82343b8cab71c0f62a7" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(fci-rule-color "#3C3D37")
 '(haskell-mode-stylish-haskell-path "brittany")
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save nil)
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#3C3D37" . 0)
	 ("#679A01" . 20)
	 ("#4BBEAE" . 30)
	 ("#1DB4D0" . 50)
	 ("#9A8F21" . 60)
	 ("#A75B00" . 70)
	 ("#F309DF" . 85)
	 ("#3C3D37" . 100)))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   '(hindent transpose-frame monokai-pro-theme monokai-theme exec-path-from-shell undo-tree which-key nlinum-relative lsp-mode vterm go-mode haskell-mode rustic gruvbox-theme smex))
 '(pdf-view-midnight-colors '("#fdf4c1" . "#282828"))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#F92672")
	 (40 . "#CF4F1F")
	 (60 . "#C26C0F")
	 (80 . "#E6DB74")
	 (100 . "#AB8C00")
	 (120 . "#A18F00")
	 (140 . "#989200")
	 (160 . "#8E9500")
	 (180 . "#A6E22E")
	 (200 . "#729A1E")
	 (220 . "#609C3C")
	 (240 . "#4E9D5B")
	 (260 . "#3C9F79")
	 (280 . "#A1EFE4")
	 (300 . "#299BA6")
	 (320 . "#2896B5")
	 (340 . "#2790C3")
	 (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

