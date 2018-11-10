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
    material-theme
    exec-path-from-shell
    elpy
    pyenv-mode
    yaml-mode
    irony
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
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")


;;; init-use-package.el ends here(require 'package)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Turn on font-lock in all modes that support it
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode t))

(define-key function-key-map "\e[4~" [end])
(global-set-key [META] 'end-of-meta) 
(tool-bar-mode -1)

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; disable scrollbar-mode
(scroll-bar-mode -1)
(menu-bar-mode 1) 
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
  (define-key Irony-Mode-Map [Remap completion-at-point]
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
 
 
(defun my-ac-clang-mode-common-hook()
  (define-key c-mode-base-map (kbd "M-/") 'ac-complete-clang)
  )
 
(add-hook 'c-mode-common-hook 'my-ac-clang-mode-common-hook)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(setq inhibit-splash-screen t) ; Splash screen? Meh.
;;(global-linum-mode t) ;; enable line numbers globally


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(ansi-term-color-vector
;;    [unspecified "#212121" "#f07178" "#c3e88d" "#ffcb6b" "#82aaff" "#c792ea" "#82aaff" "#eeffff"])
;;  '(custom-enabled-themes (quote (tango-dark)))
;;  '(custom-safe-themes
;;    (quote
;;     ("196df8815910c1a3422b5f7c1f45a72edfa851f6a1d672b7b727d9551bb7c7ba" default)))
;;  '(package-selected-packages
;;    (quote
;;     (ein sr-speedbar yaml-mode virtualenv use-package-ensure-system-package swiper python-mode py-autopep8 processing-mode powerline platformio-mode paredit nyan-mode melpa-upstream-visit material-theme list-packages-ext irony-eldoc ini-mode helm go-play go-mode flycheck fireplace date-field company-arduino better-defaults base16-theme avy ac-clang ac-capf))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode pyenv-mode material-theme exec-path-from-shell elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
