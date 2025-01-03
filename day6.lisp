(let INPUT 
"....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...")

(let parse (lambda input (|> input (string:lines))))

(let dir [[-1 0] [0 1] [1 0] [0 -1]])

(let part1 (lambda input (do
  (let matrix (matrix:shallow-copy input)) 
  (let starting (matrix:find-index input (lambda x (= x 94))))
  (matrix:set! matrix (get starting 0) (get starting 1) char:X)
  (let from:matrix->string (lambda matrix (array:lines (array:map matrix (lambda m (array:map m array))))))
  (let recursive:step (lambda start angle (do 
      (let current-dir (get dir (mod angle (length dir))))
      (let start-copy (array:shallow-copy start))
      (set! start-copy 0 (+ (get start-copy 0) (get current-dir 0)))
      (set! start-copy 1 (+ (get start-copy 1) (get current-dir 1)))
      (let [y x .] start-copy)
      (if (matrix:in-bounds? matrix y x) (do 
      (let current (matrix:get matrix y x))
      (if (not (= current char:hash)) (matrix:set! matrix y x char:X))
      (cond
          (= current char:hash) (recursive:step start (+ angle 1))
          (or (= current char:dot) (= current char:X)) (recursive:step start-copy angle)))))))
  (recursive:step starting 0)
  (|> matrix (array:flat-one) (array:count char:X)))))

(let part2 (lambda input (do
  (let matrix (matrix:shallow-copy input)) 
  (let loops (var:def 0))
  (let starting (matrix:find-index matrix (lambda x (= x 94))))
  (matrix:set! matrix (get starting 0) (get starting 1) char:X)
  (let from:matrix->string (lambda matrix (array:lines (array:map matrix (lambda m (array:map m array))))))
  (let from:numbers->key (lambda a b (array:concat '((from:digits->chars (from:number->digits a)) '(char:pipe) (from:digits->chars (from:number->digits b))))))
  (let recursive:step (lambda matrix start angle corners (do 
      (let current-dir (get dir (mod angle (length dir))))
      (let start-copy (array:shallow-copy start))
      (set! start-copy 0 (+ (get start-copy 0) (get current-dir 0)))
      (set! start-copy 1 (+ (get start-copy 1) (get current-dir 1)))
      (let [y x .] start-copy)
      (if (matrix:in-bounds? matrix y x) (do 
      (let current (matrix:get matrix y x))
      (if (not (= current char:hash)) (matrix:set! matrix y x char:X))
      (cond 
          (= current char:hash) (do
          (let key (from:numbers->key y x))
          (let c (map:get corners key))
          (if (= c 4) 
          (var:set! loops (+ (var:get loops) 1))
          (recursive:step matrix start (+ angle 1) (map:set! corners key (+ c 1)))))
          (or (= current char:dot) (= current char:X)) (recursive:step matrix start-copy angle corners)))))))
  (recursive:step matrix starting 0 (new:set64))
  (let path [])
  (let [Y X .] starting)
  (matrix:enumerated-for matrix (lambda current y x (if
      (= current char:X) (array:push! path '(y x)))))
  (array:for path (lambda pos (do
      (let copy (matrix:shallow-copy input))
      (let y (get pos 0))
      (let x (get pos 1))
      (matrix:set! copy Y X char:X)
      (matrix:set! copy y x char:hash)
      (if (not (and (= y Y) (= x X))) (recursive:step copy starting 0 (new:set64))))))
  (var:get loops))))
  
(let PARSED (parse INPUT))

'((part1 PARSED) (part2 PARSED))