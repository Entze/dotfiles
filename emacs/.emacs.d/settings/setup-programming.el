(use-package php-mode)

(use-package gmpl-mode
  :mode ("\\.mod\\'" . gmpl-mode))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (haskell-mode . lsp)
         (julia-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)


(use-package lsp-ui
  :after (lsp-mode)
  :commands lsp-ui-mode
  :hook (
         (lsp-mode . lsp-ui)
         (lsp-mode . lsp-ui-sideline))
  :config (progn
            (setq lsp-ui-doc-show-with-cursor nil)))

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :commands lsp-treemacs-errors-list
  :config (lsp-treemacs-sync-mode 1))

(use-package lsp-haskell
  :after (lsp-mode))

(use-package haskell-mode
  :mode (("\\.hs\\'" . haskell-mode)
         ("\\.lhs\\'" . haskell-mode))
  )

(use-package lsp-julia
  :after (lsp-mode))

(use-package julia-mode
  :mode ("\\.jl\\'" . julia-mode))

(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

(use-package company
  :pin "elpa"
  :hook (lsp-mode . company))

(use-package dap-mode)

(provide 'setup-programming)
