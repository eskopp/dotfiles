;; Load bundled Nord theme relative to this init.el
(let ((theme-dir (expand-file-name
                  "themes/"
                  (file-name-directory (or load-file-name user-init-file)))))
  (add-to-list 'custom-theme-load-path theme-dir))

(setq nord-region-highlight "frost")
(setq nord-uniform-mode-lines t)

(load-theme 'nord t)

(global-hl-line-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)
(column-number-mode 1)

(setq visible-bell t)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil)
(setq auto-save-default nil)

(set-face-attribute 'default nil :height 120)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
