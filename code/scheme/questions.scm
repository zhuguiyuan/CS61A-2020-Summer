(define (caar x) (car (car x)))

(define (cadr x) (car (cdr x)))

(define (cdar x) (cdr (car x)))

(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.
(define (cons-all first rests)
  (map (lambda (rest) (cons first rest)) rests))

(define (zip pairs)
  (if (null? pairs)
      (list nil nil)
      (list (cons (caar pairs) (car (zip (cdr pairs))))
            (cons (car (cdar pairs)) (cadr (zip (cdr pairs)))))))

(define (reverse lst)
  (define (reverse-iter done todo)
    (if (null? todo)
        done
        (reverse-iter (cons (car todo) done) (cdr todo))))
  (reverse-iter nil lst))

; ; Problem 16
; ; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
  (define (helper x s re-ans)
    (if (null? s)
        (reverse re-ans)
        (helper (+ x 1)
                (cdr s)
                (cons (list x (car s)) re-ans))))
  (helper 0 s nil))

; END PROBLEM 16
; ; Problem 17
; ; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  (cond 
    ((= total 0)
     (list nil))
    ((or (< total 0) (null? denoms))
     nil)
    (else
     (let ((with_first (cons-all (car denoms)
                                 (list-change (- total (car denoms)) denoms)))
           (without_first (list-change total (cdr denoms))))
       (append with_first without_first)))))

; END PROBLEM 17
; ; Problem 18
; ; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))

(define define? (check-special 'define))

(define quoted? (check-special 'quote))

(define let? (check-special 'let))

; ; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond 
    ((atom? expr)
     ; BEGIN PROBLEM 18
     expr
     ; END PROBLEM 18
    )
    ((quoted? expr)
     ; BEGIN PROBLEM 18
     expr
     ; END PROBLEM 18
    )
    ((or (lambda? expr) (define? expr))
     (let ((form (car expr))
           (params (cadr expr))
           (body (cddr expr)))
       ; BEGIN PROBLEM 18
       (cons form (cons params (let-to-lambda body)))
       ; END PROBLEM 18
     ))
    ((let? expr)
     (let ((values (cadr expr))
           (body (cddr expr)))
       ; BEGIN PROBLEM 18
       (define formals-values (zip values))
       (cons (cons 'lambda
                   (cons (car formals-values) (let-to-lambda body)))
             (let-to-lambda (cadr formals-values)))
       ; END PROBLEM 18
     ))
    (else
     ; BEGIN PROBLEM 18
     (map let-to-lambda expr)
     ; END PROBLEM 18
    )))

; ; Convert itself to from without let
; (define (let-to-lambda expr)
;   (cond 
;     ((atom? expr)
;      expr)
;     ((quoted? expr)
;      expr)
;     ((or (lambda? expr) (define? expr))
;      ((lambda (form params body)
;         (cons form (cons params (let-to-lambda body))))
;       (car expr)
;       (cadr expr)
;       (cddr expr)))
;     ((let? expr)
;      ((lambda (values body)
;         (define formals-values (zip values))
;         (cons (cons (quote lambda)
;                     (cons (car formals-values) (let-to-lambda body)))
;               (let-to-lambda (cadr formals-values))))
;       (cadr expr)
;       (cddr expr)))
;     (else
;      (map let-to-lambda expr))))
