(defconst 42name "dkaiser")
(defconst 42email "dkaiser@student.42heilbronn.de")

(defun trim-or-fill-string (string length)
  (if (> (length string) length)
      (substring string 0 length)
    (concat string (make-string (- length (length string)) ?\s))))

(defun check-42header ()
  (save-excursion
   (goto-char (point-min))
  (equal (thing-at-point 'line t)
	 (concat "/* " (make-string 74 ?*) " */\n"))))

(defun add-42header ()
  (save-excursion
    (goto-char (point-min))
    (insert "/* " (make-string 74 ?*) " */\n")
    (insert "/* " (make-string 74 ? ) " */\n")
    (insert "/*                                                        :::      ::::::::   */\n")
    (insert "/*   "
	    (trim-or-fill-string (file-name-nondirectory buffer-file-name) 43)
	    "        :+:      :+:    :+:   */\n")
    (insert "/*                                                    +:+ +:+         +:+     */\n")
    (insert "/*   By: "
	    (trim-or-fill-string (concat 42name " <" 42email ">") 39)
	    "    +#+  +:+       +#+        */\n")
    (insert "/*                                                +#+#+#+#+#+   +#+           */\n")
    (insert "/*   Created: "
	    (format-time-string "%Y/%m/%d %H:%M:%S" (nth 5 (file-attributes buffer-file-name)))
	    " by "
	    (trim-or-fill-string 42name 11)
	    "       #+#    #+#             */\n")
    (insert "/*   Updated: "
	    (format-time-string "%Y/%m/%d %H:%M:%S")
	    " by "
	    (trim-or-fill-string 42name 11)
	    "      ###   ########.fr       */\n")
    (insert "/* " (make-string 74 ? ) " */\n")
    (insert "/* " (make-string 74 ?*) " */\n\n")))

(defun update-42header ()
  (save-excursion
    (goto-char (point-min))
    (forward-line 8)
    (kill-line)
    (insert "/*   Updated: "
	    (format-time-string "%Y/%m/%d %H:%M:%S")
	    " by "
	    (trim-or-fill-string 42name 11)
	    "      ###   ########.fr       */")))

(defun add-or-update-42header ()
  (interactive)
  (save-excursion
  (if (check-42header)
      (funcall #'update-42header)
    (funcall #'add-42header))))

(defun update-42header-if-existing ()
  (if (check-42header)
      (funcall #'update-42header)))

(add-hook 'before-save-hook #'update-42header-if-existing)
(global-set-key (kbd "C-c h") 'add-or-update-42header)
