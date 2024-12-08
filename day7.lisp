(let INPUT (array:concat-with '(
"190: 10 19"
"3267: 81 40 27"
"83: 17 5"
"156: 15 6"
"7290: 6 8 6 15"
"161011: 16 10 13"
"192: 17 8 14"
"21037: 9 7 18 13"
"292: 11 6 16 20"
) char:new-line))
(let parse (lambda input (do 
    (let lines (|> input (string:lines) (array:map (lambda x (do 
    (let sides (|> x (string:split (array:first ":"))))
    (let L (|> sides (array:first) (from:chars->digits) (from:digits->number)))
    (let R (|> sides (array:second) (string:words) (array:exclude array:empty?) (from:array->list) (list:map (lambda x (|> x (from:chars->digits) (from:digits->number))))))
    '(L R)))))))))

(let part1 (lambda input (do 
    (let solve (lambda args out (do 
        (if (list:nil? (list:tail args)) (= out (list:head args))
            (cond
                (and (= (mod out (list:head args)) 0) (solve (list:tail args) (/ out (list:head args)))) 1
                (and (> out (list:head args)) (solve (list:tail args) (- out (list:head args)))) 1
                (*) 0)))))
    (|> input 
        (array:map (lambda x (do 
            (let left (array:first x))
            (let right (list:reverse (array:second x)))
            '(left (solve right left)))))
            (array:select (lambda x (= (array:second x) 1)))
            (array:map array:first)
            (math:summation)))))
(let PARSED (parse INPUT))
'((part1 PARSED))
