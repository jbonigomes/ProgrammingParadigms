#lang racket

; 1. What do the following Racket expressions evaluate to?

; (* 2 (+ 4 5))
; 
; (= 3 (+ 1 3))
; 
; (car '(elmer fudd daffy duck))
; 
; (cdr '(elmer fudd daffy duck))
; 
; (and (= 1 2) (= 10 (/ 1 0)))



; 2. Find the squid! For each of the following variables, write an expression
; that picks out the symbol squid. For example, for this definition:
; (define x '(squid clam octopus)) the answer is (car x)

; (define w '(clam squid octopus))
; (car (cdr w))
; (cadr w)
; 
; (define z '(clam starfish (squid octopus) mollusc))
; (car (car (cdr (cdr z))))
; (caaddr z)



; 3. Define a Racket function to find the average of two numbers.

; (define (average x y) (/ (+ x y) 2))
; (average 4 8)



; 4. Define a Racket function mymax to find the maximum of two numbers.

; (define (mymax x y) (if (> x y) x y))
; (mymax 10 12)



; 5. Suppose we evaluate the following Racket expressions:

; (define x '(snail clam))
; (define y '(octopus squid scallop))


; Draw box-and-arrow diagrams of the result of evaluating the following
; expressions. What parts of the list are created fresh, and which are
; shared with the variables x and y?

; (cons 'geoduck x)
; (cons y y)
; (append x y)
; (cdr y)



; 6. Define a recursive function sum to find the sum of the numbers in a list.

; (define (mysum x) (if (null? x) 0 (+ (car x) (mysum (cdr x)))))
; (mysum '(1 2 3 4))



; 7. Define a tail recursive version of sum. (Define an auxiliary function if needed.)

; (define (sum s) (sum-helper s 0))
; (define (sum-helper s sofar) (if (null? s) sofar (sum-helper (cdr s) (+ (car s) sofar))))
; (sum '(1 2 3 4))



; 8. What is the result of evaluating the following Racket expressions?

; (let ((x (+ 2 4)) (y 100)) (+ x y))
; (let ((x 100) (y 5)) (let ((x 1))(+ x y)))



; 9. Define a function mylength to find the length of a list.

; (define (mylength x) (if (null? x) 0 (+ 1 (mylength (cdr x)))))
; (mylength '(1 2 3 4))



; Repeatedly do the following:
;   Find a location containing a singleton set (a set containing just one number).
;     For every other set in the same row, the same column, or the same 3x3 box,
;     remove that number (if preset).
;   Find a number in a set that does not occur in any other set in the same row
;   (or column, or box).
;     Reduce that set to a singleton containing that one number.
; Quit when every set is a singleton, or when no more numbers can be removed
; from any set.

; (append '(2) (list 4))

(define (transform matrix)
  (map (lambda (list)
         (map (lambda (number)
                (if (= 0 number)
                    (build-list 9 (lambda (x) (+ 1 x)))
                    number)) list)) matrix))

(define (solve matrix)
  (transform matrix))

(solve '((0 2 5 0 0 1 0 0 0)
         (1 0 4 2 5 0 0 0 0)
         (0 0 6 0 0 4 2 1 0)
         (0 5 0 0 0 0 3 2 0)
         (6 0 0 0 2 0 0 0 9)
         (0 8 7 0 0 0 0 6 0)
         (0 9 1 5 0 0 6 0 0)
         (0 0 0 0 7 8 1 0 3)
         (0 0 0 6 0 0 5 9 0)))
