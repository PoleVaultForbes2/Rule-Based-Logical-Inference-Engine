(load "expertSytem.lisp")

(format t "~%=== Expert System Tests ===~%")

(format t "~%Test A (should be fact): ~A~%" (prove? facts rules 'A))
(format t "~%Test D (should be provable using single rule): ~A~%" (prove? facts rules 'D))
(format t "~%Test G (should be provable using complex rules): ~A~%" (prove? facts rules 'G))
(format t "~%Test I (should be provable using complex rules): ~A~%" (prove? facts rules 'I))
(format t "~%Test J (should be nil): ~A~%" (prove? facts rules 'J))
(format t "~%Test M (should be nil): ~A~%" (prove? facts rules 'M))
