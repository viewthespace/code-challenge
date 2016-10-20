;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname solution_jc) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (holy-trinity nums prev)
  (let ([sorted (sort nums >)])
  (cond
    [(empty? sorted) sorted]
    [(eq? (first sorted) prev) (holy-trinity (rest sorted) (first sorted))]
    [else (first sorted)])))

(check-expect (holy-trinity '(3 5 6 3 2 2 8 6 5 5 5) null) 8)
(check-expect (holy-trinity '(1 4 2 3 1 5 2 4 3) null) 5)
