(defun shell (str)
  (parse-integer
    (with-output-to-string (out)
      (sb-ext:run-program "sh" (list "-c" str)
                          :search t
                          :output out))))

(defun color (val)
  (cond ((< val 20) "#00FFFF")
        ((< val 30) "#FF00FF")
        ((< val 50) "#66CCFF")
        ((< val 70) "#FFFF00")
        ((< val 80) "#11FF55")
        (t "#FF3333")))


(let ((mem  (shell "free | grep Mem | awk '{print int(($2-$7)/$2*100+0.5)}'"))
      (swap (shell "free | grep Swap | awk '{print int($3/$2*100+0.5)}'")))
  (format t "<fc=~a>~2,'0d</fc> <fc=~A>~2,'0d</fc>"
          (color mem) mem (color swap) swap))

