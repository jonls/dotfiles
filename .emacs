
;; load path
(setq load-path (cons "~/.emacs.d/lisp" load-path))

;; keys
(define-key global-map [delete] 'delete-char)
(define-key global-map [f12] 'compile)
(fset 'yes-or-no-p 'y-or-n-p)

;; control scrolling
(setq scroll-step 0)
(setq scroll-preserve-screen-position t)
(setq scroll-conservatively 5)
(setq next-screen-context-lines 1)

;; misc
(transient-mark-mode t)
(line-number-mode t)
(column-number-mode t)
(show-paren-mode t)
(setq next-line-add-newlines nil)
(setq require-final-newline t)
(setq show-trailing-whitespace t)

;; fonts
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-comidia)

;; utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; home / end keys
(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)
(define-key global-map [C-home] 'beginnning-of-buffer)
(define-key global-map [C-end] 'end-of-buffer)

;; backups
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 2
      kept-old-versions 2
      version-control t)       ; use versioned backups

;; custom file
(setq custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)

;; outline
(define-key global-map "\C-c/" 'hide-sublevels)
(define-key global-map "\C-c*" 'show-all)
(define-key global-map "\C-c-" 'hide-subtree)
(define-key global-map "\C-c+" 'show-children)

;; no menu bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; line numbers
(global-linum-mode 1)

;; hightlight complete parenthesized expression
(setq show-paren-style 'expression)

;; text
(add-hook 'text-mode-hook 'auto-fill-mode)
(set-fill-column 79)

;; c
(setq c-default-style "linux")
(add-hook 'c-mode-common-hook 'outline-minor-mode)

(setq c-style-variables-are-local-p t)

;; Do not check for old-style (K&R) function declarations;
;; this speeds up indenting a lot.
(setq c-recognize-knr-p nil)

;; Switch fromm *.<impl> to *.<head> and vice versa
(defun switch-cc-to-h ()
  (interactive)
  (when (string-match "^\\(.*\\)\\.\\([^.]*\\)$" buffer-file-name)
    (let ((name (match-string 1 buffer-file-name))
	  (suffix (match-string 2 buffer-file-name)))
      (cond ((string-match suffix "c\\|cc\\|C\\|cpp")
	     (cond ((file-exists-p (concat name ".h"))
		    (find-file (concat name ".h")))
		   ((file-exists-p (concat name ".hh"))
		    (find-file (concat name ".hh")))))
	    ((string-match suffix "h\\|hh")
	     (cond ((file-exists-p (concat name ".cc"))
		    (find-file (concat name ".cc")))
		   ((file-exists-p (concat name ".C"))
		    (find-file (concat name ".C")))
		   ((file-exists-p (concat name ".cpp"))
		    (find-file (concat name ".cpp")))
		   ((file-exists-p (concat name ".c"))
		    (find-file (concat name ".c")))))))))
 
(defun my-c-mode-common-hook ()
  ;; automatic indent on return in cc-mode
  ;(define-key c-mode-base-map "\r" 'newline-and-indent)
  ;; switch on C-c b
  (define-key c-mode-base-map (kbd "C-c b b") 'switch-cc-to-h))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-c++-mode-common-hook ()
  ;; set default c++ style
  (c-set-style "ellemtel"))

(add-hook 'c++-mode-hook 'my-c++-mode-common-hook)

;; d
(autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))

;; script
(add-to-list 'auto-mode-alist '("\\.conf\\'" . shell-script-mode))

;; sml
(setq sml-program-name "mosml")

;; xml
(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))
(setq nxml-slash-auto-complete-flag t
      nxml-auto-insert-xml-declaration-flag t)

;; css
(setq cssm-indent-function #'cssm-c-style-indenter
      cssm-indent-level 8)

;; ebuild
(defun ebuild-mode ()
  (shell-script-mode)
  (sh-set-shell "bash")
  (make-local-variable 'tab-width)
  (setq tab-width 4))
(setq auto-mode-alist (cons '("\\.ebuild\\'" . ebuild-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.eclass\\'" . ebuild-mode) auto-mode-alist))


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;; add marmalade package repository
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
