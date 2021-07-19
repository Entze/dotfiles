;; Use 80 characters as width
(setq-default fill-column 80)

;; Never use tabs
(set-default 'indent-tabs-mode nil)

;; Highlight and cleanup redundant whitespace.
(use-package whitespace
  :diminish (global-whitespace-mode
             whitespace-mode
             whitespace-newline-mode)
  :commands (whitespace-bufffer
             whitespace-cleanup
             whitespace-mode
             whitespace-turn-off)
  :config
  (setq whitespace-line-column nil ;; use `fill-column' instead
        whitespace-action '(auto-cleanup untabify)
        whitespace-style '(face trailing tabs lines empty indentation tab-mark))
  :init
  (add-hook 'find-file-hook #'whitespace-mode))

(set-default 'indicate-empty-lines t)

;; Make selection work as you'd expect.
(delete-selection-mode -1)
(transient-mark-mode 1)

;; Show the matching closing/opening parenthesis
(use-package paren
  :delight
  :config
  (show-paren-mode 1))

(use-package highlight-indentation
  :delight
  :hook (prog-mode . highlight-indentation-mode))

;; Display colors in their respective color e.g. #EEAB02
(use-package rainbow-mode
  :delight
  :pin "elpa"
  :commands rainbow-mode
  :hook ((prog-mode . rainbow-mode)
         (text-mode . rainbow-mode)
         ))

;; color parenthesis in different colors
(use-package rainbow-delimiters
  :delight
  :hook (prog-mode . rainbow-delimiters-mode))

;; Don't use any symbols/litegatures for text
(setq prettify-symbols-alist nil)

(use-package undo-tree
  :pin "elpa"
  :after (evil)
  :config
  (global-undo-tree-mode)
  (evil-set-undo-system 'undo-tree)
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist `(("." . ,(concat user-emacs-directory "/undo"))))
  )

(use-package which-key
  :config (which-key-mode)
  )

;; Move cursor visually
;; This makes a difference on wrapped lines.
;; https://emacs.stackexchange.com/a/8031
(setq line-move-visual t)


(provide 'setup-editor)
