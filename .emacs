;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
;; (when (fboundp 'global-font-lock-mode)
;;   (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

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
 '(font-use-system-font t)
 '(indicate-buffer-boundaries (quote ((t . right) (top . left))))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(custom-enabled-themes (quote (tango-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
