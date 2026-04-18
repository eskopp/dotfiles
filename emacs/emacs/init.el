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
(require 'calendar)
(require 'seq)

(defconst esk/start-page--month-names
  ["Januar" "Februar" "März" "April" "Mai" "Juni"
   "Juli" "August" "September" "Oktober" "November" "Dezember"])

(defconst esk/start-page--calendar-width 20)

(defface esk-start-title
  '((t (:inherit default :weight bold :height 1.45 :foreground "#ECEFF4")))
  "Title face for the start page.")

(defface esk-start-subtitle
  '((t (:inherit shadow :height 1.0 :foreground "#81A1C1")))
  "Subtitle face for the start page.")

(defface esk-start-section
  '((t (:inherit default :weight bold :foreground "#88C0D0")))
  "Section title face.")

(defface esk-start-key
  '((t (:inherit default :weight bold :foreground "#8FBCBB")))
  "Shortcut key face.")

(defface esk-start-desc
  '((t (:inherit default :foreground "#D8DEE9")))
  "Shortcut description face.")

(defface esk-start-muted
  '((t (:inherit shadow :foreground "#7B88A1")))
  "Muted helper text.")

(defface esk-start-rule
  '((t (:inherit shadow :foreground "#4C566A")))
  "Separator line face.")

(defface esk-start-calendar-today
  '((t (:inherit default :weight bold :foreground "#2E3440" :background "#88C0D0")))
  "Face for today's date.")

(defun esk/start-page--insert (text &optional face)
  (insert (if face (propertize text 'face face) text) "\n"))

(defun esk/start-page--row (key desc)
  (insert "  ")
  (insert (propertize (format "%-10s" key) 'face 'esk-start-key))
  (insert " ")
  (insert (propertize desc 'face 'esk-start-desc))
  (insert "\n"))

(defun esk/start-page--pad-right (text width)
  (concat text (make-string (max 0 (- width (string-width text))) ? )))

(defun esk/start-page--center (text width &optional face)
  (let* ((raw text)
         (shown (if face (propertize text 'face face) text))
         (left (max 0 (/ (- width (string-width raw)) 2)))
         (right (max 0 (- width left (string-width raw)))))
    (concat (make-string left ? ) shown (make-string right ? ))))

(defun esk/start-page--month-year-offset (month year delta)
  (let* ((total (+ (* year 12) (1- month) delta))
         (new-year (/ total 12))
         (new-month (1+ (mod total 12))))
    (list new-month new-year)))

(defun esk/start-page--calendar-month-lines (month year &optional highlight-day)
  (let* ((width esk/start-page--calendar-width)
         (title (esk/start-page--center
                 (format "%s %d" (aref esk/start-page--month-names (1- month)) year)
                 width
                 'esk-start-section))
         (weekdays (esk/start-page--pad-right
                    (propertize "Mo Di Mi Do Fr Sa So" 'face 'esk-start-muted)
                    width))
         (days-in-month (calendar-last-day-of-month month year))
         (first-dow (calendar-day-of-week (list month 1 year)))
         (offset (mod (- first-dow 1) 7))
         (rows (list title weekdays))
         (day 1))
    (dotimes (_week 6)
      (let ((line ""))
        (dotimes (col 7)
          (let ((cell-index (+ (* _week 7) col)))
            (setq line
                  (concat
                   line
                   (cond
                    ((< cell-index offset) "  ")
                    ((> day days-in-month) "  ")
                    (t
                     (prog1
                         (let ((cell (format "%2d" day)))
                           (if (and highlight-day (= day highlight-day))
                               (propertize cell 'face 'esk-start-calendar-today)
                             cell))
                       (setq day (1+ day)))))
                   (if (< col 6) " " "")))))
        (setq rows (append rows (list (esk/start-page--pad-right line width))))))
    rows))

(defun esk/start-page--insert-calendar ()
  (let* ((now (decode-time (current-time)))
         (today (nth 3 now))
         (month (nth 4 now))
         (year (nth 5 now))
         (prev (esk/start-page--month-year-offset month year -1))
         (next (esk/start-page--month-year-offset month year 1))
         (prev-lines (esk/start-page--calendar-month-lines (car prev) (cadr prev)))
         (curr-lines (esk/start-page--calendar-month-lines month year today))
         (next-lines (esk/start-page--calendar-month-lines (car next) (cadr next)))
         (count (max (length prev-lines) (length curr-lines) (length next-lines))))
    (esk/start-page--insert "Kalender" 'esk-start-section)
    (dotimes (i count)
      (insert "  "
              (esk/start-page--pad-right (or (nth i prev-lines) "") esk/start-page--calendar-width)
              "   "
              (esk/start-page--pad-right (or (nth i curr-lines) "") esk/start-page--calendar-width)
              "   "
              (esk/start-page--pad-right (or (nth i next-lines) "") esk/start-page--calendar-width)
              "\n"))
    (insert "\n")))

(defun esk/start-page-has-file-buffer-p ()
  (seq-some
   (lambda (buf)
     (buffer-local-value 'buffer-file-name buf))
   (buffer-list)))

(defun esk/render-start-page ()
  (interactive)
  (let ((buf (get-buffer-create "*start*")))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (special-mode)
        (setq-local cursor-type nil)
        (setq-local mode-line-format nil)
        (setq-local header-line-format nil)
        (setq-local line-spacing 0.02)
        (setq-local truncate-lines t)
        (setq-local global-hl-line-mode nil)
        (setq-local show-trailing-whitespace nil)
        (face-remap-add-relative 'hl-line '(:background unspecified))
        (display-line-numbers-mode -1)
        (hl-line-mode -1)
        (visual-line-mode -1)

        (esk/start-page--insert "")
        (esk/start-page--insert "Emacs" 'esk-start-title)
        (esk/start-page--insert "Nord • Vertico • Consult • Corfu" 'esk-start-subtitle)
        (esk/start-page--insert "────────────────────────────────────────────────────────" 'esk-start-rule)
        (esk/start-page--insert "")

        (esk/start-page--insert "Navigation" 'esk-start-section)
        (esk/start-page--row "C-x C-f" "Datei öffnen")
        (esk/start-page--row "C-x b"   "Buffer wechseln")
        (esk/start-page--row "C-s"     "Im Buffer suchen")
        (esk/start-page--row "C-c f"   "Datei finden")
        (esk/start-page--row "C-c g"   "Ripgrep im Projekt")
        (esk/start-page--insert "")

        (esk/start-page--insert-calendar)

        (esk/start-page--insert "Config" 'esk-start-section)
        (esk/start-page--row "~/.emacs.d" "aktive Emacs-Konfiguration")
        (esk/start-page--row "C-x C-c"   "Emacs beenden")
        (esk/start-page--insert "")
        (esk/start-page--insert "Tipp: In echter Code-Datei sieht Nord nochmal besser aus." 'esk-start-muted)

        (goto-char (point-min))
        (forward-line 1)
        (read-only-mode 1))))
  (switch-to-buffer "*start*")
  (set-window-margins (selected-window) 2 2))

(add-hook
 'emacs-startup-hook
 (lambda ()
   (unless (esk/start-page-has-file-buffer-p)
     (delete-other-windows)
     (esk/render-start-page))))
;; --- End pretty start page ---


