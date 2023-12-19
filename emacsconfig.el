(setq shell-command-switch "-ic")

(defcustom doc-view-ghostscript-program "/opt/local/bin/gs"
  "Program to convert PS and PDF files to PNG."
  :type 'file
  :group 'doc-view)

(global-set-key (kbd "C-c C-a") 'generatepdf)

(defun generatepdf () (interactive)(call-process-shell-command (concat "generatepdf " (buffer-file-name)) nil nil nil))

(setq inhibit-splash-screen t)

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))
(package-initialize)

;; !Første gang man installerer emacs må man kommentere ut dette!
;; (package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(dolist (package '(monokai-theme ido-vertical-mode elm-mode))
 (unless (package-installed-p package)
   (package-install package))
   (require package))



(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

(load-theme 'monokai t)

; sets standard font to Inconsolata
(add-to-list 'default-frame-alist '(font .  "Inconsolata-14" ))
(set-face-attribute 'default t :font  "Inconsolata-14" )

;; show matching parenthesis
(show-paren-mode t)

;; show column number by default
(setq column-number-mode t)

;; answer with y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; stop blinking cursor
(blink-cursor-mode 0)

;; no toolbar either
(tool-bar-mode 0)

;; deletes selection when you start typing
(delete-selection-mode 1)

(setq-default split-width-threshold 100)

(set-frame-width (selected-frame) 113)
(set-frame-height (selected-frame) 62)

(set-frame-position (selected-frame) 0 0)


;; adds all autosave-files (i.e #test.txt#, test.txt~) in one
;; directory, avoid clutter in filesystem.
(defvar emacs-autosave-directory "~/.emacs.d/autosaves/")
(setq backup-directory-alist
      `((".*" . ,emacs-autosave-directory))
      auto-save-file-name-transforms
      `((".*" ,emacs-autosave-directory t)))

;; defining a function that sets the right indentation to the marked
;; text, or the entire buffer if no text is selected.
(defun tidy ()
  "Ident, untabify and unwhitespacify current buffer, or region if active."
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
	(end (if (region-active-p) (region-end)       (point-max))))
    (whitespace-cleanup)
    (indent-region beg end nil)
    (untabify beg end)))

;; bindes the tidy-function to C-TAB
(global-set-key (kbd "<C-tab>") 'tidy)

(dolist (mode
	 '(ido-mode                   ; Interactivly do.
	   ido-everywhere             ; Use Ido for all buffer/file reading.
	   ido-vertical-mode))        ; Makes ido-mode display vertically.
  (funcall mode 1))

(setq ido-vertical-define-keys 'C-n-C-p-up-and-down)

(setq ido-file-extensions-order
      '(".el" ".scm" ".lisp" ".java" ".c" ".h" ".py" ".org" ".tex"))

(add-to-list 'ido-ignore-buffers "*Messages*")

(require 'elm-mode)

;; removes scratch message

(setq initial-scratch-message nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(custom-safe-themes
   (quote
    ("dd43c9f997208c61ce0f4855932cc20a57ae2f37fe2ced218dace5c8c321d1e8" "fa189fcf5074d4964f0a53f58d17c7e360bb8f879bd968ec4a56dc36b0013d29" default)))
 '(fci-rule-color "#9D550F")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#9D550F" . 0)
     ("#67930F" . 20)
     ("#349B8D" . 30)
     ("#21889B" . 50)
     ("#968B26" . 60)
     ("#A45E0A" . 70)
     ("#A41F99" . 85)
     ("#9D550F" . 100))))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (markdown-preview-eww markdown-preview-mode elm-mode smex monokai-theme ido-vertical-mode auto-complete)))
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(syslog-debug-face
   (quote
    ((t :background unspecified :foreground "#A1EFE4" :weight bold))))
 '(syslog-error-face
   (quote
    ((t :background unspecified :foreground "#F92672" :weight bold))))
 '(syslog-hour-face (quote ((t :background unspecified :foreground "#A6E22E"))))
 '(syslog-info-face
   (quote
    ((t :background unspecified :foreground "#66D9EF" :weight bold))))
 '(syslog-ip-face (quote ((t :background unspecified :foreground "#E6DB74"))))
 '(syslog-su-face (quote ((t :background unspecified :foreground "#FD5FF0"))))
 '(syslog-warn-face
   (quote
    ((t :background unspecified :foreground "#FD971F" :weight bold))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#9D550F" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq default-directory "~")

;; make scrolling smoother
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Mindre indentering av javascript
(setq js-indent-level 2)

;; ;; Midlertidig til fase2 er merget inn i master (ordstyrersystemet)
;; (setq js-indent-level 4)


(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(server-start)
