(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Install Packages
(setq package-list '(
		     all-the-icons
		     company
		     ;;flycheck
		     ;;posframe
		     aas
		     ace-window
		     ansi-color
		     auto-complete
		     doom-modeline
		     doom-themes
		     exec-path-from-shell
		     ivy
		     lsp-mode
		     lsp-ui
			 magit
		     multiple-cursors
		     nlinum-relative
		     rainbow-delimiters
		     smex
		     treemacs
		     undo-tree
		     vterm
		     yasnippet
		     ;; language modes
		     go-mode
		     haskell-mode
			 nim-mode
		     tuareg
		     rust-mode
		     zig-mode))

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
(recentf-mode 1)
(setq warning-minimum-level :emergency)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(set-frame-font "JetbrainsMono Nerd Font 14" nil t)
(setq backup-directory-alist '(("." . "~/.emacs_saves")))
(setenv "LANG" "en_US.UTF-8")
;;(setq-default cursor-type 'bar)
(setq nlinum-relative-mode t)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(setq-default indent-tab-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq help-window-select t)
(if (eq system-type 'darwin)
  (progn (setq mac-command-modifier 'meta)
	     (setq mac-option-modifier 'super)
	     (setq mac-control-modifier 'control)
	     (setq ns-function-modifier 'hyper)))

(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "[%d/%d] ")

;; load themes
(require 'doom-themes)
(setq doom-themes-enable-bold t)
(setq doom-themes-enable-italic t)
(load-theme 'doom-moonlight t)
(doom-themes-visual-bell-config)
(doom-themes-neotree-config)
(setq doom-themes-treemacs-theme "doom-atom")
(doom-themes-treemacs-config)
(doom-themes-org-config)

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

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

;; movement keys
(global-set-key (kbd "<M-left>")		'left-word)
(global-set-key (kbd "<M-right>")		'right-word)
(global-set-key (kbd "<M-up>")			'backward-list)
(global-set-key (kbd "<M-down>")		'forward-list)
(global-set-key (kbd "<C-left>")		'move-beginning-of-line)
(global-set-key (kbd "<C-right>")		'move-end-of-line)
(global-set-key (kbd "<M-S-left>")		'backward-chunk)
(global-set-key (kbd "<M-S-right>")		'forward-chunk)

;; define new keybindings
(global-set-key (kbd "<C-return>")		'add-newline-at-top)
(global-set-key (kbd "<M-return>")		'add-newline-at-bottom)
(global-set-key (kbd "C-%")				'quoted-insert)
(global-set-key (kbd "C-S-\\")   		'toogle-input-method)
(global-set-key (kbd "C-S-s")			'isearch-backward)
(global-set-key (kbd "C-\\")			'add-newline-at-top)
(global-set-key (kbd "C-c /")			'comment-line)
(global-set-key (kbd "C-c SPC")			'exchange-point-and-mark)
(global-set-key (kbd "C-q C-e")			'query-replace-regexp-eval)
(global-set-key (kbd "C-q a")			'query-replace-read-args)
(global-set-key (kbd "C-q e")			'query-replace-regexp)
(global-set-key (kbd "C-q r")			'query-replace)
(global-set-key (kbd "C-x .")			'find-file)
(global-set-key (kbd "C-x /")			'comment-line)
(global-set-key (kbd "C-x C-.")			'recentf-open-files)
(global-set-key (kbd "C-x C-/ /")		'comment-region)
(global-set-key (kbd "C-x C-/ i")		'comment-indent)
(global-set-key (kbd "C-x C-f")			'set-fill-prefix)
(global-set-key (kbd "C-x C-o C-t")		'vterm-other-window)
(global-set-key (kbd "C-x C-o C-v")		'vterm)
(global-set-key (kbd "C-x C-x")			'set-mark-command)
(global-set-key (kbd "C-x o")			'ace-window)
(global-set-key (kbd "C-x t l")			'tab-list)
(global-set-key (kbd "C-x x")			'mark-word)
(global-set-key (kbd "C-z C-c")			'recompile)
(global-set-key (kbd "C-z c")			'compile)
(global-set-key (kbd "C-z e")			'eval-expression)
(global-set-key (kbd "C-z g")			'magit)
(global-set-key (kbd "C-z /")			'comment-box)
(global-set-key (kbd "M-W")				'kill-region)
(global-set-key (kbd "M-\\")			'add-newline-at-bottom)

;; define ESC related keybindings (ESC-t is the prefix of the tremacs)
(global-set-key (kbd "<escape> c")		'compile)
(global-set-key (kbd "<escape> e")		'eval-expression)
(global-set-key (kbd "<escape> o")		'overwrite-mode)
(global-set-key (kbd "<escape> b r")	'revert-buffer)

;; define C-ESC related keybindings
(global-set-key (kbd "<C-escape>") 'universal-argument)

;; reset key in tex mode
(eval-after-load "tex"
  '(define-key tex-mode-map (kbd "<C-return>")	'add-newline-at-top))
(eval-after-load "tex"
  '(define-key tex-mode-map (kbd "<M-return>")	'add-newline-at-bottom))

;; finished keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Language Configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TeX configuration
(defun tex-configs ()
  (local-set-key (kbd "<C-S-return>")	'tex-feed-input)
  (local-set-key (kbd "<C-return>")		'add-newline-at-top)
  (local-set-key (kbd "<M-return>")		'add-newline-at-bottom))

(add-hook 'tex-mode 'tex-configs)

;; Rust configuration
(require 'rust-mode)
(setq rust-format-on-save t)

;;;;;;;;;;;;;;;;;;;;;;
;; package settings ;;
;;;;;;;;;;;;;;;;;;;;;;
(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-background nil)

(require 'aas)
(add-hook 'latex-mode 'aas.activate-for-major-mode)
(add-hook 'tex-mode 'aas.activate-for-major-mode)
(aas-set-snippets 'tex-mode
	"MK"  (lambda () (interactive)
		    (yas-expand-snippet "\\$$1\\$$0"))
	:cond #'texmathp ; expand only while in math
    "//" (lambda () (interactive)
           (yas-expand-snippet "{$1 \\over $2}$0")))
(aas-set-snippets 'latex-mode
	"MK"  (lambda () (interactive)
		    (yas-expand-snippet "\\$$1\\$$0"))
	:cond #'texmathp ; expand only while in math
    "//" (lambda () (interactive)
           (yas-expand-snippet "\\frac{$1}{$2}$0")))
;; disable snippets by redefining them with a nil expansion
(aas-set-snippets 'latex-mode
    "supp" nil)

(require 'multiple-cursors)
(global-set-key (kbd "<C-m> C-l") 'mc/edit-lines)
(global-set-key (kbd "<C-m> C-a") 'mc/mark-all-like-this)
(global-set-key (kbd "<C-down>") 'mc/mark-next-like-this)
(global-set-key (kbd "<C-up>") 'mc/mark-previous-like-this)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

(require 'doom-modeline)
(unless (package-installed-p 'doom-modeline)
	(all-the-icons-install-fonts))
(doom-modeline-mode 1)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'nlinum-relative)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)
(setq nlinum-relative-offset 0)

(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
(global-set-key (kbd "C-x C-/") 'undo-tree-redo)

(require 'yasnippet)
(yas-global-mode 1)
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(setq yas-snippet-dirs '("~/.emacs.local/snippets"))
(define-key yas-minor-mode-map (kbd "TAB") nil)

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t)))
  (ansi-color-apply-on-region (point-min) (point-max)))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "C-x \\") #'treemacs-select-window))
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
        ("<escape> t 0"		.	treemacs-select-window)
        ("<escape> t 1"		.	treemacs-delete-other-windows)
        ("<escape> t t"		.	treemacs)
		("C-x \\"			.	treemacs)
        ("<escape> t B"		.	treemacs-bookmark)
        ("<escape> t C-t"	.	treemacs-find-file)
        ("<escape> t M-t"	.	treemacs-find-tag)))
