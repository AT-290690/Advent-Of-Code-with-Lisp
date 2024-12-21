(let INPUT
"p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3")

(let parse (lambda input
    (|> input
        (string:lines)
        (array:map (lambda x
            (|> x (string:words) (array:map (lambda x (|> x (array:drop 2)  (string:commas) (from:strings->numbers))))))))))

(let part1 (lambda input (do
    (let WIDTH 11)
    (let HEIGHT 7)

    (let QWIDTH (math:floor (* WIDTH 0.5)))
    (let QHEIGHT (math:floor (* HEIGHT 0.5))) 
    ; 0 - 4 5 6 - 10
    ; .....+..... 0
    ; .....+..... 1
    ; .....+..... 2 
    ; +++++++++++ 3
    ; .....+..... 4 
    ; .....+..... 5
    ; .....+..... 6
    (let Q1 '('(0 0) '((- QWIDTH 1) (- QHEIGHT 1))))
    (let Q2 '('((+ QWIDTH 1) 0) '((- WIDTH 1) (- QHEIGHT 1))))
    (let Q3 '('(0 (+ QHEIGHT 1)) '((- QWIDTH 1) (- HEIGHT 1))))
    (let Q4 '('((+ QWIDTH 1) (+ QHEIGHT 1)) '((- WIDTH 1) (- HEIGHT 1))))

    (|> input
        (array:map (lambda robot (do
            (let pos (array:first robot))
            (let vel (array:second robot))
            (let x (array:first pos))
            (let y (array:second pos))
            (let dx (array:first vel))
            (let dy (array:second vel))

            (array (math:euclidean-mod (+ x (* dx 100)) WIDTH) 
                   (math:euclidean-mod (+ y (* dy 100)) HEIGHT)))))
        (array:fold (lambda a b (do
            (let x (array:first b))
            (let y (array:second b))
        (cond
            (and
                (math:overlap? x (array:first (array:first Q1)) (array:first (array:second Q1)))
                (math:overlap? y (array:second (array:first Q1)) (array:second (array:second Q1)))
                )  (set! a 0 (+ (get a 0) 1))
           (and
                (math:overlap? x (array:first (array:first Q2)) (array:first (array:second Q2)))
                (math:overlap? y (array:second (array:first Q2)) (array:second (array:second Q2)))
                )  (set! a 1 (+ (get a 1) 1))
            (and
                (math:overlap? x (array:first (array:first Q3)) (array:first (array:second Q3)))
                (math:overlap? y (array:second (array:first Q3)) (array:second (array:second Q3)))
                )  (set! a 2 (+ (get a 2) 1))
            (and
                (math:overlap? x (array:first (array:first Q4)) (array:first (array:second Q4)))
                (math:overlap? y (array:second (array:first Q4)) (array:second (array:second Q4)))
                )  (set! a 3 (+ (get a 3) 1))
            (*) 0) a)) '(0 0 0 0))
        (math:product)))))

(let PARSED (parse INPUT))

'((part1 PARSED))
