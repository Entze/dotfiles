
(setq-default fill-column 80)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(global-set-key (kbd "C-c q") 'auto-fill-mode)

(load "~/.emacs.d/haskell.el")
