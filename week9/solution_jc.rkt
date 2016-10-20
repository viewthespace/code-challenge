#lang racket
(require rackunit)

(define (holy-trinity nums prev)
  (let ([sorted (sort nums >)])
  (cond
    [(empty? sorted) sorted]
    [(eq? (first sorted) prev) (holy-trinity (rest sorted) (first sorted))]
    [else (first sorted)])))

(check-eq? (holy-trinity '(3 5 6 3 2 2 8 6 5 5 5) null) 8)
(check-eq? (holy-trinity '(1 4 2 3 1 5 2 4 3) null) 5)

(define (holy-trinity-dos nums)
  (foldr bitwise-xor 0 nums))

(holy-trinity-dos '(3 5 6 3 2 2 8 6 5 5 5))
(holy-trinity-dos '(1 4 2 3 1 5 2 4 3))

(check-eq? (holy-trinity-dos '(3 5 6 3 2 2 8 6 5 5 5)) 8)
(check-eq? (holy-trinity-dos '(1 4 2 3 1 5 2 4 3)) 5)