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
        (format t "<fc=yellow>FF</fc>") 
        (format t "<fc=green>~2D</fc>" snd)))))
