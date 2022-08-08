(define (range start end)
  (define (helper i lst)
     (if (< i start) lst (helper (- i 1) (cons i lst))))
  (helper (- end 1) nil))


(define (reverse lst)
  (define (rev-iter done todo)
    (if (null? todo) done (rev-iter (cons (car todo) done) (cdr todo))))
  (rev-iter nil lst))


(define (insert n lst)
  (define (rev-iter done todo)
    (if (null? todo) done (rev-iter (cons (car todo) done) (cdr todo))))
  (define (ins-iter re-head tail)
    (if (or (null? tail) (> (car tail) n))
      (rev-iter tail (cons n re-head))
      (ins-iter (cons (car tail) re-head) (cdr tail))))
  (ins-iter nil lst))