(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cddr s))
)


(define (sign num)
  (cond
    ((< 0 num) 1)
    ((> 0 num) -1)
    (else 0))
)


(define (square x) (* x x))

(define (pow x y)
  (define (pow-iter base x y)
    (cond
      ((= y 0) base)
      ((even? y) (pow-iter base (square x) (quotient y 2)))
      (else (pow-iter (* base x) (square x) (quotient y 2)))))
  (pow-iter 1 x y)
)


(define (unique s)
  (if (null? s)
    s
    (cons (car s)
	  (unique 
	    (filter 
	      (lambda (x) (not (equal? (car s) x)))
	      (cdr s)))))
)


(define (replicate x n)
  (define (replicate-iter now i)
    (if (= i 0)
      now
      (replicate-iter (cons x now) (- i 1))))
  (replicate-iter nil n)
)


(define (accumulate combiner start n term)
  (if (= n 0)
    start
    (combiner 
      (term n)
      (accumulate combiner start (- n 1) term)))
)


(define (accumulate-tail combiner start n term)
  (define (helper i ans)
    (if (< n i)
      ans
      (helper (+ 1 i) (combiner ans (term i)))))
  (helper 1 start)
)


(define-macro (list-of map-expr for var in lst if filter-expr)
  `(map (lambda (,var) ,map-expr) (filter (lambda (,var) ,filter-expr) ,lst))
)

