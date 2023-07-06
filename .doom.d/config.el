;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Steven Pham"
      user-mail-address "steven.pham.8.2000@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Add keybind for toggling window size
(defun create-window-toggler (max min)
  (setq! on-size max
         off-size min
         is-on nil
         )
  (lambda ()
    (interactive)
        (if is-on
                (evil-window-set-height max)
          (evil-window-set-height min)
          )
        (setq! is-on (not is-on))
        )
  )

(setq window-toggler (create-window-toggler 50 21))
(map! :leader
      :desc "Toggle max/min window size"
      "w f" window-toggler
      )

(after! rustic
  (setq rustic-format-on-save t)
  (setq rustic-lsp-server 'rust-analyzer))

(after! evil
  (setq evil-snipe-scope 'buffer)
  (setq evil-snipe-tab-increment t))

;; Sets tslint as the linter for the current buffer
(defun use-eslint ()
  (flycheck-select-checker 'javascript-eslint)
  )

;; Sets tide as the linter for the current buffer
(defun use-tide ()
  (flycheck-select-checker 'tsx-tide)
  )

(after! lsp-rust
  (setq lsp-rust-analyzer-experimental-proc-attr-macros t)
  (setq lsp-rust-analyzer-proc-macro-enable t))


(set-email-account!
 "gmail"
 '((mu4e-sent-folder       . "/gmail/[Gmail]/Sent Mail")
   (mu4e-trash-folder      . "/gmail/[Gmail]/Bin")
   (smtpmail-smtp-user     . "steven.pham.8.2000@gmail.com"))
 t)
(setq mu4e-get-mail-command "mbsync gmail"
      ;; get emails and index every 5 minutes
      mu4e-update-interval 300
	  ;; send emails with format=flowed
	  mu4e-compose-format-flowed t
	  ;; no need to run cleanup after indexing for gmail
	  mu4e-index-cleanup nil
	  mu4e-index-lazy-check t
      ;; more sensible date format
      mu4e-headers-date-format "%d.%m.%y")

(set-email-account!
 "protonmail"
 '((mu4e-sent-folder       . "/protonmail/sent")
   (mu4e-trash-folder      . "/protonmail/trash")
   (smtpmail-smtp-user     . "stevenv.pham@protonmail.com"))
 nil)
(setq mu4e-get-mail-command "mbsync protonmail"
      ;; get emails and index every 5 minutes
      mu4e-update-interval 300
	  ;; send emails with format=flowed
	  mu4e-compose-format-flowed t
	  ;; no need to run cleanup after indexing for gmail
	  mu4e-index-cleanup nil
	  mu4e-index-lazy-check t
      ;; more sensible date format
      mu4e-headers-date-format "%d.%m.%y")

;; Rebind Toggle last popup from ~ to O
(map! :leader
      :desc "Toggle last popup"
      "O" #'+popup/toggle)

(map! :leader
      "~" nil)

;; Change evil mode to insert when selecting vterm window
(defun change-to-insert-mode-in-vterm (&rest args)
  (ignore args)
  (let (
        (current-mode (with-current-buffer (current-buffer) major-mode))
        (is-new-window (not (eq (selected-window) (old-selected-window))))
        )
    (when (and is-new-window (eq current-mode 'vterm-mode)) (evil-insert-state))))

(add-hook! 'window-selection-change-functions :append #'change-to-insert-mode-in-vterm)

(add-hook! 'after-init-hook #'global-prettier-mode)

;; Adjust data read from proceses for LSP performance
(setq read-process-output-max (* 1024 1024))

;; Disable default js formatter when using lsp
;; (after! lsp-mode
;;   (setq lsp-javascript-format-enable nil)
;;   (setq lsp-javascript-validate-enable nil)
;;   (setq lsp-typescript-format-enable nil)
;;   (setq lsp-typescript-suggest-enabled nil)
;;   (setq lsp-typescript-validate-enable nil)
;;   )

(use-package! dap-mode
  :config
  (require 'dap-gdb-lldb)
  (dap-register-debug-template "Rust::GDB Run Configuration"
                               (list :type "gdb"
                                     :request "launch"
                                     :name "GDB::Run"
                                     :gdbpath "rust-gdb"
                                     :target nil
                                     :cwd nil))
  )

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug
      :desc "dap quit"          "q" #'+debugger/quit

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

(use-package! flycheck
  :config
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-gcc))
  )

(setq lsp-disabled-clients '(deno-ls))

(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
	    sql-mode         ; sqlformat is currently broken
	    tex-mode         ; latexindent is broken
	    latex-mode
            json-mode        ; do not murder someone else's formatting system
            yaml-mode
            markdown-mode))
