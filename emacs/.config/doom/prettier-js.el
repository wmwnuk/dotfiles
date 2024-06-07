;;; prettier-js.el --- Description -*- lexical-binding: t; -*-

(after! prettier-js
  (add-hook 'typescript-mode-hook 'prettier-js-mode)
  (add-hook 'typescript-tsx-mode-hook 'prettier-js-mode)
  (add-hook 'rjsx-mode-hook 'prettier-js-mode)
  (add-hook 'js-mode-hook 'prettier-js-mode)
  (add-hook 'js2-mode-hook 'prettier-js-mode))

(after! typescript-mode
  (add-hook 'typescript-mode-hook #'add-node-modules-path))

(after! typescript-tsx-mode
  (add-hook 'typescript-tsx-mode-hook #'add-node-modules-path))

(after! rjsx-mode
  (add-hook 'rjsx-mode-hook #'add-node-modules-path))

(after! js-mode
  (add-hook 'js-mode-hook #'add-node-modules-path))

(after! js2-mode
  (add-hook 'js2-mode-hook #'add-node-modules-path))
