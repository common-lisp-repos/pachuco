(define (main)
  (define command (read stdin))
  (define files (read stdin))
  (cond ((eq? command 'expand) (do-expand-files files))
        ((eq? command 'interpret) (do-interpret-files files (read stdin)))
        ((eq? command 'compile) (do-compile-files files (read stdin)))))