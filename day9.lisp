(let INPUT "2333133121414131402")

(let part1 (lambda input (do 
    (let arrangement (array:enumerated-fold input (lambda a x i (do 
        (let digit (from:char->digit x))
        (loop:for-n digit (lambda . (array:push! a (if (math:even? i) (from:digit->char (mod (/ i 2) 10)) char:dot))) )
        a
    )) ()))
   (let dots-count (array:count arrangement char:dot))
   (let first->last (|> arrangement (array:enumerated-map (lambda x i (if (<> x char:dot) i -1))) (array:exclude math:negative?)))
   (let last->first (array:reverse first->last))
   (let out (array:fold arrangement (lambda a b (do 
        (if (= b char:dot) (array:push! a (get arrangement (array:pop! first->last))) (array:push! a (get arrangement (array:pop! last->first))))
        a
    )) ()))
    (array:enumerated-fold (array:slice out 0 (- (length out) dots-count)) (lambda a b i (+ a (* i (from:char->digit b)))) 0)
)))

'((part1 INPUT))