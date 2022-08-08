(define (reverse lst)
  (define (reverse-iter done todo)
    (if (null? todo)
      done
      (reverse-iter (cons (car todo) done) (cdr todo))))
  (reverse-iter nil lst))

(define (split-at lst n)
  (define (helper re-prev lst n)
    (if (or (null? lst) (= 0 n))
	  (cons (reverse re-prev) lst)
	  (helper (cons (car lst) re-prev) (cdr lst) (- n 1))))
  (helper nil lst n))


(define-macro (switch expr cases)
  (cons 'cond
    (map (lambda (case) (cons (eq? (eval expr) (car case)) (cdr case)))
      cases)))
