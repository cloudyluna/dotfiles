;;; .quick-emacs.el --- minimal and fast init file for emacs as a git commit
;;; editor.

(load-theme 'tango-dark t)
(setq lexical-binding t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq-default indent-tabs-mode nil)
(setq column-number-mode t)
(global-display-line-numbers-mode)
(display-fill-column-indicator-mode)
(setopt display-fill-column-indicator 80)

;;; .quick-emacs.el ends here
