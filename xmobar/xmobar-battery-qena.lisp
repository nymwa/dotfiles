(defun read-file (path)
  (with-open-file (s path :direction :input)
    (read s)))

(defun color (val)
  (cond ((< val 20) "#FF3333")
        ((< val 30) "#11FF55")
        ((< val 50) "#FFFF00")
        ((< val 70) "#66CCFF")
        ((< val 80) "#FF00FF")
        (t "#00FFFF")))
(let ((line (read-file "/sys/class/power_supply/ADP1/online"))
      (rate (read-file "/sys/class/power_supply/BATC/capacity")))
  (format t "<fc=~a>~2,'0d~a</fc>"
          (color rate) rate
          (if (zerop line) "-" "+")))
