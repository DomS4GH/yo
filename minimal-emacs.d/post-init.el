;;;
;;; init.el for GNU Emacs.
;;;

(cond ((file-directory-p (concat user-emacs-directory "/personal"))
       (setq dot-emacs-dir (expand-file-name (concat user-emacs-directory "/personal"))))
      (t (setq dot-emacs-dir (expand-file-name user-emacs-directory ))))

(defun try-load (file)
  (cond ((load file t t))
        (t (message (concat file " not found.")))))

(require 'use-package)

(defvar extra-keymap nil "Extra keymap.")
(define-prefix-command 'extra-keymap)
(global-set-key "\C-x\C-a" extra-keymap)

(cond (window-system
       (defvar menu-bar-extra-map (make-sparse-keymap "Extra functions."))
       (define-key global-map [menu-bar extra] (cons "Extra"  menu-bar-extra-map))
       (if (boundp 'menu-bar-final-items)
           (if menu-bar-final-items
               (setq menu-bar-final-items
                     (cons 'extra menu-bar-final-items)))
         (setq menu-bar-final-items '(extra)))
       ))

(define-key extra-keymap ";" 'comment-region)
(cond (window-system
       (define-key menu-bar-extra-map [comment-region]
         '("comment-region" . comment-region))))

(define-key extra-keymap "k" 'delete-region)
(cond (window-system
       (define-key menu-bar-extra-map [delete-region]
         '("delete-region" . delete-region))))

(define-key extra-keymap "p" 'proced)
(cond (window-system
       (define-key menu-bar-extra-map [proced]
         '("proced" . proced))))

(define-key extra-keymap "m" 'manual-entry)
(cond (window-system
       (define-key menu-bar-extra-map [manual-entry]
         '("manual-entry" . manual-entry))))

(define-key extra-keymap "l" 'load-file)
(cond (window-system
       (define-key menu-bar-extra-map [load-file]
         '("load-file" . load-file))))

(define-key extra-keymap "c" 'compile)
(cond (window-system
       (define-key menu-bar-extra-map [compile]
         '("compile" . compile))))

(define-key extra-keymap "%" 'query-replace-regexp)
(cond (window-system
       (define-key menu-bar-extra-map [query-replace-regexp]
         '("query-replace-regexp" . query-replace-regexp))))

(define-key extra-keymap "r" 'rename-buffer)
(cond (window-system
       (define-key menu-bar-extra-map [rename-buffer]
         '("rename-buffer" . rename-buffer))))

(define-key extra-keymap "f" 'ffap)
(cond (window-system
       (define-key menu-bar-extra-map [ffap]
         '("ffap" . ffap))))


(defun insert-date-time ()
  "Insert the current date and time"
  (interactive "*")
  (insert (format-time-string "%Y-%m-%dT%H:%M:%S_%Z")))

(define-key extra-keymap "t" 'insert-date-time)
(cond (window-system
       (define-key menu-bar-extra-map [insert-date-time]
         '("insert-date-time" . insert-date-time))))


(defun dom-paste-line-in-other-window ()
  "xxx..."
  (interactive)
  (beginning-of-line)
  (forward-word)
  (backward-word)
  (forward-word)
  (backward-word)
  (forward-word)
  (backward-word)
  (let ((beg nil)
        (end nil))
    (setq beg (point))
    (end-of-line)
    (setq end (point))
    (copy-region-as-kill beg end)
    (other-window 1)
    (yank)
    )
  )

(global-set-key "\C-x," 'dom-paste-line-in-other-window)

(defun dom-paste-paragraph-in-other-window ()
  "xxx..."
  (interactive)
  (let ((beg nil)
        (end nil))
    (search-backward-regexp "^[ 	]*$")
    (forward-line 1)
    (setq beg (point))
    (search-forward-regexp "^[ 	]*$")
    (setq end (point))
    (copy-region-as-kill beg end)
    (other-window 1)
    (yank)
    )
  )

(global-set-key "\C-x." 'dom-paste-paragraph-in-other-window)

(defun dom-edfap ()
  "Ediff files at point"
  (interactive)
  (let ((f1-beg)
        (f1)
        (f2-beg)
        (f2))
    (search-forward "diff ")
    (setq f1-beg (point))
    (search-forward " ")
    (backward-char)
    (setq f1 (buffer-substring-no-properties f1-beg (point)))
    (forward-char)
    (setq f2-beg (point))
    (end-of-line)
    (setq f2 (buffer-substring-no-properties f2-beg (point)))
    (ediff-files f1 f2)))

(global-set-key (kbd "\C-x/") 'dom-edfap)

(defun dom-rlsap ()
  "Run line in shell at point"
  (interactive)
  (let ((sc-beg)
        (sc))
    (beginning-of-line-text)
    (setq sc-beg (point))
    (end-of-line)
    (setq sc (buffer-substring-no-properties sc-beg (point)))
    (message "dom-rlsap, run shell-command= %s" sc)
    (shell-command sc)))

(global-set-key (kbd "\C-x!") 'dom-rlsap)

(defun dom-shell-other-window (&optional num)
  "Run shell in other window"
  (interactive "p")
  (delete-other-windows)
  (split-window)
  (other-window 1)
  (if num (shell (concat "*shell*-" (number-to-string num)))
    (shell)))

(define-key extra-keymap "s" 'dom-shell-other-window)
(cond (window-system
       (define-key menu-bar-extra-map [shell]
         '("shell" . dom-shell-other-window))))

(define-key extra-keymap "d" 'delete-trailing-whitespace)
(cond (window-system
       (define-key menu-bar-extra-map [delete-trailing-whitespace]
         '("delete-trailing-whitespace" . delete-trailing-whitespace))))

(defun dom-backward-delete-all ()
  "Backward delete all in current buffer"
  (interactive)
  (delete-region 1 (point)))

(define-key extra-keymap "\C-k" 'dom-backward-delete-all)
(cond (window-system
       (define-key menu-bar-extra-map [dom-backward-delete-all]
         '("dom-backward-delete-all" . dom-backward-delete-all))))

(define-key extra-keymap "\C-b" 'list-buffers)
(cond (window-system
       (define-key menu-bar-extra-map [list-buffers]
         '("list-buffers" . list-buffers))))


(display-time-mode 1)

(eval-after-load 'rng-loc
  '(add-to-list 'rng-schema-locating-files (concat dot-emacs-dir "/schema/schemas.xml")))

(cond (window-system
       (set-face-attribute 'default nil :weight 'bold :height 120 :width 'normal :font "Liberation Mono Bold")
       (copy-face 'default 'region)
       (set-face-inverse-video-p 'region t)
       (menu-bar-mode 0)
       (tool-bar-mode 0)
       (setq default-frame-alist '((width . 180) (height . 80) (menu-bar-lines . 1)))
       )
      )



;; File            : dom-align.el
;; Abstract        : Align according to usual delimiter strings or any string.

(defun dom-align-search (string occurence)
  "Search the occurence-th of string in the current line
Returns t if found either nil
If Found the cursor is left at the end of the searched occurence"
  (let ((eol (save-excursion (end-of-line) (point)))
        (bol (progn (beginning-of-line) (point)))
        (behind-string nil))
    (cond ((search-forward string eol t occurence)
           (backward-char (length string))
           (while (and (not (eq (point) bol))
                       (progn
                         (setq behind-string t)
                         (backward-char 1)
                         (cond ((looking-at "[ \t]") (delete-char 1) t)
                               (t nil)))))
           (cond (behind-string (forward-char 1) (insert-char ?  1) t)
                 (t t)))
          (t nil))))

(defun dom-align-find-col (string occurence)
  "Find the col to align the occurence-th of string
in the following lines"
  (save-excursion
    (let ((col 0))
      (while (dom-align-search string occurence)
        (setq col (max (current-column) col))
        (forward-line))
      col)))

(defun dom-align-occurence (string occurence)
  "Aligns the occurence-th of string in the folowing lines"
  (save-excursion
    (let ((col (dom-align-find-col string occurence)))
      (while (dom-align-search string occurence)
        (insert (make-string (- col (current-column)) ?\ ))
        (forward-line)))))

(defun dom-align-string (string)
  "Aligns all occurence of string in the following lines"
  (let ((occurence 1))
    (while (save-excursion (dom-align-search string occurence))
      (dom-align-occurence string occurence)
      (setq occurence (1+ occurence)))))

(defun dom-align (arg)
  "align all occurences of arg in following lines"
  (interactive "sString To Align: ")
  (dom-align-string arg))

(defun dom-align: () "" (interactive) (dom-align ":"))
(defun dom-align=> () "" (interactive) (dom-align "=>"))
(defun dom-align-is () "" (interactive) (dom-align "is"))
(defun dom-align-semi-colon () "" (interactive) (dom-align ";"))
(defun dom-align-colon () "" (interactive) (dom-align ","))

(defvar dom-align-keymap nil "Dom align keymap.")
(define-prefix-command 'dom-align-keymap)

(define-key extra-keymap "a" 'dom-align-keymap)
(cond (window-system
       (define-key menu-bar-extra-map [dom-align-keymap]
         '("dom-align-keymap" . dom-align-keymap))))

(define-key dom-align-keymap "a" 'dom-align)
(define-key dom-align-keymap ":" 'dom-align:)
(define-key dom-align-keymap ">" 'dom-align=>)
(define-key dom-align-keymap "i" 'dom-align-is)
(define-key dom-align-keymap ";" 'dom-align-semi-colon)
(define-key dom-align-keymap "," 'dom-align-colon)

(define-key extra-keymap "a" 'dom-align-keymap)
(cond (window-system
       (define-key menu-bar-extra-map [dom-align-keymap]
         '("dom-align-keymap" . dom-align-keymap))))

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(defun turn-on-comint-history (history-file)
  (setq comint-input-ring-file-name history-file)
  (comint-read-input-ring 'silent)
  (setq comint-prompt-read-only nil))

(add-hook 'shell-mode-hook
          (lambda () (turn-on-comint-history (getenv "HISTFILE"))))

(global-set-key (kbd "C-,") 'dynamic-completion-mode)
(global-set-key (kbd "C-.") 'company-complete)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (dot . t)
   (plantuml . t)
   (emacs-lisp . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/Downloads/plantuml.jar"))

(define-key comint-mode-map (kbd "C-a") 'comint-bol-or-process-mark)

(global-display-line-numbers-mode 0)
(global-subword-mode)


(use-package magit
  :bind ("C-x g" . magit-status)       ;; Binds C-x g to open the magit status buffer
  :commands (magit-status magit-dispatch) ;; Ensures these commands are available
  :init                                ;; Configuration run before loading
  ;; Add any initial configuration here
  :config                              ;; Configuration run after loading
  ;; Add any post-load configuration here
  )

(with-eval-after-load "magit"
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-modules-unpulled-from-upstream
                          'magit-insert-unpushed-to-pushremote
                          t)
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-modules-unpulled-from-pushremote
                          'magit-insert-unpushed-to-pushremote
                          t)
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-modules-unpushed-to-upstream
                          'magit-insert-unpushed-to-pushremote
                          t)
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-modules-unpushed-to-pushremote
                          'magit-insert-unpushed-to-pushremote
                          t)
  )


(setq-default truncate-lines t)
(global-visual-line-mode t)

(mapc #'disable-theme custom-enabled-themes)  ; Disable all active themes
(load-theme 'misterioso t)  ; Load the built-in theme
(load-theme 'modus-vivendi-tinted t)

;; Prefer horizontal splits over vertical ones
(setq split-width-threshold nil
      split-height-threshold 20)


(use-package corfu
  :ensure t
  :commands (corfu-mode global-corfu-mode)

  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode))

  :custom
  ;; Hide commands in M-x which do not apply to the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Disable Ispell completion function. As an alternative try `cape-dict'.
  (text-mode-ispell-word-completion nil)
  (tab-always-indent 'complete)

  ;; Enable Corfu
  :config
  (global-corfu-mode))

;; Cape, or Completion At Point Extensions, extends the capabilities of
;; in-buffer completion. It integrates with Corfu or the default completion UI,
;; by providing additional backends through completion-at-point-functions.
(use-package cape
  :ensure t
  :commands (cape-dabbrev cape-file cape-elisp-block)
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))


;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(use-package autorevert
  :ensure t
  :commands (auto-revert-mode global-auto-revert-mode)
  :hook
  (after-init . global-auto-revert-mode)
  :custom
  (auto-revert-interval 3)
  (auto-revert-remote-files nil)
  (auto-revert-use-notify t)
  (auto-revert-avoid-polling nil)
  (auto-revert-verbose t))

;; Recentf is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(use-package recentf
  :ensure t
  :commands (recentf-mode recentf-cleanup)
  :hook
  (after-init . recentf-mode)

  :custom
  (recentf-auto-cleanup (if (daemonp) 300 'never))
  (recentf-exclude
   (list "\\.tar$" "\\.tbz2$" "\\.tbz$" "\\.tgz$" "\\.bz2$"
         "\\.bz$" "\\.gz$" "\\.gzip$" "\\.xz$" "\\.zip$"
         "\\.7z$" "\\.rar$"
         "COMMIT_EDITMSG\\'"
         "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
         "-autoloads\\.el$" "autoload\\.el$"))

  :config
  ;; A cleanup depth of -90 ensures that `recentf-cleanup' runs before
  ;; `recentf-save-list', allowing stale entries to be removed before the list
  ;; is saved by `recentf-save-list', which is automatically added to
  ;; `kill-emacs-hook' by `recentf-mode'.
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

;; savehist is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(use-package savehist
  :ensure t
  :commands (savehist-mode savehist-save)
  :hook
  (after-init . savehist-mode)
  :custom
  (savehist-autosave-interval 600)
  (savehist-additional-variables
   '(kill-ring                        ; clipboard
     register-alist                   ; macros
     mark-ring global-mark-ring       ; marks
     search-ring regexp-search-ring)))

;; save-place-mode enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(use-package saveplace
  :ensure t
  :commands (save-place-mode save-place-local-mode)
  :hook
  (after-init . save-place-mode)
  :custom
  (save-place-limit 400))


;; Vertico provides a vertical completion interface, making it easier to
;; navigate and select from completion candidates (e.g., when `M-x` is pressed).
(use-package vertico
  ;; (Note: It is recommended to also enable the savehist package.)
  :ensure t
  :config
  (vertico-mode))

;; Vertico leverages Orderless' flexible matching capabilities, allowing users
;; to input multiple patterns separated by spaces, which Orderless then
;; matches in any order against the candidates.
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia allows Embark to offer you preconfigured actions in more contexts.
;; In addition to that, Marginalia also enhances Vertico by adding rich
;; annotations to the completion candidates displayed in Vertico's interface.
(use-package marginalia
  :ensure t
  :commands (marginalia-mode marginalia-cycle)
  :hook (after-init . marginalia-mode))

;; Embark integrates with Consult and Vertico to provide context-sensitive
;; actions and quick access to commands based on the current selection, further
;; improving user efficiency and workflow within Emacs. Together, they create a
;; cohesive and powerful environment for managing completions and interactions.
(use-package embark
  ;; Embark is an Emacs package that acts like a context menu, allowing
  ;; users to perform context-sensitive actions on selected items
  ;; directly from the completion interface.
  :ensure t
  :commands (embark-act
             embark-dwim
             embark-export
             embark-collect
             embark-bindings
             embark-prefix-help-command)
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Consult offers a suite of commands for efficient searching, previewing, and
;; interacting with buffers, file contents, and more, improving various tasks.
(use-package consult
  :ensure t
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x t b" . consult-buffer-other-tab)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))

  ;; Enable automatic preview at point in the *Completions* buffer.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init
  ;; Optionally configure the register formatting. This improves the register
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Aggressive asynchronous that yield instantaneous results. (suitable for
  ;; high-performance systems.) Note: Minad, the author of Consult, does not
  ;; recommend aggressive values.
  ;; Read: https://github.com/minad/consult/discussions/951
  ;;
  ;; However, the author of minimal-emacs.d uses these parameters to achieve
  ;; immediate feedback from Consult.
  ;; (setq consult-async-input-debounce 0.02
  ;;       consult-async-input-throttle 0.05
  ;;       consult-async-refresh-delay 0.02)

  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult-source-bookmark consult-source-file-register
   consult-source-recent-file consult-source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))


;; The `wgrep' packages lets us edit the results of a grep search
;; while inside a `grep-mode' buffer.  All we need is to toggle the
;; editable mode, make the changes, and then type C-c C-c to confirm
;; or C-c C-k to abort.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:9a3581df-ab18-4266-815e-2edd7f7e4852
(use-package wgrep
  :ensure t
  :bind ( :map grep-mode-map
          ("e" . wgrep-change-to-wgrep-mode)
          ("C-x C-q" . wgrep-change-to-wgrep-mode)
          ("C-c C-c" . wgrep-finish-edit)))


;; The markdown-mode package provides a major mode for Emacs for syntax
;; highlighting, editing commands, and preview support for Markdown documents.
;; It supports core Markdown syntax as well as extensions like GitHub Flavored
;; Markdown (GFM).
(use-package markdown-mode
  :commands (gfm-mode
             gfm-view-mode
             markdown-mode
             markdown-view-mode)
  :mode (("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :bind
  (:map markdown-mode-map
        ("C-c C-e" . markdown-do)))


;; Automatically generate a table of contents when editing Markdown files
(use-package markdown-toc
  :ensure t
  :commands (markdown-toc-generate-toc
             markdown-toc-generate-or-refresh-toc
             markdown-toc-delete-toc
             markdown-toc--toc-already-present-p)
  :custom
  (markdown-toc-header-toc-title "**Table of Contents**"))


;; Org mode is a major mode designed for organizing notes, planning, task
;; management, and authoring documents using plain text with a simple and
;; expressive markup syntax. It supports hierarchical outlines, TODO lists,
;; scheduling, deadlines, time tracking, and exporting to multiple formats
;; including HTML, LaTeX, PDF, and Markdown.
(use-package org
  :ensure t
  :commands (org-mode org-version)
  :mode
  ("\\.org\\'" . org-mode)
  :custom
  (org-hide-leading-stars t)
  (org-startup-indented t)
  (org-adapt-indentation nil)
  (org-edit-src-content-indentation 0)
  ;; (org-fontify-done-headline t)
  ;; (org-fontify-todo-headline t)
  ;; (org-fontify-whole-heading-line t)
  ;; (org-fontify-quote-and-verse-blocks t)
  (org-startup-truncated nil))


(use-package org-appear
  :commands org-appear-mode
  :hook (org-mode . org-appear-mode))



;; The built-in outline-minor-mode provides structured code folding in modes
;; such as Emacs Lisp and Python, allowing users to collapse and expand sections
;; based on headings or indentation levels. This feature enhances navigation and
;; improves the management of large files with hierarchical structures.
(use-package outline
  :ensure t
  :commands outline-minor-mode
  :hook
  ((emacs-lisp-mode . outline-minor-mode)
   ;; Use " ▼" instead of the default ellipsis "..." for folded text to make
   ;; folds more visually distinctive and readable.
   (outline-minor-mode
    .
    (lambda()
      (let* ((display-table (or buffer-display-table (make-display-table)))
             (face-offset (* (face-id 'shadow) (ash 1 22)))
             (value (vconcat (mapcar (lambda (c) (+ face-offset c)) " ▼"))))
        (set-display-table-slot display-table 'selective-display value)
        (setq buffer-display-table display-table))))))

;; The outline-indent Emacs package provides a minor mode that enables code
;; folding based on indentation levels.
;;
;; In addition to code folding, *outline-indent* allows:
;; - Moving indented blocks up and down
;; - Indenting/unindenting to adjust indentation levels
;; - Inserting a new line with the same indentation level as the current line
;; - Move backward/forward to the indentation level of the current line
;; - and other features.
(use-package outline-indent
  :ensure t
  :commands outline-indent-minor-mode

  :custom
  (outline-indent-ellipsis " ▼")

  :init
  ;; The minor mode can also be automatically activated for a certain modes.
  (add-hook 'python-mode-hook #'outline-indent-minor-mode)
  (add-hook 'python-ts-mode-hook #'outline-indent-minor-mode)

  (add-hook 'yaml-mode-hook #'outline-indent-minor-mode)
  (add-hook 'yaml-ts-mode-hook #'outline-indent-minor-mode))


(use-package kubed
  :ensure t
  :init (let ((files (directory-files "~/.kube" t "\\.yaml$"))
              (result ""))
          (dolist (file files)
            (setq result (concat file ":" result))
            (message "Found file: %s" file))
          (setenv "KUBECONFIG" result))
  :bind (("M-k" . kubed-prefix-map))
  :config
  ;; Optional: Automatically refresh resource buffers
  (add-hook 'kubed-mode-hook #'kubed-auto-refresh-mode))


(use-package yaml-mode
  :commands yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
         ("\\.yml\\'" . yaml-mode)))
