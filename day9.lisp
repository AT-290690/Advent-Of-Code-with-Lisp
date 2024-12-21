(let INPUT "2333133121414131402")

(let parse (lambda input (from:chars->digits input)))

(let part1 (lambda input (do
    (let file-id (var:def -1))
    (let disk (|> input
        (array:enumerated-fold (lambda disk ch i 
        (array:merge! disk
            (if (math:even? i) (do
                    (let id (var:get (var:increment! file-id)))
                    (array:of ch (lambda . id)))
                    (array:of ch (lambda . -1))))) ())))
    (let blanks ())
    (array:enumerated-for disk (lambda x i (if (= x -1) (array:push! blanks i))))
    (let rec:fragment (lambda ind (do
        (let i (get blanks ind))
        (if (= (array:last disk) -1) (do (array:pop! disk) (rec:fragment ind))
            (unless (<= (length disk) i) (do
            (set! disk i (array:pop! disk))
            (rec:fragment (+ ind 1))))))))
        (rec:fragment 0)
        (|> disk (array:enumerated-fold (lambda a b i (+ a (* b i))) 0)))))
       
(let PARSED (parse INPUT))

'((part1 PARSED))