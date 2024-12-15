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
    (let TIMES 25)
    (let memo (new:set64))
    (let from:num-and-n->key (lambda b n '(b n)))
    (let count (lambda b n (do
             (let key (from:num-and-n->key b n))
             (if (map:has? memo key) (map:get memo key)
                 (map:set-and-get! memo key (cond 
                    (= n 0) 1
                    (= b 0) (count 1 (- n 1))
                    (math:even? (length (from:number->digits b))) (do 
                    (let str (from:number->digits b))
                    (let n-digits (length str))
                    (let half (/ n-digits 2))
                    (let left (|> str (array:slice 0 half) (from:digits->number)))
                    (let right (|> str (array:slice half (length str)) (from:digits->number)))
                    (+ (count left (- n 1)) (count right (- n 1))))
                    (*) (count (* b 2024) (- n 1))))))))
    (|> input (array:map (lambda x (count x TIMES))) (math:summation)))))

(let PARSED (parse INPUT))

'((part1 PARSED) (part2 PARSED))