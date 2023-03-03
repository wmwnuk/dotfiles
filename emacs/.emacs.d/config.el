(setq make-backup-files nil
      auto-save-default t
      auto-revert-use-notify nil
      auto-revert-verbose nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(global-hl-line-mode t)
(global-auto-revert-mode 1)

(setq mouse-autoselect-window t)

;; tabs off by default
(setq-default indent-tabs-mode nil)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

(show-paren-mode t)

(require 'doom-modeline)
(doom-modeline-mode 1)

(require 'beacon)
(beacon-mode 1)

  (require 'doom-themes)

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each
  ;; theme may have their own settings.
  (load-theme 'doom-tokyo-night t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

(require 'all-the-icons)

(require 'dashboard)
(dashboard-setup-startup-hook)

(require 'which-key)
(which-key-mode)

(setq evil-want-keybinding nil)

(require 'evil-leader)
(global-evil-leader-mode)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))

(evil-mode 1)

(require 'lsp-mode)
(add-hook 'php-mode-hook #'lsp)
(setq lsp-file-watch-threshold 8000)
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\vendor\\'")
)
(define-key lsp-mode-map (kbd "C-c C-l") lsp-command-map)

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(require 'company)
(add-hook 'lsp-mode-hook 'company-mode)

(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(display-line-numbers-mode 1)
(setq-default display-line-numbers 'relative)

(dolist (mode '(org-mode-hook
                term-mode-hook
                vterm-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

(setq vterm-kill-buffer-on-exit t)

(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))

(require 'marginalia)
(marginalia-mode)

(require 'consult)
(setq consult-ripgrep-args "rg --hidden --no-ignore --null --line-buffered --color=never --max-columns=1000 --path-separator /\
   --smart-case --no-heading --line-number .")

(require 'embark)
(setq prefix-help-command #'embark-prefix-help-command)
(setq embark-collect-live-update-delay 0.5)
(setq embark-collect-live-initial-delay 0.8)
(setq embark-quit-after-action '((kill-buffer . t) (t . nil)))

(require 'embark-consult)
(add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode)

(require 'vertico)
(vertico-mode)

(savehist-mode)

;; Do not allow the cursor in the minibuffer prompt
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Emacs 28: Hide commands in M-x which do not work in the current mode.
;; Vertico commands are hidden in normal buffers.
(setq read-extended-command-predicate
      #'command-completion-default-include-p)

;; Enable recursive minibuffers
(setq enable-recursive-minibuffers t)

;; Use `consult-completion-in-region' if Vertico is enabled.
;; Otherwise use the default `completion--in-region' function.
(setq completion-in-region-function
      (lambda (&rest args)
        (apply (if vertico-mode
                   #'consult-completion-in-region
                 #'completion--in-region)
               args)))

;; Optionally use the `orderless' completion style.
(require 'orderless)
  ;; Configure a custom style dispatcher (see the Consult wiki)
  (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
        orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion))))
(setq completion-styles '(basic substring partial-completion flex))
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

;; Keybindings
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
    "pp" 'projectile-switch-project
    "ff" 'consult-find
    "fb" 'dired
    "fw" 'wdired-change-to-wdired-mode
    "rg" 'consult-ripgrep
    "bi" 'ibuffer
    "bb" 'consult-buffer
    "wc" 'delete-window
    "bk" 'kill-current-buffer
    "gg" 'magit
    "tt" 'vterm
    "pl" 'package-list-packages
    "rn" 'lsp-rename
    "D"  'lsp-find-type-definition
  )
(define-key evil-normal-state-map (kbd "gcc") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd "gc") 'evilnc-comment-or-uncomment-lines)

(define-key evil-normal-state-map (kbd "gD") 'lsp-find-declaration)
(define-key evil-normal-state-map (kbd "gd") 'lsp-find-definition)
(define-key evil-normal-state-map (kbd "gi") 'lsp-find-implementation)
(define-key evil-normal-state-map (kbd "gr") 'lsp-find-references)

(global-set-key (kbd "C-,") 'embark-act)
(global-set-key (kbd "M-,") 'embark-dwim)
(global-set-key (kbd "C-.") 'embark-become)
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (local-set-key (kbd "M-p") 'embark-export)))

(defun my-reload-dir-locals-for-all-buffer-in-this-directory ()
  "For every buffer with the same `default-directory` as the 
current buffer's, reload dir-locals."
  (interactive)
  (let ((dir default-directory))
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (when (equal default-directory dir)
          (my-reload-dir-locals-for-current-buffer))))))

(add-hook 'emacs-lisp-mode-hook
          (defun enable-autoreload-for-dir-locals ()
            (when (and (buffer-file-name)
                       (equal dir-locals-file
                              (file-name-nondirectory (buffer-file-name))))
              (add-hook 'after-save-hook
                        'my-reload-dir-locals-for-all-buffer-in-this-directory
                        nil t))))
