;;
;; ADDITIONAL REPOSITORY FOR MODULES TO LOAD
;;
(add-to-list 'load-path "~/.emacs.d/modules")

;;
;; ADDITIONNALS MODULES
;;
;;(require 'dsvn)
(require 'psvn)
(require 'php-mode)
(require 'saveplace)
;;(require 'unxls)
;; display the path to the file in the sidebar.
;;(require 'uniquify)

;; Using ctags
(setq path-to-ctags "/opt/local/bin/ctags") ;; <- your ctags path here
(defun create-tags (dir-name)
   "Create tags file."
   (interactive "DDirectory: ")
   (shell-command
      (format "ctags -f %s -e -R %s" path-to-ctags (directory-file-name dir-name)))
)

;; Show full path of files
(setq frame-title-format
   (list (format "%s %%S: %%j " (system-name))
   '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(require 'color-theme)
(color-theme-initialize)
(color-theme-tty-dark)

;;
;; KEYBOARD SHORTCUT
;;
(global-set-key [f9] 'compile)
(global-set-key [(control z)] 'undo)
;; We could use 'dabbrev-completion or 'dabbrev-expand
(global-set-key [(control return)] 'dabbrev-completion)
;;(global-set-key "\C-)" 'dabbrev-completion)
;;(global-set-key "\C-=" 'dabbrev-expand)
(global-set-key "\C-n" 'imenu)
(defun try-to-add-imenu ()
(condition-case nil (imenu-add-to-menubar "imenu") (error nil)))
(add-hook 'font-lock-mode-hook 'try-to-add-imenu)

;; Company mode in all buffers
;;(add-hook 'after-init-hook 'global-company-mode)

(global-set-key "\M-s" 'new-shell)
(global-set-key (kbd "C-x t") 'todo-show)


;;
;; Copy or Cut one line if no content selected
;;
;; copy region or whole line
(global-set-key "\M-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning)
      (region-end))
    (progn
     (kill-ring-save (line-beginning-position)
     (line-end-position))
     (message "copied line")))))
	 
;; kill region or whole line
(global-set-key "\C-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-region (region-beginning)
   (region-end))
    (progn
     (kill-region (line-beginning-position)
  (line-end-position))
     (message "killed line")))))	 

;;
;; FUNCTION DEFINITION
;;
(defun new-shell ()
  (interactive)
  (let (
        (currentbuf (get-buffer-window (current-buffer)))
        (newbuf     (generate-new-buffer-name "*shell*"))
       )
   (generate-new-buffer newbuf)
   (set-window-dedicated-p currentbuf nil)
   (set-window-buffer currentbuf newbuf)
   (shell newbuf)
  )
)

;;
;; resolving compilation problems. This force the environment variables
;; to be set before compiling.
;;
(let ((path (shell-command-to-string ". ~/.bashrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;;
;; Ugly code for READING XLS (but works)
;; Requires: xlhtml & w3m
;;
(add-to-list 'auto-mode-alist '("\\.xls\\'" . no-xls))
  
(defun no-xls (&optional filename)
  "Run xlhtml and w3m -dump on the entire buffer.
   Optional FILENAME says what filename to use.
   This is only necessary for buffers without
   proper `buffer-file-name'.  FILENAME should
   be a real filename, not a path."
  (interactive "fExcel File: ")
    (when (and filename
      (not (buffer-file-name)))
      (write-file (make-temp-file filename)))
      (erase-buffer)
      (shell-command
      (format "xlhtml -nc -te %s | w3m -dump -T text/html" (buffer-file-name))
      (current-buffer))
      (setq buffer-file-name nil)
      (set-buffer-modified-p nil))

;;
;; START
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(c-block-comment-prefix "//")
 '(case-fold-search nil)
 '(column-number-mode t)
 '(comint-completion-autolist t)
 '(comint-completion-recexact t)
 '(compilation-always-kill t)
 '(compilation-auto-jump-to-first-error nil)
 '(compilation-scroll-output (quote first-error))
 '(compile-command
   "./makemake 5010 clean && ./makemake 5010 all -j 8 && ./makemake 5010 program")
 '(completion-show-help t)
 '(custom-enabled-themes nil)
 '(dabbrev-case-distinction t)
 '(dabbrev-case-replace t)
 '(doc-view-continuous t)
 '(doc-view-image-width 850)
 '(doc-view-resolution 200)
 '(dynamic-completion-mode t)
 '(grep-command
   "grep --exclude-dir=.svn --exclude=\\TAGS --exclude=\\*.{lst,lss,sym,log,list,o,elf,xml,json,sta,map,deps,a,so,d,sx,hex,doc,txt,pdf,tex} -iInHr \"")
 '(gud-gdb-command-name "arm-eabi-gdb -i=mi main.elf")
 '(initial-scratch-message
   ";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.
;; M-s: Open a new shell
")
 '(safe-local-variable-values
   (quote
    ((todo-categories "Todo")
     (todo-categories "barracuda" "alligator" "Todo")
     (todo-categories "alligator" "Todo"))))
 '(send-mail-function (quote mailclient-send-it))
 '(svn-status-hide-unknown t)
 '(svn-status-hide-unmodified t))

;;
;; EDITING/IDE
;;
(global-font-lock-mode 1)

(setq auto-mode-alist
      (append '(("\.php$" . php-mode)
		("\.module$" . php-mode))
              auto-mode-alist))

;; saving position in files opened with emacsclient
;;(setq server-visit-hook (quote (save-place-find-file-hook)))
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/saved-places")

;; Code completion case-insensitive, seems not working
;;(setq pcomplete-ignore-case t)
;;(setq case-fold-search t)
;;(setq read-buffer-completion-ignore-case t)
;;(setq read-file-name-completion-ignore-case t)

;; display the path to the buffer file using uniquify (required).
;;(setq uniquify-buffer-name-style 'reverse)
;; SHOW FILE PATH IN FRAME TITLE
;;(setq-default frame-title-format "%b (%f)")

;; Affiche le numéro de ligne et de colonne
(column-number-mode t)
(line-number-mode t)



;;
;; FORMATAGE
;;
;; Suppression des espaces en fin de ligne a l'enregistrement
(add-hook 'c++-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook   'c-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
;;(defun set-newline-and-indent ()
;;  (local-set-key (kbd "RET") 'newline-and-indent))
;;(add-hook 'lisp-mode-hook 'set-newline-and-indent)

;;;;
;;;; COLORS
;;;; 
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 135 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
;; '(compilation-warning ((t (:inherit warning))))
;; '(font-lock-comment-face ((t (:foreground "darkorange4"))))
;; '(font-lock-function-name-face ((t (:foreground "navy"))))
;; '(font-lock-keyword-face ((t (:foreground "red4"))))
;; '(font-lock-type-face ((t (:foreground "black"))))
;; '(linum ((t (:inherit shadow :background "gray95"))))
;; '(mode-line ((t (nil nil nil nil :background "grey90" (:line-width -1 :color nil :style released-button) "black" :box nil :width condensed :foundry "unknown" :family "DejaVu Sans Mono"))))
;; '(svn-status-directory-face ((t (:foreground "tomato")))))


;; sort of fullscreen
(add-to-list 'default-frame-alist '(left . 0))

(add-to-list 'default-frame-alist '(top . 0))

(add-to-list 'default-frame-alist '(height . 100))

(add-to-list 'default-frame-alist '(width . 200))

