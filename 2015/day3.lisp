(let char:right (car ">"))
(let char:left (car "<"))
(let char:down (car "v"))
(let char:up (car "^"))
(let walk (lambda map x (array:fold x (lambda a b (do 
                    (cond 
                      (= char:right b) (array:increment! a 0 1)
                      (= char:left b) (array:increment! a 0 -1)
                      (= char:up b) (array:increment! a 1 1)
                      (= char:down b) (array:increment! a 1 -1)
                      (*) a)
                      (let A (from:integer->string (math:abs (car a))))
                      (let B (from:integer->string (math:abs (car (cdr a)))))
                      (let key (array:concat [(if (math:negative? (car a)) "-" "+") A "," (if (math:negative? (car (cdr a))) "-" "+") B]))
                      (set:add! map key)
                      a)) (array 0 0))))
(let part1 (lambda x (do
  (let map [[] [] [] [] [] [] [] [] [] [] [] [] [] [] [] []])
  (set:add! map "+0,+0")
  (walk map x)
  (length (array:flat-one (array:select map array:not-empty?))))))
(let part2 (lambda x (do
  (let a (array:enumerated-fold x (lambda a b i (if (math:even? i) (array:merge a (array b)) a)) []))
  (let b (array:enumerated-fold x (lambda a b i (if (math:odd? i) (array:merge a (array b)) a)) []))
  (let map [[] [] [] [] [] [] [] [] [] [] [] [] [] [] [] []])
  (set:add! map "+0,+0")
  (walk map a)
  (walk map b)
  (length (array:flat-one (array:select map array:not-empty?))))))
[(|> (array ">" "^>v<" "^v^v^v^v^v" "^v") (array:map part1)) (|> (array "^v" "^>v<" "^v^v^v^v^v" "^^vv") (array:map part2))]