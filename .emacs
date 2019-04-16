(require 'package)
(add-to-list 'package-archives              
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))   
(add-to-list 'package-archives
       '("melpa" . "https://melpa.org/packages/") t)

;; activate all packages
(package-initialize)

;; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))



;; Do not forget to install these packages
;; apt or pip install jedi autopep8 flake8 ipython importmagic yapf elpa-popup
;; 
;; Define list of packages to install
(defvar myPackages
  '(better-defaults
    use-package
    material-theme
    exec-path-from-shell
    ;;elpy
    pyenv-mode
    yaml-mode
    company
    irony
    company-irony
    rtags
    company-rtags
    ;;flycheck-rtags
    irony-eldoc
    ))



;; install all packages in list
(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; Use shell's $PATH
(exec-path-from-shell-copy-env "PATH")


;; Enable elpy and ipython as promt
(package-initialize)
(elpy-enable)
;;(setq python-shell-interpreter "ipython3")
(setq python-shell-interpreter "python3")

;; Turn on font-lock in all modes that support it
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode t))

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; disable scrollbar-mode
(scroll-bar-mode -1)
(menu-bar-mode 1)
(tool-bar-mode -1)
;; theme
(load-theme 'material t) 

;;move between buffers
(global-set-key (kbd "C-c j ")  'windmove-left)
(global-set-key (kbd "C-c ;") 'windmove-right)
(global-set-key (kbd "C-c k")    'windmove-up)
(global-set-key (kbd "C-c l")  'windmove-down)
(global-set-key (kbd "C-c n")  'other-frame)

;; F1 bound to shell whoah
(global-set-key [f1] 'shell)

;; yaml mode
;;(load-file "~/.emacs.d/yaml-mode/yaml-mode.el")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;Simple promts
(fset 'yes-or-no-p 'y-or-n-p)

(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions)) 
(setq confirm-nonexistent-file-or-buffer nil)

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

;; Ido mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; ;; -------------------- extra nice things --------------------
;; ;; use shift to move around windows
(windmove-default-keybindings 'shift)
(show-paren-mode t)
;;; Turn beep off
(setq visible-bell nil)

;;set indetation level for c c++
(setq-default c-basic-offset 4)

;; Rtags stuff

(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)

(defun setup-flycheck-rtags ()
  (interactive)
  (flycheck-select-checker 'rtags)
  ;; RTags creates more accurate overlays.
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

;; ;; only run this if rtags is installed
;; (when (require 'rtags nil :noerror)
;;   ;; make sure you have company-mode installed
;;   (require 'company)
;;   (define-key c-mode-base-map (kbd "M-.")
;;     (function rtags-find-symbol-at-point))
;;   (define-key c-mode-base-map (kbd "M-,")
;;     (function rtags-find-references-at-point))
;;   ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
;;   ;;(define-key prelude-mode-map (kbd "C-c r") nil)
;;   ;; install standard rtags keybindings. Do M-. on the symbol below to
;;   ;; jump to definition and see the keybindings.
;;   (rtags-enable-standard-keybindings)
;;   ;; comment this out if you don't have or don't use helm
;;   (setq rtags-use-helm t)
;;   ;; company completion setup
;;   (setq rtags-autostart-diagnostics t)
;;   (rtags-diagnostics)
;;   (setq rtags-completions-enabled t)
;;   (push 'company-rtags company-backends)
;;   (global-company-mode)
;;   (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
;;   ;; use rtags flycheck mode -- clang warnings shown inline
;;   (require 'flycheck-rtags)
;;   ;; c-mode-common-hook is also called by c++-mode
;;   (add-hook 'c-mode-common-hook #'setup-flycheck-rtags))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))


(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


(require 'company)
(add-hook 'after-init-hook 'global-company-mode)


(use-package company
:ensure t
:config
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)
(global-company-mode t))

(use-package company-irony
:ensure t
:config
(add-to-list 'company-backends 'company-irony))

(use-package irony
	     :ensure t
	     :config
	     (add-hook 'c++-mode-hook 'irony-mode)
	     (add-hook 'c-mode-hook 'irony-mode)
	     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))



(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(use-package irony-eldoc
:ensure t
:config
(add-hook 'irony-mode-hook #'irony-eldoc))

(use-package company-jedi
	     :ensure t
	     :config
	     (add-hook 'python-mode-hook 'jedi:setup))

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)



(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq copanny-minimum-prefix-lenght 2)
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(setq elpy-rpc-python-command "python3")

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "SPC") #'company-abort))

(use-package company-irony
  :ensure t
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))



(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode))
  :init (setq markdown-command "/usr/local/bin/multimarkdown"))


;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(setq inhibit-splash-screen t) ; Splash screen? Meh.
(global-linum-mode t) ;; enable line numbers globally
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-begin-commands (quote (self-insert-command)))
 '(company-box-enable-icon t)
 '(company-box-icons-alist (quote company-box-icons-icons-in-terminal))
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 2)
 '(company-show-numbers t)
 '(company-tooltip-align-annotations t)
 '(global-company-mode t)
 '(package-selected-packages
   (quote
    (flycheck-rtags company-rtags company-shell markdown-mode yaml-mode use-package pyenv-mode material-theme irony-eldoc exec-path-from-shell elpy company-jedi company-irony-c-headers company-irony company-c-headers better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
