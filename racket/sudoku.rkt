#lang racket

; Please accept my sincere apologies, for I did not have enough time to
; implement most of this agorithm

(define n 5)
(define x 1)
(define y 1)

(define (transform matrix)
  (map (lambda (list)
         (map (lambda (number)
                (if (= 0 number)
                    (build-list 9 (lambda (x) (+ 1 x)))
                    number)) list)) matrix))

(define (solve matrix)
  (test (transform matrix) n x y))

(solve '((0 2 5 0 0 1 0 0 0)
         (1 0 4 2 5 0 0 0 0)
         (0 0 6 0 0 4 2 1 0)
         (0 5 0 0 0 0 3 2 0)
         (6 0 0 0 2 0 0 0 9)
         (0 8 7 0 0 0 0 6 0)
         (0 9 1 5 0 0 6 0 0)
         (0 0 0 0 7 8 1 0 3)
         (0 0 0 6 0 0 5 9 0)))
