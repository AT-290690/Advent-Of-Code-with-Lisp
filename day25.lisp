(let INPUT "
#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####
")

(let parse (lambda input (|> input (string:trim) (string:lines) (array:append! []) (array:chunks array:empty?))))

(let part1 (lambda input (do
    (let M (- (length (array:first input)) 2))
    (let handle-lock (lambda a (array:slice a 1 (length a))))
    (let handle-key (lambda a (array:slice a 0 (- (length a) 1))))
    (let from:heights->height (lambda heights cb (do 
        (let h (math:zeroes (length (array:first heights))))
        (array:for (cb heights) (lambda x (do 
            (array:enumerated-for x (lambda y i (do 
                (set! h i (math:max (get h i) y)))))))) h)))

    (let fit? (lambda pairs (do 
        (|> pairs (array:map (lambda [lock key .] 
                  (|> (array:zip lock key) 
                    (array:map (lambda x (- M (tuple:add x)))) 
                    (array:some? (lambda a (< a 0))) 
                    (not)))) (math:summation)))))
    (let LOCK 0)
    (let KEY 1)
    (let lock? (lambda x (array:some? (get x 0) (lambda y (= y char:dot)))))
    (let from:key->heights (lambda matrix (|> matrix (array:enumerated-map (lambda y i (|> y (array:map (lambda c (if (= c char:hash) i -1)))))))))
    (let from:lock->heights (lambda matrix (|> matrix (array:enumerated-map (lambda y i (|> y (array:map (lambda c (if (= c char:hash) (- (length y) i 1) -1)))))))))
    (let heights (|> input (array:map (lambda x
        (if (lock? x)
        [KEY (|> x (from:lock->heights) (from:heights->height handle-lock))]
        [LOCK (|> x (from:key->heights) (from:heights->height handle-key))])))))

    (let locks (|> heights (array:select (lambda x (= (array:first x) LOCK))) (array:map array:second)))
    (let keys (|> heights (array:select (lambda x (= (array:first x) KEY))) (array:map array:second)))

    (|> (math:cartesian-product locks keys) (fit?)))))

(let PARSED (parse INPUT))

[(part1 PARSED)]
