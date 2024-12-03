; To run code 
; ppen link and press CMD + s 
; https://at-290690.github.io/fez/?l=BQGwpgLgBAkgcgBQKoBUrAIYCcsYJ4BcAxgPYB2RGEAtAO4CWEAFlAOTABQU3UARAMw8ALLy49eQnv1E8%2BAJh4BWGeICMUldwE8AnJr6Du0jgEooRJtgJkwtaiHo2TJjqEhQADtgDOYdCAwAWwAjABMMKEcPAFdoYAAfAD4oMVk09IzZKNiUzLz89G8ILEcAcwIHG28zVIK67kwcfAJAjA9%2FILCI2hIsUPQk3PrhkYKevqHRqenC4rKCcdDqyZnVusbcQl9wImhsTesSGjBAjwg8AH4atZuCjebW9tBO8KgyAeTa2%2B%2Bft5XfgGrYAAMywJECxEsWG81ESoXopUYyy%2BgNRIxBYIh8MREBhiTI0RCYCwzlJZJcrnA0C8WAg6meIVe2TigxRq2ZbJm90I0TIAC96B4XL9uS02ugiNEcIRgo5sHgoPtmt5etBEs5OdNgBBoh5wAQBULNVNRY8oDq9WACN5osFihhdsKfqbxa1mAQMMFqsbRsA3UxrYS3fRyGSffVKe4aRAFAyupEyDE4qESEM3NTsLj0EqefzBQmkxqGlSoOBgXEcwRgfRoRnadUnemoCVSkwK00tmBSGR%2BtGG2IEp9ZGXoLUXU8AoyIiB0AAqUvZjvEEi8mgkYHNhFtjpT5voAC8C5J5LH%2FsDgWDobDkegCAAggAlADKAFEACLoGm%2BWCIVAa7mfpm6j3s%2B75mMA0YKCBr5vs4QA
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