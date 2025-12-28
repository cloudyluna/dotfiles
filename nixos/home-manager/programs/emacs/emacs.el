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
  (let* ((*dir* (format "%s/workspace/" (getenv "HOME"))))
    (make-directory *dir* t)
    (setq default-directory *dir*)))

(setup-basic-configurations)

(defconst +elfeed-feeds+
  '(("https://feeds.arstechnica.com/arstechnica/index" general arstechnica tech)
    ("https://news.ycombinator.com/rss" general ycombinator)
    ("https://discourse.nixos.org/c/announcements/8.rss" tech nix nixos programming)
    ("https://discourse.haskell.org/latest.rss" tech haskell programming)
    ("https://www.phoronix.com/rss.php" general phoronix tech)
    ("https://www.theregister.com/software/applications/headlines.atom" tech theregister applications)
    ("https://www.theregister.com/software/devops/headlines.atom" tech theregister devop)
    ("https://www.theregister.com/software/oses/headlines.atom" tech theregister os)
    ("https://www.theregister.com/on_prem/systems/headlines.atom" tech theregister system)
    ("https://www.theregister.com/on_prem/storage/headlines.atom" tech theregister storage)
    ("https://www.theguardian.com/international/rss" general theguardian)
    ("https://reddit.com/r/rust/top/.rss?t=week" tech reddit rust programming)
    ("https://reddit.com/r/haskell/top/.rss?t=week" tech reddit haskell programming)
    ("https://reddit.com/r/linux/top/.rss?t=week" tech reddit linux os)
    ("https://reddit.com/r/nixos/top/.rss?t=week" tech reddit nix nixos programming)
    ("https://hnrss.org/newest?q=linux" tech hackernews linux os)
    ("https://hnrss.org/newest?q=rust" tech hackernews rust programming)
    ("https://hnrss.org/newest?q=haskell" tech hackernews haskell programming)
    ("http://rss.sciam.com/ScientificAmerican-News" science scientificamerican reliable)
    ))


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
 '(elfeed-feeds +elfeed-feeds+)
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
  :config (global-dash-fontify-mode))

(use-package smex
  :bind
  ("M-x" . 'smex)
  ("M-X" . 'smex-major-mode-commands)
  ("C-c C-c M-x" . 'execute-extended-command))
(use-package yaml)
(use-package nix-mode)
(use-package lua-mode)
(use-package sly)
(use-package elfeed)


(defun augment-vterm (x)
  (message "%s" "Warning: this command has been \"advised\" in $HOME/.emacs")
  (setq display-line-numbers nil))

;; requires libvterm, cmake and libtool
(use-package vterm
  :config
  (define-key vterm-mode-map (kbd "C-q") #'vterm-send-next-key)
  (advice-add
   'vterm
   :filter-return
   #'augment-vterm))

(use-package multi-vterm
  :config (advice-add 'multi-vterm :filter-return #'augment-vterm))

(use-package neotree)
(use-package projectile
  :config
  (use-package projectile-ripgrep)
  (use-package projectile-codesearch)
  :bind ("C-c p" . projectile-command-map))
(use-package magit)
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))
(use-package nyan-mode
  :config
  (nyan-mode))
(use-package vlf
  :config
  (require 'vlf-setup))
(use-package direnv
  :config
  (direnv-mode))
(use-package company
  :config (add-hook 'after-init-hook 'global-company-mode))
(use-package move-text
  :defer t
  :config (move-text-default-bindings))
(use-package restart-emacs)
(use-package elpher)

;; LSP/EGLOT/Programming env
(use-package rustic
  :config
  (add-hook 'before-save-hook #'rustic-format-file)
  (add-to-list 'direnv-non-file-modes 'rustic-mode))
(use-package haskell-mode)
(use-package lsp-haskell)
(use-package flymake-shellcheck
  :init (add-hook 'sh-mode-hook 'flymake-shellcheck-load)
  :config (use-package flymake))
(use-package clang-format
  :config
  (setq clang-format-style "file")
  (setq clang-format-fallback-style "Microsoft")
  (add-hook 'c++-mode-hook #'clang-format-on-save-mode)
  (add-hook 'c-mode-hook #'clang-format-on-save-mode))
(use-package surround)
