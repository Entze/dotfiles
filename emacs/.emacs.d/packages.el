
(require 'package)

(setq package-archives 	'(("org"       . "https://orgmode.org/elpa/")
			  ("gnu"       . "https://elpa.gnu.org/packages/")
			  ("melpa"     . "https://melpa.org/packages/")
			  ("melpa-stable" . "https://stable.melpa.org/packages/"))
      package-archive-priorities
			'(("org"		. 15)
			  ("melpa-stable"	. 10)
			  ("gnu"     		. 5)
			  ("melpa"        	. 0)))

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(package-initialize)

;; Bootstrap use-package

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; changes the behaviour of (use-package X) so that it is always installed if not already installed
(setq-default use-package-always-ensure t)

(unless package-archive-contents
  (ignore-errors (package-refresh-contents)))

(use-package diminish)
