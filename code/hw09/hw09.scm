(define (reverse lst)
  (define (reverse-iter done todo)
    (if (null? todo)
      done
      (reverse-iter (cons (car todo) done) (cdr todo))))
  (reverse-iter nil lst)
)
