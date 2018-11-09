;; Update package-archive lists
(require 'package)
(add-to-list 'load-path "~/.emacs.d/lisp")

(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; Install 'use-package' if necessary
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
  (require 'use-package))


;;; init-use-package.el ends here(require 'package)



(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;(add-to-list 'load-path "~/.emacs.d/lisp") ;; tell where to load the various files
;; (require 'sr-speedbar)
;; (sr-speedbar-open)


;; Turn on font-lock in all modes that support it
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode t))

(define-key function-key-map "\e[4~" [end])
(global-set-key [META] 'end-of-meta) 
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(company-auto-complete (quote (quote company-explicit-action-p)))
 ;; '(company-auto-complete-chars (quote (32 95 41 46)))
 ;; '(company-tooltip-margin 4)
 ;; '(show-paren-mode t)
 ;; '(speedbar-default-position (quote right))
 ;; '(speedbar-directory-button-trim-method (quote trim))
(tool-bar-mode -1)
 ;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;;((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 140 :width normal))))
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
;;(load-theme 'tango-dark t)
;;x(set-background-color "#1D1D24")

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; disable scrollbar-mode
(scroll-bar-mode -1)
(menu-bar-mode 1) ;; (menu-bar-mode -1) if you want to disable
;;What is SrSpeedbar?
;;embedded speedbar

;;move between buffers
(global-set-key (kbd "C-c j ")  'windmove-left)
(global-set-key (kbd "C-c ;") 'windmove-right)
(global-set-key (kbd "C-c k")    'windmove-up)
(global-set-key (kbd "C-c l")  'windmove-down)
(global-set-key (kbd "C-c n")  'other-frame)

;; (add-hook 'python-mode-hook
;; 	  (function lambda ()
;; 		   (setq indent-tabs-mode t)
;; 		   (setq tab-width 4)
;; 		   (setq python-indent 8)))

;; F1 bound to shell whoah
(global-set-key [f1] 'shell)


;; yaml mode
;;(load-file "~/.emacs.d/yaml-mode/yaml-mode.el")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; package 
;; update



;; (when (>= emacs-major-version 24)
;;   (require 'package)
;;   (add-to-list
;;    'package-archives
;;    '("melpa" . "http://melpa.org/packages/")
;;    t)
;;   (package-initialize))



;;Disabling Prompts in Emacs
(fset 'yes-or-no-p 'y-or-n-p)
;;
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions)) 
(setq confirm-nonexistent-file-or-buffer nil)

;; python auto comlete 
;; Setup and Install
;; -----------------
;; Before using this package, you may need to download and install the
;; necessary Info files::
;;     wget https://bitbucket.org/jonwaltman/pydoc-info/downloads/python.info.gz
;;     gunzip python.info
;;     sudo cp python.info /usr/share/info
;;     sudo install-info --info-dir=/usr/share/info python.info
;;(add-to-list 'load-path "~/.emacs.d/pydoc-info/")
;;(require 'pydoc-info)
;;(define-key read-expression-map [(tab)] 'hippie-expand)

;; folow .log files like tail -f
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

 (setq c-default-style "user"
          c-basic-offset 4)
;; M-x load-file <ENTER> ~/.emacs <ENTER> . reload this file
;; tramp settings 

(setq password-cache-expiry nil)
;; Hide splash-screen and startup-message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(defun toggle-full-screen-and-bars ()
  "Toggles full-screen mode and bars."
  (interactive)
  (toggle-fullscreen))

;; Use F11 to switch between windowed and full-screen modes
(global-set-key [f11] 'toggle-full-screen-and-bars)

(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))





;; ;; -------------------- extra nice things --------------------
;; ;; use shift to move around windows
(windmove-default-keybindings 'shift)
 (show-paren-mode t)
;;  ; Turn beep off
;; (setq visible-bell nil)


;; ;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; ;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; ;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (load-file "~/.emacs.d/emacs-for-python/epy-init.el")

;; (add-to-list 'load-path "~/.emacs.d/emacs-for-python/") ;; tell where to load the various files
;; (require 'epy-setup)      ;; It will setup other loads, it is required!
;; (require 'epy-python)     ;; If you want the python facilities [optional]
;; (require 'epy-completion) ;; If you want the autocompletion settings [optional]
;; (require 'epy-editing)    ;; For configurations related to editing [optional]
;; (require 'epy-bindings)   ;; For my suggested keybindings [optional]
;; (require 'epy-nose)       ;; For nose integration


;; ;; ;; jedi mode
;;(add-hook 'python-mode-hook 'jedi:setup)
;; want help on symbol type <ctrl>h S 
;; (setq jedi:complete-on-dot t)                 ; optional
;; (autoload 'jedi:setup "jedi" nil t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)

;; ;;direx-mode
;; ;;General purpose directory/tree explore

;; ;; (push '(direx:direx-mode :position left :width 25 :dedicated t)
;; ;;       popwin:special-display-config)
;; ;; (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)


;; (add-to-list 'load-path "~/.emacs.d/direx-el/")
;; (require 'direx)
;; (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)


;; (add-to-list 'load-path "~/.emacs.d/emacs-jedi-direx/")

;; (require 'jedi-direx)
;; (eval-after-load "python-mode"
;;   '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))
;; (add-hook 'jedi-mode-hook 'jedi-direx:setup)

;;ido mode
(require 'ido)
(ido-mode t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;interactive do fast mode 
(setq ido-create-new-buffer 'always)
;; prefer in order
(setq ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))

;; ;; (add-to-list 'package-archives
;; ;;              '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; ;; Switch to full-screen mode during startup
;; ;;(toggle-full-screen-and-bars)


;; ;; (when (>= emacs-major-version 24)
;; ;;   (require 'package)
;; ;;   (add-to-list
;; ;;    'package-archives
;; ;;    '("melpa" . "http://melpa.org/packages/")
;; ;;    t)
;; ;;   (package-initialize))

;; (require 'package) ;; You might already have this line
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.org/packages/") t)
;; (when (< emacs-major-version 24)
;;   ;; For important compatibility libraries like cl-lib
;;   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;; (package-initialize) ;; You might already have this line




;; (define-key c++-mode-map (kbd "C-S-<return>") 'ac-complete-clang)
;; (setq company-backends (delete 'company-semantic company-backends))
;; (setq tab-always-indent 'complete)
;; (define-key c-mode-map  [(tab)] 'company-complete)

;; enable auto completion

;; (require 'company)
;; (company-mode 1)
;; (auto-complete-mode 1)

;; (add-hook 'after-init-hook 'global-company-mode)
;; (delete 'company-semantic company-backends)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)



;;set indetation level for c c++
(setq-default c-basic-offset 4)

(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
;; ;; replace C-S-<return> with a key binding that you want

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


;; (require 'company)
;; (add-hook 'after-init-hook 'global-company-mode)

(defcustom mycustom-system-include-paths '("./include/" "/opt/local/include" "/usr/include" )
  "This is a list of include paths that are used by the clang auto completion."
  :group 'mycustom
  :type '(repeat directory)
  )
 
;; (add-to-list 'load-path "~/bin/emacs/auto-complete")
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/bin/emacs/auto-complete/ac-dict")
;; (ac-config-default)
;; (require 'auto-complete-clang)
;; (setq clang-completion-suppress-error 't)
;; (setq ac-clang-flags
;;       (mapcar (lambda (item)(concat "-I" item))
;;               (append
;;                mycustom-system-include-paths
;;                )
;;               )
;;       )
 
(defun my-ac-clang-mode-common-hook()
  (define-key c-mode-base-map (kbd "M-/") 'ac-complete-clang)
  )
 
(add-hook 'c-mode-common-hook 'my-ac-clang-mode-common-hook)


;;source ~/.local/bin/bashmarks.sh
;; (require 'python)

;; (defvar python-last-buffer nil
;;   "Name of the Python buffer that last invoked `toggle-between-python-buffers'")

;; (make-variable-buffer-local 'python-last-buffer)

;; (defun toggle-between-python-buffers ()
;;   "Toggles between a `python-mode' buffer and its inferior Python process

;; When invoked from a `python-mode' buffer it will switch the
;; active buffer to its associated Python process. If the command is
;; invoked from a Python process, it will switch back to the `python-mode' buffer."
;;   (interactive)
;;   ;; check if `major-mode' is `python-mode' and if it is, we check if
;;   ;; the process referenced in `python-buffer' is running
;;   (if (and (eq major-mode 'python-mode)
;;            (processp (get-buffer-process python-buffer)))
;;       (progn
;;         ;; store a reference to the current *other* buffer; relying
;;         ;; on `other-buffer' alone wouldn't be wise as it would never work
;;         ;; if a user were to switch away from the inferior Python
;;         ;; process to a buffer that isn't our current one. 
;;         (switch-to-buffer python-buffer)
;;         (setq python-last-buffer (other-buffer)))
;;     ;; switch back to the last `python-mode' buffer, but only if it
;;     ;; still exists.
;;     (when (eq major-mode 'inferior-python-mode)
;;       (if (buffer-live-p python-last-buffer)
;;            (switch-to-buffer python-last-buffer)
;;         ;; buffer's dead; clear the variable.
;;         (setq python-last-buffer nil)))))

;; (define-key inferior-python-mode-map (kbd "<f12>") 'toggle-between-python-buffers)
;; (define-key python-mode-map (kbd "<f12>") 'toggle-between-python-buffers)


;; (defun run-python-once ()
;;   (remove-hook 'python-mode-hook 'run-python-once)
;;   (run-python))

;; (add-hook 'python-mode-hook 'run-python-once)


;; (defvar server-buffer-clients)
;; (when (and (fboundp 'server-start) (string-equal (getenv "TERM") 'xterm))
;;   (server-start)
;;   (defun fp-kill-server-with-buffer-routine ()
;;     (and server-buffer-clients (server-done)))
;;   (add-hook 'kill-buffer-hook 'fp-kill-server-with-buffer-routine))


;; ;;autocomplete jedi
;; (defun my/python-mode-hook ()
;;   (add-to-list 'company-backends 'company-jedi))

;; (add-hook 'python-mode-hook 'my/python-mode-hook)


;; (set-face-background 'ac-candidate-face "lightgray")
;; (set-face-underline 'ac-candidate-face "darkgray")
;; (set-face-background 'ac-selection-face "steelblue")
;; (setq ac-menu-height 20)
;; (ac-config-default)
 

;; Standard package.el + MELPA setup
;; (See also: https://github.com/milkypostman/melpa#usage)
;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (package-initialize)


;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------


(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    material-theme
    helm
    powerline
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(setq inhibit-splash-screen t) ; Splash screen? Meh.
;;(global-linum-mode t) ;; enable line numbers globally



(setq auto-mode-alist
      (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("SConscript" . python-mode) auto-mode-alist))

 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-term-color-vector
   [unspecified "#212121" "#f07178" "#c3e88d" "#ffcb6b" "#82aaff" "#c792ea" "#82aaff" "#eeffff"])
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("196df8815910c1a3422b5f7c1f45a72edfa851f6a1d672b7b727d9551bb7c7ba" default)))
 '(package-selected-packages
   (quote
    (sr-speedbar yaml-mode virtualenv use-package-ensure-system-package swiper python-mode py-autopep8 processing-mode powerline platformio-mode paredit nyan-mode melpa-upstream-visit material-theme list-packages-ext irony-eldoc ini-mode helm go-play go-mode flycheck fireplace elpy date-field company-arduino better-defaults base16-theme avy ac-clang ac-capf))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


