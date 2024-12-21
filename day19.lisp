(let INPUT 
"r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb")

(let parse (lambda input (do 
    (let lines (|> input (string:lines)))
    '(
        (|> lines (array:first) (string:commas) (array:map string:trim)) 
        (|> lines (array:slice 2 (length lines)))))))


(let part1 (lambda input (do 

(let patterns (array:fold (array:first input) (lambda a b (set:add! a b)) (new:set8)))
(let towels (array:second input))
(let memo (new:set32))

(let loop:some-range? (lambda start end predicate? (do
                          (let rec:iterate (lambda i
                          (if (< i end)
                                (if (predicate? i) 1 (rec:iterate (+ i 1))))))
                          (rec:iterate start))))


(let dp (lambda str (do 
    (if (map:has? memo str) (map:get memo str)
        (or (loop:some-range? 1 (length str) (lambda i (do 
            (let a (array:slice str 0 i))
            (let b (array:slice str i (length str)))
            (if (and (set:has? patterns a) (set:has? patterns b))
            (map:set-and-get! memo str 1)
            (if (and (dp a) (dp b)) (map:set-and-get! memo str 1)))
        ))) (map:set-and-get! memo str 0))))))
(array:count-of towels dp))))

(let PARSED (parse INPUT))

'((part1 PARSED))