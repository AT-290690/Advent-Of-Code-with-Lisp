(let INPUT (array:concat-with '(
  "89010123"
  "78121874"
  "87430965"
  "96549874"
  "45678903"
  "32019012"
  "01329801"
  "10456732"
) char:new-line))
(let parse (lambda input (|> input (string:lines) (array:map from:chars->digits))))
(let part1 (lambda input (do 
  (let coords ())
  (let from:chars->key (lambda a b (array:concat '('(a) '(char:pipe) '(b)))))
  (matrix:enumerated-for input (lambda cell y x (if (math:zero? cell) (array:push! coords (array y x)))))
  (let score (array:fold coords (lambda a coord (do
        (let set (new:set8))
        (let y (array:first coord)) 
        (let x (array:second coord))
        (let current (matrix:get input y x))
    (let climb (lambda current y x o (do
        (matrix:adjacent input matrix:von-neumann-neighborhood y x (lambda cell dir dy dx (do
            (if (= (- cell current) 1) (climb cell dy dx (= cell 9))))))
        (if o (set:add! set (from:chars->key y x))))))
    (climb current y x 0)
    (+ a (length (array:flat-one set))))) 0))
  score)))
'((part1 (parse INPUT)))