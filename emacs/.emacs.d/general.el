(setq default-directory "~/")

;; allow dead-keys
(require 'iso-transl)

;; Give a bit more memory before garbage collecting
(setq gc-cons-threshold 16777216)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; CamelCase words are considered seperate words
(add-hook 'prog-mode-hook 'subword-mode)

(setq vc-follow-symlinks t)

;; Make scripts executable per default
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(setq sentence-end-double-space nil)

;; Ask to create directory if it does not exist
(add-hook 'before-save-hook
            (lambda ()
              (when buffer-file-name
                (let ((dir (file-name-directory buffer-file-name)))
                  (when (and (not (file-exists-p dir))
                             (y-or-n-p (format "Directory %s does not exist. Do you want to create it?" dir)))
                    (make-directory dir t))))))


(transient-mark-mode t)

(delete-selection-mode t)

(setq require-final-newline t)

(setq confirm-kill-emacs 'y-or-n-p)

(setq inhibit-startup-message t)

(setq initial-scratch-message nil)

(setq-default dired-listing-switches "-alh")

(fset 'yes-or-no-p 'y-or-n-p)

;; Syntax Highlighting on if possible
(global-font-lock-mode t)

;; Auto refresh file if changed
(global-auto-revert-mode t)

(show-paren-mode t)
(setq show-paren-delay 0.0)

;; Make 80 chars the default column width
(setq-default fill-column 80)

(setq ns-pop-up-frames nil)

;; Insert at point not at mouse cursor
(setq mouse-yank-at-point t)

(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)

(defun reset-text-size ()
  (interactive)
  (text-scale-set 0))

(define-key global-map (kbd "C-)") 'reset-text-size)
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C-_") 'text-scale-decrease)
(define-key global-map (kbd "C--") 'text-scale-decrease)


;; Do backups
(setq backup-directory-alist `(("." . "~/.emacs/backup")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(setq vc-make-backup-files t)

(use-package undo-tree
  :diminish                       ;; Don't show an icon in the modeline
  :config
    ;; Always have it on
    (global-undo-tree-mode)

    ;; Each node in the undo tree should have a timestamp.
    (setq undo-tree-visualizer-timestamps t)

    ;; Show a diff window displaying changes between undo nodes.
    (setq undo-tree-visualizer-diff t))

;; start in org-mode
(setq initial-major-mode 'org-mode)
