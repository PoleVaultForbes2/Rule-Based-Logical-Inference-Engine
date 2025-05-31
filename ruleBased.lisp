;Josh Forbes
(setf facts '(A B C))


(setf rules '(
 ((and A B) D)
 ((or A C) E)
 ((or B A) F)
 ((F) G)
 ((and F (or H D)) I)
 ((or (and X Z) (and Y X)) J)
 ))

(setf end 'J)

; (prove? 'A facts rules)    ; a fact
; (prove? 'D facts rules)    ; provable using single rule
; (prove? 'G facts rules)    ; facts + multiple and complex rules
; (prove? 'M facts rules)    ; non-provable => nil


(defun prove? (facts rules end)
    (setf OGrules rules)
    (if (member end facts)
        (progn
            (print "Fact")
            t)
        (provable facts rules end OGrules)) )


(defun provable (facts rules end OG)
    (if (null rules)
        ()
        (if (equal (cadr (car rules)) end)   ;if this is true, we get a rule with the end goal in mind
            (if (check_list_rule facts rules OG)
                t
                (provable facts (cdr rules) end OG) )
            (provable facts (cdr rules) end OG) )))


(defun check_rule (facts rules OG)
        ;have multiple rules here depending if the operator is AND OR etc.
        (if (equal 'AND (car (car (first rules))))
            (if (and (member (car (cdr (car (first rules)))) facts)
                     (member (car (cdr (cdr (car (first rules))))) facts))
                (progn 
                    (print "Provable using single rule")
                    t)
                (if (not (member (car (cdr (car (first rules)))) facts))
                    ;if the first item is not in facts check the first
                    (if (provable facts OG (car (cdr (car (first rules))))OG )
                        ;the first one is true but we also have to check the second one
                        (if (provable facts OG (car (cdr (cdr (car (first rules)))))OG)
                            (progn
                                (print "Facts + mulitple and complex rules")
                                t)
                            nil)
                        nil )
                    ;otherwise the first is right and the second was wrong so try to prove that
                    (if (provable facts OG (car (cdr (cdr (car (first rules)))))OG) 
                        (progn
                            (print "Facts + multiple and complex rules")
                            t)
                        nil)))
            ;if not AND try OR
            (if (equal 'OR (car (car (first rules))))
                (if (or (member (car (cdr (car (first rules)))) facts)
                        (member (car (cdr (cdr (car (first rules))))) facts))
                    (progn
                        (print "Provable using single rule")
                        t)
                    ;both are wrong so try and prove them
                    (if (provable facts OG (car (cdr (car (first rules))))OG)
                        (progn
                            (print "Facts + multiple and complex rules")
                            t)
                        (if (provable facts OG (car (cdr (cdr (car (first rules)))))OG)
                            (progn
                                (print "Facts + multiple and complex rules")
                                t)
                            nil)))
                                                 
                ;if not AND or OR then try NOT
                (if (equal 'NOT (car (first rules)))
                    (if (not (member (car (car (first rules))) facts))
                        (progn
                            (print "used NOT")
                            t)
                        nil) 
                    ;if not AND or OR or NOT then try just first thing
                    (if (member (car (car (first rules))) facts)
                     (progn
                            (print "Provable using single rule")
                            t)
                        (if (provable facts OG (car (car (first rules)))OG)
                            (progn
                                (print "Facts + multiple and complex rules")
                                t)
                             nil))))))
                
(defun check_list_rule (facts rules OG)
  (if (equal 'AND (car (car (first rules))))
    (cond
        ((and (check_rule_condition facts (car (cdr (car (first rules)))) OG)
              (check_rule_condition facts (car (cdr (cdr (car (first rules))))) OG))
        t)
        (t nil))
    (if (equal 'OR (car (car (first rules))))
        (cond
        ((or (check_rule_condition facts (car (cdr (car (first rules)))) OG)
              (check_rule_condition facts (car (cdr (cdr (car (first rules))))) OG))
        t)
        (t nil))
        (if (member (car (car (first rules))) facts)
            (progn
                (print "Provable using single rule")
                t)
            (if (provable facts OG (car (car (first rules))) OG)
                (progn
                    (print "Facts + mulitple and compelx rules")
                    t)
                nil)))))
         

(defun check_rule_condition (facts condition OG)
  (cond ((listp condition)
         (check_rule facts (cons (cons condition '(A)) '(C)) OG))
         (t (check_atom condition facts OG))))

(defun check_atom (condition facts OG)
    (if (member condition facts)
        t
        (if (provable facts OG condition OG)
            t
            nil)))
