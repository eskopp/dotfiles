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


;; Dotfiles Nord polish
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq nord-uniform-mode-lines t)
(setq nord-region-highlight "frost")

(column-number-mode 1)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)


;; --- Dotfiles startup fix ---
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t
      initial-scratch-message nil
      vc-follow-symlinks t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (when (get-buffer "*GNU Emacs*")
              (kill-buffer "*GNU Emacs*"))
            (delete-other-windows)))

;; Dotfiles startup cleanup
(setq vc-follow-symlinks t
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t
      initial-scratch-message nil)

(defun esk/cleanup-startup-buffer ()
  (when (get-buffer "*GNU Emacs*")
    (kill-buffer "*GNU Emacs*")
    (delete-other-windows)))

(add-hook 'find-file-hook #'esk/cleanup-startup-buffer)

;; Late startup cleanup
(defun esk/late-startup-cleanup ()
  (run-with-idle-timer
   0 nil
   (lambda ()
     (let ((buf (get-buffer "*GNU Emacs*")))
       (when buf
         (dolist (win (get-buffer-window-list buf nil t))
           (quit-window nil win))
         (kill-buffer buf)))
     (when (> (count-windows) 1)
       (delete-other-windows)))))

(add-hook 'window-setup-hook #'esk/late-startup-cleanup)

;; Force single window startup
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t
      initial-scratch-message nil
      vc-follow-symlinks t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (delete-other-windows)))

;; --- Nord README look ---
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (pkg '(nord-theme powerline))
  (unless (package-installed-p pkg)
    (package-install pkg)))

(setq vc-follow-symlinks t
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t
      initial-scratch-message nil
      nord-region-highlight "frost"
      nord-uniform-mode-lines t)

;; Opaque instead of transparent
(add-to-list 'default-frame-alist '(alpha-background . 100))
(add-to-list 'default-frame-alist '(alpha . (100 . 100)))

(load-theme 'nord t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)
(column-number-mode 1)

(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 140)

(require 'powerline)
(powerline-default-theme)

(add-hook 'emacs-startup-hook
          (lambda ()
            (when (> (count-windows) 1)
              (delete-other-windows))
            (when (get-buffer "*GNU Emacs*")
              (kill-buffer "*GNU Emacs*"))))

;; one-window-after-file
(setq vc-follow-symlinks t
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t
      initial-scratch-message nil)

(defun esk/one-window-after-file ()
  (when buffer-file-name
    (when (get-buffer "*GNU Emacs*")
      (kill-buffer "*GNU Emacs*"))
    (delete-other-windows)
    (remove-hook 'find-file-hook #'esk/one-window-after-file)))

(add-hook 'find-file-hook #'esk/one-window-after-file)
;; dotfiles-kill-gnu-emacs-buffer
(add-hook
 'window-setup-hook
 (lambda ()
   (run-with-timer
    0.3 nil
    (lambda ()
      (let ((buf (get-buffer "*GNU Emacs*")))
        (when buf
          (dolist (win (get-buffer-window-list buf nil t))
            (quit-window nil win))
          (kill-buffer buf)))
      (when (> (count-windows) 1)
        (delete-other-windows))))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; --- Pretty start page ---
(defface esk-start-title
  '((t (:inherit default :weight bold :height 2.2)))
  "Face for the start page title.")

(defface esk-start-subtitle
  '((t (:inherit font-lock-comment-face :height 1.25)))
  "Face for the start page subtitle.")

(defface esk-start-key
  '((t (:inherit font-lock-keyword-face :weight bold)))
  "Face for shortcut keys on the start page.")

(defface esk-start-desc
  '((t (:inherit default)))
  "Face for descriptions on the start page.")

(defface esk-start-muted
  '((t (:inherit shadow)))
  "Face for muted text on the start page.")

(defun esk/start-page-center-line (text &optional face)
  (let* ((width (window-width))
         (pad (max 0 (/ (- width (string-width text)) 2))))
    (insert (make-string pad ?\s))
    (insert (if face (propertize text 'face face) text))
    (insert "\n")))

(defun esk/start-page-has-file-buffer-p ()
  (seq-some (lambda (buf)
              (buffer-local-value 'buffer-file-name buf))
            (buffer-list)))

(defun esk/render-start-page ()
  (interactive)
  (let ((buf (get-buffer-create "*start*")))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (fundamental-mode)
        (setq-local cursor-type nil)
        (setq-local mode-line-format mode-line-format)
        (setq-local line-spacing 0.18)
        (display-line-numbers-mode -1)
        (hl-line-mode -1)
        (visual-line-mode 1)

        (insert "\n")
        (esk/start-page-center-line "Erik's Emacs" 'esk-start-title)
        (esk/start-page-center-line "Nord + Vertico + Consult + Corfu" 'esk-start-subtitle)
        (insert "\n")

        (dolist (row '(("C-x C-f" "Open file")
                       ("C-x b"   "Switch buffer")
                       ("C-s"     "Search in buffer")
                       ("C-c f"   "Find file")
                       ("C-c g"   "Ripgrep in project")))
          (esk/start-page-center-line
           (concat
            (propertize (format "%-10s" (car row)) 'face 'esk-start-key)
            (propertize (concat "  " (cadr row)) 'face 'esk-start-desc))))

        (insert "\n")
        (esk/start-page-center-line "config: ~/.emacs.d/init.el" 'esk-start-muted)
        (esk/start-page-center-line "quit:   C-x C-c" 'esk-start-muted)
        (goto-char (point-min))
        (read-only-mode 1))))
  (switch-to-buffer "*start*"))

(add-hook
 'emacs-startup-hook
 (lambda ()
   (unless (esk/start-page-has-file-buffer-p)
     (esk/render-start-page))))
;; --- End pretty start page ---
