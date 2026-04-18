;; Frame transparency
(add-to-list 'default-frame-alist '(alpha-background . 88))
(add-to-list 'default-frame-alist '(alpha . (88 . 88)))

(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (pkg '(vertico marginalia consult which-key corfu orderless))
  (unless (package-installed-p pkg)
    (package-install pkg)))

(let ((theme-dir
       (expand-file-name
        "themes/"
        (file-name-directory (or load-file-name user-init-file)))))
  (add-to-list 'custom-theme-load-path theme-dir))

(setq nord-region-highlight "frost"
      nord-uniform-mode-lines t)

(load-theme 'nord t)

(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t
      initial-major-mode 'text-mode
      initial-scratch-message nil
      make-backup-files nil
      auto-save-default nil
      create-lockfiles nil
      visible-bell t
      use-short-answers t
      frame-title-format '("%b — Emacs"))

(when (display-graphic-p)
  (catch 'done
    (dolist (font '("FiraCode Nerd Font Mono"
                    "JetBrainsMono Nerd Font Mono"
                    "DejaVu Sans Mono"))
      (when (find-font (font-spec :name font))
        (set-face-attribute 'default nil :font font :height 165)
        (throw 'done t)))))

(setq-default cursor-type 'bar
              line-spacing 0.20)

(global-hl-line-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)
(column-number-mode 1)
(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)

(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'conf-mode-hook #'display-line-numbers-mode)

(require 'vertico)
(vertico-mode 1)

(require 'marginalia)
(marginalia-mode 1)

(require 'which-key)
(which-key-mode 1)
(setq which-key-idle-delay 0.35)

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles partial-completion))))

(require 'corfu)
(global-corfu-mode 1)
(setq corfu-auto t
      corfu-preview-current nil
      corfu-quit-no-match 'separator)

(require 'consult)
(global-set-key (kbd "C-s")   #'consult-line)
(global-set-key (kbd "C-x b") #'consult-buffer)
(global-set-key (kbd "C-c f") #'consult-find)
(global-set-key (kbd "C-c g") #'consult-ripgrep)

(defun erik/start-buffer ()
  (let ((buf (get-buffer-create "*start*")))
    (with-current-buffer buf
      (read-only-mode -1)
      (erase-buffer)
      (setq-local mode-line-format nil)
      (setq-local cursor-type nil)
      (setq-local display-line-numbers nil)
      (text-mode)
      (insert (propertize "Erik's Emacs\n" 'face '(:height 1.7 :weight bold)))
      (insert (propertize "Nord + Vertico + Consult + Corfu\n\n" 'face '(:height 1.05)))
      (insert "  C-x C-f   Open file\n")
      (insert "  C-x b     Switch buffer\n")
      (insert "  C-s       Search in buffer\n")
      (insert "  C-c f     Find file\n")
      (insert "  C-c g     Ripgrep in project\n\n")
      (goto-char (point-min))
      (read-only-mode 1))
    buf))

(setq initial-buffer-choice #'erik/start-buffer)

(set-face-attribute 'mode-line nil :box nil :height 120)
(set-face-attribute 'mode-line-inactive nil :box nil :height 120)

;; --- Nord look fix ---
(setq nord-uniform-mode-lines t)
(setq nord-region-highlight "frost")

(when (require 'package nil t)
  (unless package--initialized
    (package-initialize)))

(unless (package-installed-p 'nord-theme)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'nord-theme))

(load-theme 'nord t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 120)
(setq-default line-spacing 0.15)

;; --- Package setup ---
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; --- Nord look fix ---
(setq nord-uniform-mode-lines t)
(setq nord-region-highlight "frost")

(unless (package-installed-p 'nord-theme)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'nord-theme))

(load-theme 'nord t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 120)
(setq-default line-spacing 0.15)

(setq inhibit-startup-screen t)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(global-hl-line-mode 1)

