(let ((mut (sb-ext:process-exit-code
             (sb-ext:run-program "pamixer" '("--get-mute") :search t))))
  (if (zerop mut)
    (format t "<fc=red>MM</fc>")
    (let ((snd (parse-integer
                 (with-output-to-string (out)
                   (sb-ext:run-program "pamixer" '("--get-volume")
                                       :search t
                                       :output out)))))
      (if (= snd 100)
        (format t "<fc=#FF3333>FF</fc>") 
        (format t "<fc=~A>~2D</fc>"
                (cond ((< snd 20) "#00FFFF")
                      ((< snd 30) "#FF00FF")
                      ((< snd 50) "#66CCFF")
                      ((< snd 70) "#FFFF00")
                      ((< snd 80) "#11FF55")
                      (t "#FF3333"))
                snd)))))
