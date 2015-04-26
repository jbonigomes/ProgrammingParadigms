#lang racket

; Repeatedly do the following:
;   Find a location containing a singleton set (a set containing just one number).
;     For every other set in the same row, the same column, or the same 3x3 box,
;     remove that number (if preset).
;   Find a number in a set that does not occur in any other set in the same row
;   (or column, or box).
;     Reduce that set to a singleton containing that one number.
; Quit when every set is a singleton, or when no more numbers can be removed
; from any set.

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
