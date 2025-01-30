;;; .quick-emacs.el --- minimal and fast init file for emacs as a git commit
;;; editor.

(setq lexical-binding t)

(load-theme 'tango-dark t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq-default indent-tabs-mode nil)
(setq column-number-mode t)
(global-display-line-numbers-mode)
(add-hook 'text-mode #'display-fill-column-indicator-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(setopt display-fill-column-indicator 80)
(display-fill-column-indicator-mode)

;;; .quick-emacs.el ends here
