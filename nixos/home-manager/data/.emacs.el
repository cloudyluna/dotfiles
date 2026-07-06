;;; -*- lexical-binding: t; -*-

(defun setup-basic-configurations ()
  "Setup all needed *basic* configurations for minimal Emacs usage.

  Of course, it's personally opinionated to me.
  "
  (require 'cl-lib)
  (setq-default indent-tabs-mode nil)
  (setq column-number-mode t)
  (global-display-line-numbers-mode)
  (xterm-mouse-mode 1) ;; Enable mouse support in the terminal.

  (global-unset-key (kbd "C-x C-+"))
  (global-unset-key (kbd "C-x C--"))
  (global-unset-key (kbd "C-x C-="))
  (global-set-key (kbd "<C-wheel-up>") 'ignore)
  (global-set-key (kbd "<C-wheel-down>") 'ignore)
  (global-set-key (kbd "<pinch>") 'ignore)

  
  (setq ring-bell-function 'ignore) ; shush the annoying bell sound


  (setq make-backup-files nil) ; stop creating ~ files
  (setq create-lockfiles nil)
  (setq use-short-answers t)
  (setq make-pointer-invisible t)

  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture)

  (set-face-attribute 'default nil :height 120)

  (tool-bar-mode -1)
  (menu-bar-mode -1)

  (add-hook 'text-mode #'display-fill-column-indicator-mode)
  (add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
  (setopt display-fill-column-indicator-column 100)

  (load-theme 'modus-vivendi t))

(setup-basic-configurations)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; my preferred elisp libraries

(use-package dash
  :ensure t
  :config (global-dash-fontify-mode))

(use-package diminish :ensure t)

(use-package ivy :ensure t)

(use-package counsel :ensure t)

(use-package swiper
  :ensure t
  :diminish ivy-mode
  :bind (("C-s" . swiper)
         ("C-c C-r" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-M-i" . complete-symbol)
         ("C-." . counsel-imenu)
         ("C-c 8" . counsel-unicode-char)
         ("C-c v" . ivy-push-view)
         ("C-c V" . ivy-pop-view)
         ("M-y" . counsel-yank-pop))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d "))

(use-package yaml :ensure t :defer t)

(use-package nix-mode :ensure t :defer t)

(use-package lua-mode :ensure t :defer t)

(use-package sly :ensure t :defer t)

(defun augment-vterm ()
  (setq display-line-numbers nil))

;; requires libvterm, cmake and libtool
(use-package vterm
  :ensure t
  :config
  (define-key vterm-mode-map (kbd "C-q") #'vterm-send-next-key)
  (advice-add
   'vterm
   :filter-return
   #'augment-vterm))

(use-package multi-vterm
  :ensure t
  :config (advice-add 'multi-vterm :filter-return #'augment-vterm))

(use-package treemacs
  :ensure t
  :defer t
  :bind (:map global-map ("C-x t t" . treemacs)))

(use-package projectile-ripgrep
  :ensure t
  :after (projectile))

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile))

(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))

(use-package projectile
  :ensure t
  :defer t
  :bind ("C-c p" . projectile-command-map))

(use-package magit
  :ensure t
  :defer t)

(use-package diff-hl
  :ensure t
  :after magit
  :config
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode))

(use-package vlf
  :ensure t
  :config
  (require 'vlf-setup))

(use-package direnv
  :ensure t
  :config
  (direnv-mode))

(use-package company
  :ensure t
  :config (add-hook 'after-init-hook 'global-company-mode))

(use-package move-text
  :ensure t
  :defer t
  :config (move-text-default-bindings))

(use-package restart-emacs
  :ensure t)

;; LSP/EGLOT/Programming env
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c C-l"
        lsp-inlay-hint-enable t)
  :custom
  (lsp-lens-enable nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  ;; enable / disable the hints as you prefer:
  (lsp-inlay-hint-enable t)
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  (lsp-signature-auto-activate t)
  
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (rustic-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-ui-mode)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package ultra-scroll
  :ensure t
  :after lsp-mode
  :init
  (setq scroll-conservatively 3
        scroll-margin 0))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :after lsp-mode
  :custom
  (lsp-ui-peek-always-show nil)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc-enable t)
  (ultra-scroll-mode 1))

(use-package rustic
  :ensure t
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-to-list 'direnv-non-file-modes 'rustic-mode))

(use-package haskell-mode
  :ensure t)

(use-package lsp-haskell :ensure t
  :after (lsp-mode))

(use-package flymake :ensure t
  :defer t)

(use-package flymake-shellcheck
  :ensure t
  :after flymake
  :init (add-hook 'sh-mode-hook 'flymake-shellcheck-load))

(use-package org-roam :ensure t
  :defer t)

(use-package ox-gfm :ensure t
  :after org-mode)

(use-package format-all
  :ensure t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("Nix" nixfmt) ("C" clang-format) ("C++" clang-format))))
