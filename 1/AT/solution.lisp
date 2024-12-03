(let INPUT (array:concat-with '(
    "3   4"
    "4   3"
    "2   5"
    "1   3"
    "3   9"
    "3   3"
) char:new-line))
(let parse (lambda input (|> 
                            input 
                            (string:lines) 
                            (array:map (lambda word (|> 
                                                      word 
                                                      (string:words) 
                                                      (array:select array:not-empty?) 
                                                      (array:map (lambda n (|> 
                                                                             n 
                                                                             (from:chars->digits) 
                                                                             (from:digits->number))))))))))

(let part1 (lambda input (|> 
                          input
                          (array:unzip)
                          (array:map (curry:two array:sort >))
                          (tuple:zip)
                          (array:map tuple:subtract)
                          (array:map math:abs)
                          (math:summation))))
                        
(let part2 (lambda input (do 
  (let parts (array:unzip input))
  (let left (array:first parts))
  (let right (array:second parts))
  (|> 
    left 
    (array:map (lambda l (* l (array:count-of right (lambda r (= l r))))))
    (math:summation)))))

(let PARSED (parse INPUT))
(array (part1 PARSED) (part2 PARSED))