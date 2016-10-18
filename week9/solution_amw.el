(setq numbers (list 1 1 3 3 5 4 7 4 7))

(defun holy-trinity()
  (interactive)
  (print (reduce (lambda (a e) (logxor a e)) numbers)))
