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
(set-frame-font "Fira Code 16" nil t)
(setq backup-directory-alist '(("." . "~/.emacs_saves")))
(setenv "LANG" "en_US.UTF-8")
;;(setq-default cursor-type 'bar)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(setq-default indent-tab-mode nil)
(setq-default c-basic-offset 4)
(setq help-window-select t)
(if (eq system-type 'darwin)
    (setq mac-command-modifier 'meta))

(add-to-list 'load-path "~/.emacs.local/xcode-theme")

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; alternative to ido mode
(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "[%d/%d] "))

;; Install Theme
(use-package monokai-theme
  :ensure t)
(use-package gruvbox-theme
  :ensure t)
(use-package nord-theme
   :ensure t)

;; ace-window
(use-package ace-window
  :ensure t)

;; company mode
(use-package company
  :ensure t)

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

(use-package clang-format
  :ensure t
  :config
  (defun clang-format-and-save-buffer ()
    (interactive)
    (clang-format-buffer)
    (save-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;
;; Basic Keybindings ;;
;;;;;;;;;;;;;;;;;;;;;;;
;; Unbound Keys
(global-unset-key (kbd "C-q"))
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-o"))
(global-unset-key (kbd "<escape>"))
(global-unset-key (kbd "<C-escape>"))
(global-unset-key (kbd "<M-escape>"))

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

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

;; movement keys
(global-set-key (kbd "<M-left>") 'left-word)
(global-set-key (kbd "<M-right>") 'right-word)
(global-set-key (kbd "<M-up>") 'backward-list)
(global-set-key (kbd "<M-down>") 'forward-list)
(global-set-key (kbd "<C-left>") 'move-beginning-of-line)
(global-set-key (kbd "<C-right>") 'move-end-of-line)
(global-set-key (kbd "<M-S-left>") 'backward-chunk)
(global-set-key (kbd "<M-S-right>") 'forward-chunk)

;; define new keybindings
(global-set-key (kbd "<C-return>") 'add-newline-at-top)
(global-set-key (kbd "<M-return>") 'add-newline-at-bottom)
(global-set-key (kbd "C-S-s") 'isearch-backward)
(global-set-key (kbd "M-W") 'kill-region)
(global-set-key (kbd "C-x x") 'mark-word)
(global-set-key (kbd "C-x C-x") 'set-mark-command)
(global-set-key (kbd "C-x .") 'find-file)
(global-set-key (kbd "C-x C-.") 'recentf-open-files)
(global-set-key (kbd "C-x C-f") 'set-fill-prefix)
(global-set-key (kbd "C-x t l") 'tab-list)
(global-set-key (kbd "C-c SPC") 'exchange-point-and-mark)
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x C-o C-t") 'vterm-other-window)
(global-set-key (kbd "C-x C-o C-v") 'vterm)
(global-set-key (kbd "C-z c") 'compile)
(global-set-key (kbd "C-z C-c") 'recompile)
(global-set-key (kbd "C-z e") 'eval-expression)
(global-set-key (kbd "C-%") 'quoted-insert)
(global-set-key (kbd "C-q r") 'query-replace)
(global-set-key (kbd "C-q a") 'query-replace-read-args)
(global-set-key (kbd "C-q e") 'query-replace-regexp)
(global-set-key (kbd "C-q C-e") 'query-replace-regexp-eval)

;; define ESC related keybindings (ESC-t is the prefix of the tremacs)
(global-set-key (kbd "<escape> c") 'compile)
(global-set-key (kbd "<escape> e") 'eval-expression)
(global-set-key (kbd "<escape> o") 'overwrite-mode)
(global-set-key (kbd "<escape> b r") 'revert-buffer)

;; define C-ESC related keybindings
(global-set-key (kbd "<C-escape>") 'universal-argument)

;; finished keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Config for each mode ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun c-cpp-configs ()
    (setq c-syntactic-indentation nil)
	(local-set-key (kbd "C-z C-f C-c") 'copy-clang-format-to-current-dir)
	(local-set-key (kbd "C-z C-f C-s") 'clang-format-and-save-buffer))

(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "linux")))

(add-hook 'c-mode-hook 'c-cpp-configs)
(add-hook 'c++-mode-hook 'c-cpp-configs)

(defun tex-configs ()
  (local-set-key (kbd "<C-S-return>") 'tex-feed-input)
  (local-set-key (kbd "<C-return>") 'add-newline-at-top)
  (local-set-key (kbd "<M-return>") 'add-newline-at-bottom))

(add-hook 'tex-mode 'tex-configs)

(add-to-list 'load-path "~/.emacs.local/")
(require 'glasm-mode)
(require 'asy-mode)
(require 'texmathp)

;; auto-complete mode
(use-package auto-complete
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'auto-complete-mode))

;; ace-window mode
(use-package ace-window
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-background nil))

;; hasekll-mode
(use-package lsp-mode
  :ensure t
  :hook (haskell-mode . lsp)
  :commands lsp)
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
(use-package lsp-haskell
  :ensure t
  :config
 (setq lsp-haskell-server-path "haskell-language-server-wrapper")
 (setq lsp-haskell-server-args ())
   ;; Comment/uncomment this line to see interactions between lsp client/server.
 (setq lsp-log-io t))

;; c++-mode
(use-package lsp-mode
  :ensure t
  :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)
(use-package eglot :ensure t)

(defun projectile-project-find-function (dir)
  (let* ((root (projectile-project-root dir)))
    (and root (cons 'transient root))))

(with-eval-after-load 'project
  (add-to-list 'project-find-functions 'projectile-project-find-function))
;;(setq company-transformers nil)

(use-package cmake-mode
  :ensure t)

;; rust-mode
(use-package rust-mode
  :ensure t
  :config
  (setq rust-format-on-save t))

;; rustic-mode
(use-package rustic
  :ensure t
  :config
  (setq rustic-format-on-save t))

;;  auto-activating-snippets
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

;; multiple-cursors
(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "<C-m> C-l") 'mc/edit-lines)
  (global-set-key (kbd "<C-m> C-a") 'mc/mark-all-like-this)
  (global-set-key (kbd "<C-down>") 'mc/mark-next-like-this)
  (global-set-key (kbd "<C-up>") 'mc/mark-previous-like-this)
  (global-unset-key (kbd "M-<down-mouse-1>"))
  (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click))

;; doom-modeline
(use-package doom-modeline
  :ensure t
  :init
  (unless (package-installed-p 'doom-modeline)
	(all-the-icons-install-fonts))
  (doom-modeline-mode 1))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; relative line numbering
(use-package nlinum-relative
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0)
  (setq nlinum-relative-offset 0))

;; undo-tree mode settings
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  :bind
  ("C-x C-/" . 'undo-tree-redo))

;; yasnippet mode settings
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (define-key yas-minor-mode-map (kbd "TAB") nil))

;; smex keybinding
(use-package smex
  :ensure t
  :bind
  (("M-x" . 'smex)
   ("M-X" . 'smex-major-mode-commands)
   ("C-c C-c M-x" . 'execute-extended-command)))

;; which key settings
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom))

;; transpose-frame
(use-package transpose-frame
  :ensure t
  :bind
  (("C-z C-t t" .  'transpose-frame)
   ("C-z C-t f" .  'flip-frame)
   ("C-z C-t F" .  'flop-frame)
   ("C-z C-t C-r" .  'rotate-frame)
   ("C-z C-t r" .  'rotate-frame-anti-clockwise)
   ("C-z C-t R" .  'rotate-frame-clockwise)))

;; treemacs settings
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "<escape> e") #'treemacs-select-window))
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
          treemacs-show-hidden-files               nil
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
        ("<escape> t 0"   . treemacs-select-window)
        ("<escape> t 1"   . treemacs-delete-other-windows)
        ("<escape> t t"   . treemacs)
        ("<escape> t B"   . treemacs-bookmark)
        ("<escape> t C-t" . treemacs-find-file)
        ("<escape> t M-t" . treemacs-find-tag)))

;; (use-package treemacs-evil
;;   :after (treemacs evil)
;;   :ensure t)

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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#a1efe4" "#fcfcfa"])
 '(ansi-term-color-vector
   [unspecified "#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#a1efe4" "#fcfcfa"] t)
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face 'default)
 '(custom-enabled-themes '(gruvbox-dark-medium))
 '(custom-safe-themes
   '("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "73312750a0ce791489cad7fe2579d8582ea44d6dfcde274cb07c763277706a22" "4ad8e0bac03a34fdaf4a4f1e2d8bbca999d4d83410949b7e67335d2eac628b85" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" "bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "3325e2c49c8cc81a8cc94b0d57f1975e6562858db5de840b03338529c64f58d1" "d0ebd553aa00983952185f9d0e1a004967614d7c75fc8547f1b9af1f26b77dfc" "c8b83e7692e77f3e2e46c08177b673da6e41b307805cd1982da9e2ea2e90e6d7" "3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" "fb83a50c80de36f23aea5919e50e1bccd565ca5bb646af95729dc8c5f926cbf3" "e3a1b1fb50e3908e80514de38acbac74be2eb2777fc896e44b54ce44308e5330" "b02eae4d22362a941751f690032ea30c7c78d8ca8a1212fdae9eecad28a3587f" "d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" "b6269b0356ed8d9ed55b0dcea10b4e13227b89fd2af4452eee19ac88297b0f99" "24168c7e083ca0bbc87c68d3139ef39f072488703dcdd82343b8cab71c0f62a7" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(fci-rule-color "#3C3D37")
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
   '(cargo cmake-mode nord-theme lice python-black company ace-window texmathp aas rustic nasm-mode ample-theme lua-mode irony yaml-mode rainbow-delimiters ayu-theme magit zenburn-theme clang-format hindent transpose-frame monokai-pro-theme monokai-theme exec-path-from-shell undo-tree which-key nlinum-relative lsp-mode vterm go-mode gruvbox-theme smex))
 '(pdf-view-midnight-colors '("#fdf4c1" . "#282828"))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(tab-width 4)
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
