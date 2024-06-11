;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! vimrc-mode)
(package! ellama)
(package! prettier-js)
(package! add-node-modules-path)
(package! blamer)
(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
(package! posframe)
(package! vertico-posframe)
(package! gptel)
(package! solaire-mode :disable t)
(package! obsidian)
