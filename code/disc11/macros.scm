(define-macro (or-macro expr1 expr2)
  `(let ((v1 ,expr1))
        (if v1 v1 ,expr2)))


(define-macro (prune-expr expr)
  (define (helper lst f)
    (cond
      ((null? lst) lst)
      ((= f 0) (cons (car lst) (helper (cdr lst) 1)))
      ((= f 1) (helper (cdr lst) 0))))
  (cons (car expr) (helper (cdr expr) 0)))


(define-macro (when condition exprs)
  (list 'if (list 'not condition) ''okay (cons 'begin exprs)))


(define-macro (when condition exprs)
  `(if (not ,condition) 'okay ,(cons 'begin exprs)))
