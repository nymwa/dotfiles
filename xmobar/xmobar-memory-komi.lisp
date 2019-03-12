(let ((mem (parse-integer
             (with-output-to-string (out)
               (sb-ext:run-program "sh" '("-c" "free | grep Mem | awk '{print int(($2-$7)/$2*100+0.5)}'")
                               :search t
                               :output out)))))
  (format t "<fc=~A>~2D</fc>"
          (cond ((< mem 20) "lightblue")
                ((< mem 40) "green")
                ((< mem 60) "yellow")
                (t "red"))
          mem))

