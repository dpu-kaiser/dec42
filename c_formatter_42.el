(defun format-42-c-buffer ()
  (interactive)
  (when (eq major-mode 'c-mode) 
    (shell-command-on-region
      (point-min)(point-max)
      "python -m c_formatter_42"
      (current-buffer)
      t
      "*C-Formatter-42 Error*"
      t)))


(global-set-key (kbd "C-c f") 'format-42-c-buffer)
