;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
;; (when (fboundp 'global-font-lock-mode)
;;   (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; enable desktop-save-mode
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html
;(desktop-save-mode 1)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa.org/packages/") t)

(package-initialize)
(elpy-enable)

;; company-python (COMplete ANYthing)
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

;; elpy
;; (use-package elpy
  ;; :ensure t
  ;; :init
  ;; (elpy-enable))

;; display line numbers on the left
(global-display-line-numbers-mode)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; preferences for backup files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; always end a file with a newline
;(setq require-final-newline 'query)

;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)

(defvar close-bracket-on-new-line t
"True if the closing bracket must go onto a new line.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Use "%" to jump to the matching parenthesis.
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert
the character typed."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t                    (self-insert-command (or arg 1))) ))
(global-set-key "%" `goto-match-paren)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; The C definitions:
;;;

(defun c-closing-brace () (interactive) "puts } where it belongs to"
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward "^{\n")
    (setq close-bracket-on-new-line (eolp)))
  (if (eq 't close-bracket-on-new-line)
      (insert "\n"))
  (insert "}")
  (indent-for-tab-command)
  (forward-line -1)
  (if (save-excursion
	(beginning-of-line)
	(skip-chars-forward " \t")
	(eolp))
      (progn
	(beginning-of-line)
	(kill-line 1))
    (progn
      (forward-line 1)))
  (end-of-line))

(defun c-opening-brace () (interactive) "puts { where it belongs to"
  (insert "{")
  (indent-for-tab-command))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Hooks
;;;

(add-hook 'text-mode-hook
	(function (lambda ()
		    (auto-fill-mode 1)
		    (setq fill-column 68)
		    )))

(add-hook 'c-mode-hook
	  (function (lambda ()
		      (c-set-style "stroustrup")
                      (setq c-basic-offset 3)
                      (setq c-indent-level 3)
                      (setq-default indent-tabs-mode nil)
		      (auto-fill-mode 1)
		      (setq fill-column 78)
		      (define-key c-mode-map "}"     'c-closing-brace)
		      (define-key c-mode-map "{"     'c-opening-brace)
		      (defconst c-tab-always-indent t)
		      )))

(add-hook 'c++-mode-hook
	  (function (lambda ()
		      (c-set-style "stroustrup")
                      (setq c-basic-offset 3)
                      (setq c-indent-level 3)
                      (setq-default indent-tabs-mode nil)
		      (auto-fill-mode 1)
		      (setq fill-column 78)
		      (define-key c++-mode-map "}"     'c-closing-brace)
		      (define-key c++-mode-map "{"     'c-opening-brace)
		      )))

(add-hook 'fortran-mode-hook
	  (function (lambda ()
		      (auto-fill-mode 1)
		      (setq fill-column 72)
		      )))

(add-hook 'latex-mode-hook
	  (function (lambda ()
		      (auto-fill-mode 1)
		      (setq fill-column 78)
		      )))

(add-hook 'html-mode-hook
	  (function (lambda ()
		      (auto-fill-mode 1)
		      (setq fill-column 78)
		      )))

(add-hook 'makefile-mode-hook
	  (function (lambda ()
		      (define-key makefile-mode-map "\M-c" 'compile)
		      )))

;; delete trailing whitespace
(add-hook 'before-save-hook
          'delete-trailing-whitespace)

(add-hook 'after-init-hook 'global-company-mode)

;; tex options
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;; (setq-default TeX-master nil)

(setq auto-mode-alist
      (cons
       '("\\.m$" . octave-mode)
       auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes '(tango-dark))
 '(font-use-system-font t)
 '(indicate-buffer-boundaries '((t . right) (top . left)))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(ispell-dictionary nil)
 '(package-selected-packages '(elpygen elpy company-jedi company ## matlab-mode auctex))
 '(scroll-bar-mode 'right)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 98 :width normal)))))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(with-eval-after-load 'package (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/")))
