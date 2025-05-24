(setq custom-file "~/.emacs.custom.el")
(package-initialize)

(add-to-list 'load-path "~/.emacs.local/")

(load "~/.emacs.rc/rc.el")

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

