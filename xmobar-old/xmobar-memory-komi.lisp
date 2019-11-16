(let ((mem (parse-integer
             (with-output-to-string (out)
               (sb-ext:run-program "sh" '("-c" "free | grep Mem | awk '{print int(($2-$7)/$2*100+0.5)}'")
                               :search t
                               :output out)))))
  (format t "<fc=~A>~2D</fc>"
          (cond ((< mem 20) "#00FFFF")
                ((< mem 30) "#FF00FF")
                ((< mem 50) "#66CCFF")
                ((< mem 70) "#FFFF00")
                ((< mem 80) "#11FF55")
                (t "#FF3333"))
          mem))

