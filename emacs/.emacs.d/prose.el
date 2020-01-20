
(use-package flyspell
  :diminish
  :hook (
           (prog-mode . flyspell-prog-mode)
           (text-mode . flyspell-mode)))

(use-package flyspell-lazy
  :diminish
  :hook (
           (prog-mode . flyspell-lazy-mode)
           (text-mode . flyspell-lazy-mode)))


(use-package markdown-mode)

(setq ispell-program-name "/usr/bin/hunspell")
(setq ispell-dictionary "en_GB-large")

(use-package synosaurus
  :diminish synosaurus-mode
  )

;; TODO: langtool
(use-package langtool
 :config
  (setq langtool-language-tool-jar
     "~/Apps/.bin/languagetool-commandline.jar"))

(use-package wc-mode)
