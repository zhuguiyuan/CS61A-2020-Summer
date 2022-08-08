(define (rle s)
  (define (helper curr len s)
    (cond
      ((null? s) (cons-stream (list curr len) nil))
      ((= curr (car s)) (helper curr (+ 1 len) (cdr-stream s)))
      (else (cons-stream (list curr len) (helper (car s) 1 (cdr-stream s))))))
  (if (null? s) 
    nil
    (helper (car s) 1 (cdr-stream s))))

(define (reverse lst)
  (define (reverse-iter done todo)
    (if (null? todo)
      done
      (reverse-iter (cons (car todo) done) (cdr todo))))
  (reverse-iter nil lst))

(define (group-by-nondecreasing s)
    (define (next-group re-lst curr s)
      ; return (list a-group rest-stream)
      (if (or (null? s) (> curr (car s)))
        (list (reverse re-lst) s)
        (next-group (cons (car s) re-lst) (car s) (cdr-stream s))))
    (define (group-stream s)
      (if (null? s)
        nil
        (let ((next-pkg (next-group (list (car s)) (car s) (cdr-stream s))))
          (cons-stream (car next-pkg) (group-stream (car (cdr next-pkg))))
        )))
    (group-stream s))

(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

