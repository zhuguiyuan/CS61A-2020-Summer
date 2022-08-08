(define-macro (make-lambda expr)
  `(lambda () ,expr))

(define-macro (make-stream first second)
  `(list ,first (make-lambda ,second))
)

(define (cdr-stream stream)
  ((car (cdr stream))))

; test make-lambda make-stream cdr-stream
; (define x (make-stream 10 nil))
; (car x)
; (cdr-stream x)
; (define a (make-stream (print 1) (make-stream (print 2) nil))))
; (define b (cdr-stream a))