(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "marmalade" (concat proto "://marmalade-repo.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")) t)
  (add-to-list 'package-archives (cons "org" (concat proto "://orgmode.org/elpa/")) t))
    

;; Higher values are searched first.
(setq package-archive-priorities
      '(("org"          . 200)
        ("melpa-stable" . 150)
        ("melpa"        . 100)
        ("marmalade"    . 75)
        ("gnu"          . 50)))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(
	auctex
	evil
	haskell-mode
	idea-darkula-theme
	org
	undo-tree
	wc-mode
	) "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-file "~/.emacs.d/opt/sensible-defaults/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/backup-to-temp-directory)

(when window-system
   (load-theme 'idea-darkula t))

(setq org-src-fontify-natively t)

(global-prettify-symbols-mode t)

(when window-system
   (scroll-bar-mode -1))

(when window-system
    (global-hl-line-mode))

(evil-mode 1)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'gfm-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'turn-on-auto-fill)

(add-hook 'haskell-mode-hook
          (lambda ()
            (haskell-doc-mode)
            (turn-on-haskell-indent)
            (ghc-init)))

(eval-after-load "org"
  '(require 'ox-md nil t))

(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))

(add-hook 'org-mode-hook (lambda ()
   (progn
     ;; Snipped
     (auto-fill-mode t)

     ;; Spelling
     (flyspell-mode t))))

(require 'ispell)

(setenv
  "DICPATH"
  "/usr/share/hunspell/")
(setq ispell-program-name "hunspell")


(setq org-export-with-smart-quotes t)

(setq org-latex-pdf-process
'("pdflatex -interaction nonstopmode -output-directory %o %f"
        "biber %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))

(setq-default indent-tabs-mode nil)

(setq-default tab-width 2)

(setq ring-bell-function 'ignore)

(require 'iso-transl)
