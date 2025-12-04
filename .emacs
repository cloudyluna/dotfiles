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
 '(package-selected-packages
   '(clang-format company dired-explorer dired-filter dired-sidebar
                  direnv elfeed  elgrep elpher
                  fennel-mode flycheck flymake-shellcheck haskell-mode
                  helm-swoop jsonrpc lsp-haskell lua-mode magit
                  move-text multi-vterm neotree nickel-mode nix-mode
                  nyan-mode projectile-codesearch projectile-ripgrep
                  restart-emacs rustic sly smartparens smex vlf yaml
                  yaml-mode)))
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
(use-package lua-mode :ensure lua-mode)
(use-package fennel-mode :ensure fennel-mode)
(use-package sly :ensure sly)
(use-package elfeed :ensure elfeed)


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
