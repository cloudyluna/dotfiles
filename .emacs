(defun setup-basic-configurations ()
  "Setup all needed *basic* configurations for minimal Emacs usage.

  Of course, it's personally opinionated to me.
  "
  (setq lexical-binding t)
  (require 'cl-lib)
  (setq-default indent-tabs-mode nil)
  (setq column-number-mode t)
  (global-display-line-numbers-mode)

                                        
  (setq ring-bell-function 'ignore) ; shush the annoying bell sound


  (setq make-backup-files nil) ; stop creating ~ files
  (setq create-lockfiles nil)

  (set-face-attribute 'default nil :height 120)

  (tool-bar-mode -1)
  (menu-bar-mode -1)

  (add-hook 'text-mode #'display-fill-column-indicator-mode)
  (add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
  (setopt display-fill-column-indicator-column t)
  (setq default-directory (format "%s/workspace/" (getenv "HOME"))))

(setup-basic-configurations)


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(inhibit-startup-screen t)
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; my preferred elisp libraries

(use-package dash :ensure dash
  :config (global-dash-fontify-mode))

;; 

(use-package smex
  :ensure smex
  :bind
  ("M-x" . 'smex)
  ("M-X" . 'smex-major-mode-commands)
  ("C-c C-c M-x" . 'execute-extended-command))
(use-package yaml :ensure yaml)
(use-package nix-mode :ensure nix-mode)
(use-package sly :ensure sly)


(defun augment-vterm (x)
  (message "%s" "Warning: this command has been \"advised\" in $HOME/.emacs")
  (setq display-line-numbers nil))

;; requires libvterm, cmake and libtool
(use-package vterm :ensure vterm
  :config
  (define-key vterm-mode-map (kbd "C-q") #'vterm-send-next-key)
  (advice-add
   'vterm
   :filter-return
   #'augment-vterm))
(use-package multi-vterm :ensure multi-vterm
  :config (advice-add 'multi-vterm :filter-return #'augment-vterm))
(defconst +prog-mode-hooks+
  '(rust-mode-hook
    haskell-mode-hook
    sh-mode-hook
    c-mode-hook
    c++-mode-hook))
(use-package neotree :ensure neotree)
(use-package projectile
  :ensure projectile
  :config
  (use-package projectile-ripgrep :ensure projectile-ripgrep)
  (use-package projectile-codesearch :ensure projectile-codesearch)
  :bind ("C-c p" . projectile-command-map))
(use-package helm-swoop :ensure helm-swoop
  :bind ("M-i" . helm-swoop))
(use-package magit :ensure magit)
(use-package smartparens
  :ensure smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))
(use-package nyan-mode
  :ensure nyan-mode
  :config
  (nyan-mode))
(use-package vlf
  :ensure vlf
  :config
  (require 'vlf-setup))
(use-package direnv
  :ensure direnv
  :config
  (direnv-mode))
(use-package company
  :ensure company
  :config (add-hook 'after-init-hook 'global-company-mode))
(use-package move-text :ensure move-text
  :defer t
  :config (move-text-default-bindings))
(use-package restart-emacs :ensure restart-emacs)
(use-package elpher :ensure elpher :defer t)

;; LSP/EGLOT/Programming env
(use-package rustic :ensure rustic
  :config
  (add-hook 'before-save-hook #'rustic-format-file)
  (add-to-list 'direnv-non-file-modes 'rustic-mode))
(use-package haskell-mode :ensure haskell-mode)
(use-package lsp-haskell :ensure lsp-haskell)
(use-package flymake-shellcheck
  :ensure flymake-shellcheck
  :init (add-hook 'sh-mode-hook 'flymake-shellcheck-load)
  :config (use-package flymake :ensure flymake))
(use-package clang-format
  :ensure clang-format
  :config
  (setq clang-format-style "file")
  (setq clang-format-fallback-style "Microsoft")
  (add-hook 'c++-mode-hook #'clang-format-on-save-mode)
  (add-hook 'c-mode-hook #'clang-format-on-save-mode))
