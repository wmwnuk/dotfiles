;;; doom-kyotonight.el --- Description -*- lexical-binding: t; -*-

(defun emacs-ascii-logo ()
  (let* ((banner '(
                "                      .:-==+****+=-       "
                "                  .::--======+******-     "
                "                             .+******:    "
                "              .....:::---==++********:    "
                "       :=+++***********************+-     "
                "      +*************++==---::::::..       "
                "      =********+=:.                       "
                "       :+******+                          "
                "         :=*****+-:                       "
                "            :=+*****=-:                   "
                "               .:-++****+-:.              "
                "                 .::-=+*****+=-.          "
                "        .:-=++***************+=-:         "
                "    .:=+*************+==-:.               "
                "  :=************+=:.                      "
                ".+***********+-.                          "
                "************-                             "
                "+**********=                              "
                " =**********=:                            "
                "  .-+**********+=--:::...........         "
                "     .:-=+**************************+++=-:"
                "          .::-=+++++***+++++===+*********="
                "                            .:=*****++-:  "
                "                    .::-=++***+=--:.      "
                "            ..:--==++===-::.              "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'emacs-ascii-logo)
