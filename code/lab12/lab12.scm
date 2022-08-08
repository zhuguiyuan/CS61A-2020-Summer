
(define-macro (def func args body)
  `(define ,(cons func args) ,body))


(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define all-three-multiples
  (cons-stream 3 (map-stream (lambda (x) (+ 3 x)) all-three-multiples))
)


(define (compose-all funcs)
  (define (helper funcs x)
    (if (null? funcs) x (helper (cdr funcs) ((car funcs) x))))
  (lambda (x) (helper funcs x))
)


(define (partial-sums stream)
  (define (helper sum stream)
    (if (null? stream)
      stream
      (let ((new-sum (+ sum (car stream))))
        (cons-stream new-sum (helper new-sum (cdr-stream stream))))))
  (helper 0 stream)
)

