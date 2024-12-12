(let INPUT "125 17")
(let parse (lambda input (|> input (string:words) (array:map (lambda x (|> x (from:chars->digits) (from:digits->number)))))))

; If the stone is engraved with the number 0, it is replaced by a stone engraved with the number 1.
; If the stone is engraved with a number that has an even number of digits, it is replaced by two stones. The left half of the digits are engraved on the new left stone, and the right half of the digits are engraved on the new right stone. (The new numbers don't keep extra leading zeroes: 1000 would become stones 10 and 0.)
; If none of the other rules apply, the stone is replaced by a new stone; the old stone's number multiplied by 2024 is engraved on the new stone.
(let part1 (lambda input (do 
  (let TIMES 5)
  (let rec:while (lambda stones n (unless (= n 0) 
      (rec:while (array:fold stones (lambda a b (do
          (let n-digits (math:number-of-digits b))
          (array:merge! a 
                (cond 
                  (= b 0) '(1)
                  (math:even? n-digits) '((math:remove-nth-digits b (/ n-digits 2)) (math:keep-nth-digits b (/ n-digits 2)))
                  (*) '((* b 2024)))))) ()) (- n 1)) (length stones))))
  (rec:while input TIMES))))

(let part2 (lambda input (do 
  (let TIMES 5)
  (let rec:while (lambda stones n (unless (= n 0) 
      (rec:while (array:fold stones (lambda a b (do
          (let n-digits (math:number-of-digits b))
          (array:merge! a 
                (cond 
                  (= b 0) '(1)
                  (math:even? n-digits) '((math:remove-nth-digits b (/ n-digits 2)) (math:keep-nth-digits b (/ n-digits 2)))
                  (*) '((* b 2024)))))) ()) (- n 1)) (length stones))))
  (rec:while input TIMES))))

(let PARSED (parse INPUT))
'((part1 PARSED) (part2 PARSED))