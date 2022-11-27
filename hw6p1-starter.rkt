;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname hw6p1-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; == Homework 6, Problem 1 ==

; Consider the following functions:


; good-job : [List-of NonNegReal] -> [List-of NonNegReal]
; adds 20% to all supplied costs

(check-expect
 (good-job '())
 '())

(check-expect
 (good-job
  (cons 10 (cons 5 '())))
 (cons 12 (cons 6 '())))

(define (good-job lon)
(apply-all lon '() cons add-thanks))


; add-thanks : NonNegReal -> NonNegReal
; adds 20% to the supplied cost

(check-expect (add-thanks 10) 12)
(check-expect (add-thanks 5) 6)

(define (add-thanks cost)
  (* cost 1.2))


; total-length : [List-of String] -> Nat
; returns the total length of all strings in the list

(check-expect
 (total-length
  '())
 0)

(check-expect
 (total-length
  (cons "a" (cons "bb" '())))
 3)

(define (total-length los)
(apply-all los 0 + string-length))


; TODO #1: abstract good-job and total-length.
; Be sure to re-define the functions using your new
; abstraction.

; apply-all: (X,Y,Z) [List-of X] Z [Y -> Z] [X -> Y]  -> Z
; apply the funtions to all the elements in the list 

(check-expect (apply-all



(define (apply-all lox ep fuction value) 
  (cond
    [(empty? lox) ep]
    [(cons? lox)
     (fuction
      (value (first lox))
      (apply-all (rest lox) ep fuction value))]))


; TODO #2: use your new function to design the function
; acronym-image, which takes in a list of strings and
; visualizes them vertically stacked, with the first
; letter bolded (to highlight the acronym). The above/align
; function will be quite useful, as will the "modern" font
; (which is fixed-width, so all letters line up nicely).
; You can assume all supplied strings will have at least
; two letters.

; acronym-image: [List-of String] -> Image
; visualize the list of string vertically with bold first letter

(check-expect (acronym-image (cons "Hello" (cons "Good" '())))
              (above/align "left" (beside (text/font "H" 10 "black" #f "modern" "normal" "bold" #f)
                             (text/font "ello" 10 "black" #f "modern" "normal" "normal" #f))
                     (above/align "left" (beside (text/font "G" 10 "black" #f "modern" "normal" "bold" #f)
                                    (text/font "ood" 10 "black" #f "modern" "normal" "normal" #f))
                            (text "" 1 "white"))))


(check-expect (acronym-image (cons "Name" (cons "First" '())))
              (above/align "left" (beside (text/font "N" 10 "black" #f "modern" "normal" "bold" #f)
                             (text/font "ame" 10 "black" #f "modern" "normal" "normal" #f))
                     (above/align "left" (beside (text/font "F" 10 "black" #f "modern" "normal" "bold" #f)
                                    (text/font "irst" 10 "black" #f "modern" "normal" "normal" #f))
                            (text "" 1 "white"))))

(check-expect (acronym-image '()) (text "" 1 "white"))


(define (acronym-image los)
(apply-all los (text "" 1 "white") above+align text/string))


; above+align: Image -> Image 
; put text above another text left aligned

(check-expect (above+align (text "hello" 10 "red") (text "hi" 10 "red"))
                (above/align "left" (text "hello" 10 "red") (text "hi" 10 "red")))

(check-expect (above+align (text "good" 10 "red") (text "boy" 10 "red"))
                (above/align "left" (text "good" 10 "red") (text "boy" 10 "red")))

(define (above+align a b)
  (above/align "left" a b))


; text/string : String -> Image
; visualize the string with bold first letter

(check-expect (text/string "Boy")
              (beside (text/font "B" 10 "black" #f "modern" "normal" "bold" #f)
          (text/font "oy" 10 "black" #f "modern" "normal" "normal" #f)))

(check-expect (text/string "Boy")
              (beside (text/font "B" 10 "black" #f "modern" "normal" "bold" #f)
          (text/font "oy" 10 "black" #f "modern" "normal" "normal" #f)))

(define (text/string s)
  (beside (text/font (substring s 0 1) 10 "black" #f "modern" "normal" "bold" #f)
          (text/font (substring s 1 (string-length s)) 10 "black" #f "modern" "normal" "normal" #f)))



(acronym-image (cons "Hello" (cons "Good" (cons "Happy" '()))))


