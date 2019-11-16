(defun shell (str)
  (with-output-to-string (out)
    (sb-ext:run-program "sh" (list "-c" str)
                        :search t
                        :output out)))

(defun parse-float (str)
  (with-input-from-string (in str)
    (read in)))

(defun color (val)
  (cond ((< val 20) "#777700")
        ((< val 40) "#999900")
        ((< val 60) "#BBBB00")
        ((< val 80) "#DDDD00")
        (t "#FFFF00")))

(let ((x (round (parse-float (shell "light -G")))))
  (format t "<fc=~a>~a</fc>"
          (color x)
          (if (= x 100)
            "FF"
            (format nil "~2,'0d" x))))
            
