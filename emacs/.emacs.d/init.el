(use-package package)
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

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
  '(auctex auto-complete evil haskell-mode idea-darkula-theme iso-transl org org-bullets ox-md sass-mode typescript-mode undo-tree use-package) 
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-file "~/.emacs.d/opt/sensible-defaults.el")
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
