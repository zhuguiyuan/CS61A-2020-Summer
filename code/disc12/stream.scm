(define (naturals n)
  (cons-stream n (naturals (+ n 1))))

(define nat (naturals 0))

(define (filter-stream f s)
  (cond
    ((null? s) nil)
    ((f (car s)) (cons-stream (car s) (filter-stream f (cdr-stream s))))
    (else (filter-stream f (cdr-stream s)))))

(define (map-stream f s)
  (cond
    ((null? s) nil) 
    (else (cons-stream (f (car s)) (map-stream f (cdr-stream s))))))

(define evens (map-stream (lambda (x) (* x 2)) nat))

(define (prefix-stream n s)
  (define (helper re-prefix n s)
    (if (or (null? s) (= 0 n))
      (reverse re-prefix)
      (helper (cons (car s) re-prefix) (- n 1) (cdr-stream s))))
  (helper nil n s))

(define (reverse lst)
  (define (reverse-iter done todo)
    (if (null? todo)
      done
      (reverse-iter (cons (car todo) done) (cdr todo))))
  (reverse-iter nil lst))

(define (range-stream start end)
  (define (helper now)
    (if (= end now) nil
    (cons-stream now (helper (+ now 1)))))
  (helper start))

; Some Tests

; test prefix-stream
; (print (prefix-stream 100 nil))
; (print (prefix-stream 100 (cons-stream 1 nil)))

; test naturals nat map-stream evens prefix-stream reverse
; (print (prefix-stream 400 evens))

; test range-stream
; (print (prefix-stream 100 (range-stream 0 10)))

; test filter-stream
; (print
;  (prefix-stream 10 
;     (filter-stream (lambda (x) (> x 5)) (range-stream 0 10))))

; test filter-stream
; (define evens (filter-stream (lambda (x) (zero? (modulo x 2))) nat))
; (print (prefix-stream 400 evens))

(define (slice s start end)
  (define (helper re-prev i s)
   (cond
     ((or (null? s) (>= i end)) (reverse re-prev))
     ((< i start) (helper re-prev (+ i 1) (cdr-stream s)))
     (else (helper (cons (car s) re-prev) (+ i 1) (cdr-stream s)))))
  (helper nil 0 s))

; test slice
; (print (slice nat 4 12))
; (print (slice nil 20 30))
; (print (slice (range-stream 0 10) 0 9))
; (print (slice (range-stream 0 10) 0 10))

(define (combine-with f xs ys)
  (if (or (null? xs) (null? ys))
    nil
    (cons-stream
      (f (car xs) (car ys))
      (combine-with f (cdr-stream xs) (cdr-stream ys)))))

; test combine-with
; (define evens (combine-with + (naturals 0) (naturals 0)))
; (print (slice evens 0 10))

(define factorials
  (cons-stream 1 (combine-with * (naturals 1) factorials)))

; test factorials
; (print (slice factorials 0 10))

(define fibs
  (cons-stream 0
    (cons-stream 1
      (combine-with + fibs (cdr-stream fibs)))))

; test fibs
; (print (slice fibs 0 10))

(define (exp x)
  (let
    ((item (combine-with
                (lambda (a b) (/ (expt x a) b))
                (cdr-stream (naturals 0))
                (cdr-stream factorials))))
    (cons-stream
      1 (combine-with + item (exp x)))))

; test exp
; (print (slice (exp 2) 0 5))

(define (sieve s)
  (cons-stream
    (car s)
    (filter-stream
      (lambda (x) (not (zero? (remainder x (car s)))))
      (cdr-stream s))))


(define primes (sieve (naturals 2)))

; test primes
; (print (slice primes 0 10))
; '(2 3 5 7 9 11 13 15 17 19)
