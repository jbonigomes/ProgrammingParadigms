#lang racket

(define solve (matrix))

(define transform (matrix))

;; my first piece of racket
;; from [http://pasterack.org/pastes/34652]

;; (define (not-empty? lst)
;;   (not (empty? lst)))
 
;; (define (divideable? n m)
;;   (integer? (/ n m)))
 
;; (define (is-prime-for-list? n lst)
;;   (not (or (divideable? n (first lst))
;;       (and (not-empty? (rest lst))
;;            (is-prime-for-list? n (rest lst))))))
 
;; (define (is-prime? n)
;;   (let ([lst (build-list (- n 2) (lambda (x) (+ n 2)))])
;;     (is-prime-for-list? n lst)))
 
;; (is-prime? 3)
;; (is-prime? 4)
;; (is-prime? 5)
;; (is-prime? 6)
