;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Wojciech M. Wnuk"
      user-mail-address "laniusone@pm.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Projects/Org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(global-set-key (kbd "C-,") 'embark-dwim)

(add-hook 'minibuffer-setup-hook
          (lambda ()
            (local-set-key (kbd "M-p") 'embark-export)))

(after! consult
  (setq consult-ripgrep-args "rg --hidden --no-ignore --null --line-buffered --color=never --max-columns=1000 --path-separator /\
   --smart-case --no-heading --with-filename --line-number --search-zip"))

(after! lsp-mode
  (setq lsp-enable-file-watchers nil))

(after! vterm
  (setq vterm-kill-buffer-on-exit t))

(defun file-path-in-project ()
  "Return file path in current project"
  (interactive)
  (s-replace (projectile-project-root) "" buffer-file-name))

(defun sync-to-server ()
  "Sync to server with external script."
  (interactive)
  (if (file-exists-p (format "%s.sync" (projectile-project-root)))
      (shell-command-to-string
       (format "%s.sync upload $(dirname %s) $(basename %s)" (projectile-project-root) (file-path-in-project) (file-path-in-project))) nil))

(defun sync-from-server ()
  "Sync from server with external script."
  (interactive)
  (if (file-exists-p (format "%s.sync" (projectile-project-root)))
      (shell-command-to-string
       (format "%s.sync download $(dirname %s) $(basename %s)" (projectile-project-root) (file-path-in-project) (file-path-in-project))) nil))

(add-hook 'after-save-hook #'sync-to-server)

(use-package! beacon
  :config
  (beacon-mode 1))

(defun open-lazygit ()
  "Open lazygit pane in tmux"
  (interactive)
  (shell-command-to-string "tmux split-window -h lazygit"))

(map! :leader
      (:prefix "r"
               "g" #'consult-ripgrep)
      )

(map! :leader
      (:prefix "g"
               "d" #'lsp-find-definition
               "i" #'lsp-find-implementation
               "r" #'lsp-find-references
               "D" #'lsp-find-declaration
               "K" #'lsp-find-type-definition)
      )

(map! :leader
      (:prefix "S"
               "u" #'sync-to-server
               "d" #'sync-from-server))

(map! :leader
      (:prefix "g"
               "g" #'open-lazygit))

(map! :leader
      (:prefix "f"
               "f" #'consult-find
               "b" #'dired))

(evil-define-key
  '(normal insert visual replace operator motion emacs)
  'global
  (kbd "C-n") 'dired)

(global-set-key [mouse-4] (lambda () (interactive) (scroll-down 5)))
(global-set-key [mouse-5] (lambda () (interactive) (scroll-up 5)))

(setq-default tab-width 4)

(load! "iph.el")
