;; melpa package settings
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install Packages
(setq package-list
	  '(ace-window					 
		auto-complete
		ayu-theme
		clang-format
		company
		doom-modeline
		evil
		evil-leader
		exec-path-from-shell
		flycheck
		gruvbox-theme
		haskell-mode
		magit
		melancholy-theme
		monokai-pro-theme
		multiple-cursors
		nlinum-relative
		popup
		rainbow-delimiters
		rust-mode
		smex
		transpose-frame
		treemacs
		undo-tree
		use-package
		vterm
		which-key
		yasnippet))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

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
(setq-default indent-tab-mode nil)
(custom-set-variables '(tab-width 4))
(setq-default c-basic-offset 4)
(setq help-window-select t)
(exec-path-from-shell-initialize)

;; take out CR from C-m key
(define-key input-decode-map [?\C-m] [C-m])

;; Backup and Autosave Directories
(setq temporary-file-directory "~/.tmp/")
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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

(defun copy-clang-format-to-current-dir ()
  (interactive)
  (shell-command "cp ~/.config/.clang-format ."))

(require 'clang-format)
(defun clang-format-and-save-buffer ()
  (interactive)
  (clang-format-buffer)
  (save-buffer))

;;;;;;;;;;;;;;;;;;;;;;;
;; Basic Keybindings ;;
;;;;;;;;;;;;;;;;;;;;;;;
;; Unbound Keys
(global-unset-key (kbd "C-q"))
(global-unset-key (kbd "C-x C-o"))
(global-unset-key (kbd "C-SPC"))

;; movement keys
(global-set-key (kbd "<C-left>") 'move-beginning-of-line)
(global-set-key (kbd "<C-right>") 'move-end-of-line)

;; Change C-u to C-z for convenience
(global-set-key (kbd "C-z") 'universal-argument)

;; define new keybindings
(global-set-key (kbd "<C-return>") 'add-newline-at-top)
(global-set-key (kbd "<M-return>") 'add-newline-at-bottom)
(global-set-key (kbd "M-W") 'kill-region)
(global-set-key (kbd "C-x C-x") 'set-mark-command)
(global-set-key (kbd "C-x .") 'find-file)
(global-set-key (kbd "C-x C-f") 'set-fill-prefix)
(global-set-key (kbd "C-c SPC") 'exchange-point-and-mark)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "C-M-x C-M-r") 'revert-buffer)
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x C-o C-t") 'vterm-other-window)
(global-set-key (kbd "C-x C-o C-v") 'vterm)
(global-set-key (kbd "C-%") 'quoted-insert)
(global-set-key (kbd "C-q r") 'query-replace)
(global-set-key (kbd "C-q a") 'query-replace-read-args)
(global-set-key (kbd "C-q e") 'query-replace-regexp)
(global-set-key (kbd "C-q C-e") 'query-replace-regexp-eval)

(defun declare-c-cpp-fmt-key ()
	(local-set-key (kbd "C-c <C-m> C-f") 'copy-clang-format-to-current-dir)
	(local-set-key (kbd "C-c C-f") 'clang-format-and-save-buffer))

(add-hook 'c-mode-hook 'declare-c-cpp-fmt-key)
(add-hook 'c++-mode-hook 'declare-c-cpp-fmt-key)

;; finished keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; evil mode
(require 'evil)
(evil-mode 1)

;; evil-leader mode
(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
	"." 'ido-find-file
	"q" 'quit-window
	"f r" 'recentf-open-files
	"b d" 'ido-kill-buffer
	"b l" 'ido-switch-buffer
	"b L" 'list-buffers))

;; auto-complete mode
(require 'auto-complete)
(add-hook 'prog-mode-hook 'auto-complete-mode)

;; hasekll-mode
(require 'haskell-mode)
(setq interactive-haskell-mode t)

;; rust-mode
(use-package rust-mode
  :ensure t
  :config
  (setq rust-format-on-save t))

;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "<C-m> C-l") 'mc/edit-lines)
(global-set-key (kbd "<C-m> C-a") 'mc/mark-all-like-this)
(global-set-key (kbd "<C-S-down>") 'mc/mark-next-like-this)
(global-set-key (kbd "<C-S-up>") 'mc/mark-previous-like-this)

;; doom-modeline
(use-package doom-modeline
  :ensure
  :init
  (doom-modeline-mode 1))

;; rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; relative line numbering
(require 'nlinum-relative)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)
(setq nlinum-relative-offset 0)

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

;; haskell-mode settings
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; smex keybinding
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; which key settings
(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)

;; transpose-frame
(use-package transpose-frame
  :bind (("<C-m> C-t t" .  'transpose-frame)
		 ("<C-m> C-t f" .  'flip-frame)
		 ("<C-m> C-t F" .  'flop-frame)
		 ("<C-m> C-t C-r" .  'rotate-frame)
		 ("<C-m> C-t r" .  'rotate-frame-anti-clockwise)
		 ("<C-m> C-t R" .  'rotate-frame-clockwise)))

;; treemacs settings
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   t
          treemacs-file-event-delay                5000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-width                           35
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :after (treemacs dired)
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))


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
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face 'default)
 '(custom-enabled-themes '(monokai-pro-spectrum))
 '(custom-safe-themes
   '("6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "3325e2c49c8cc81a8cc94b0d57f1975e6562858db5de840b03338529c64f58d1" "d0ebd553aa00983952185f9d0e1a004967614d7c75fc8547f1b9af1f26b77dfc" "c8b83e7692e77f3e2e46c08177b673da6e41b307805cd1982da9e2ea2e90e6d7" "3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" "fb83a50c80de36f23aea5919e50e1bccd565ca5bb646af95729dc8c5f926cbf3" "e3a1b1fb50e3908e80514de38acbac74be2eb2777fc896e44b54ce44308e5330" "b02eae4d22362a941751f690032ea30c7c78d8ca8a1212fdae9eecad28a3587f" "d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" "b6269b0356ed8d9ed55b0dcea10b4e13227b89fd2af4452eee19ac88297b0f99" "24168c7e083ca0bbc87c68d3139ef39f072488703dcdd82343b8cab71c0f62a7" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(fci-rule-color "#3C3D37")
 '(haskell-hoogle-command nil)
 '(haskell-mode-stylish-haskell-path "ormolu")
 '(haskell-stylish-on-save t)
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
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(lua-mode irony yaml-mode rainbow-delimiters ayu-theme magit zenburn-theme clang-format hindent transpose-frame monokai-pro-theme monokai-theme exec-path-from-shell undo-tree which-key nlinum-relative lsp-mode vterm go-mode gruvbox-theme smex))
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

