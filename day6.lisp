(let INPUT (array:concat-with '(
  "....#....."
  ".........#"
  ".........."
  "..#......."
  ".......#.."
  ".........."
  ".#..^....."
  "........#."
  "#........."
  "......#..."
) char:new-line))
(let parse (lambda input (|> input (string:lines))))
(let part1 (lambda input (do 
(let dir '('(-1 0) '(0 1) '(1 0) '(0 -1)))
(let starting (matrix:find-index input (lambda x (= x 94))))
(matrix:set! input (get starting 0) (get starting 1) char:X)
(let from:matrix->string (lambda matrix (array:lines (array:map matrix (lambda m (array:map m array))))))
(let rec:step (lambda start angle (do 
    (let current-dir (get dir (mod angle (length dir))))
    (let start-copy (array:shallow-copy start))
    (set! start-copy 0 (+ (get start-copy 0) (get current-dir 0)))
    (set! start-copy 1 (+ (get start-copy 1) (get current-dir 1)))
    (let y (get start-copy 0))
    (let x (get start-copy 1))
    (if (matrix:in-bounds? input y x) (do 
    (let current (matrix:get input y x))
    (if (not (= current char:hash)) (matrix:set! input y x char:X))
    (cond 
        (= current char:hash) (rec:step start (+ angle 1))
        (or (= current char:dot) (= current char:X)) (rec:step start-copy angle))))))
)
(rec:step starting 0)
(|> input (array:flat-one) (array:count char:X))
)))
(let PARSED (parse INPUT))
'((part1 PARSED))