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

(use-package! flycheck
  :defer
  :config
  ;; Setting eslint as the default linter for typescript files
  (add-hook! 'typescript-mode-hook 'use-eslint)
  ;; Editing the definitions for tslint to avoid creating temporary files
  ;; that make Webpack's dev server ANGRY
  (flycheck-define-checker typescript-tslint
    "TypeScript style checker using TSLint.
Note that this syntax checker is not used if
`flycheck-typescript-tslint-config' is nil or refers to a
non-existing file.
See URL `https://github.com/palantir/tslint'."
    :command ("tslint" "--format" "json"
              (config-file "--config" flycheck-typescript-tslint-config)
              (option "--rules-dir" flycheck-typescript-tslint-rulesdir)
              (eval flycheck-tslint-args)
              ;; This is normally source-inplace
              source)
    :error-parser flycheck-parse-tslint
    :modes (typescript-mode))
  )

;; Enables persistent folds for vimish fold
(vimish-fold-global-mode 1)
