
(use-package flyspell
  :hook (
           (prog-mode . flyspell-prog-mode)
           (text-mode . flyspell-mode)))

(setq ispell-program-name "/usr/bin/hunspell")
(setq ispell-dictionary "en_GB-large")

(use-package synosaurus)

;; TODO: langtool
