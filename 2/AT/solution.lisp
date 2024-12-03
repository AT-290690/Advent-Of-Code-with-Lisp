; To run code 
; ppen link and press CMD + s 
; https://at-290690.github.io/fez/?l=BQGwpgLgBAlgkgOQAoFUAqVgEMBOOsCeAXAMYD2AdiVhALQDuMEAFlAOTABQARAOxQA2KABYoAJigBGbj0nio%2FABxQAnDO4qFg%2BdNlQAzPNEBWdcqGjRu7nMND%2BazgEooJZriIUw9WiBhenJ05QSCgAB1wAZzBMECwAWwAjABMsWAowgFdoYAAfAD50rJzIiBx%2FAHMiPy9Il2w8QiJ4rDDYhJS0kEwCqG7gUvKKKvoyHGS6zFx8Yha20A7UqHoewpXgADMcMnjSdxxI2nzkmAqmSc3t3ZOziEP8ikyksBxAt%2Feg4PBoCJwIOQWSSW%2FmKqyK2SmjWI0XAJBycSBXX8MWAyTIUE4UFioUifhIKN6NRR0yaAC8YPMSdC8TEiVJscMWH1kW9ITNmq12oioAAPTAQTJhcBESKZRJlLBw3kfTGYMZsppgABuLwIAH4oLiYPiuZ1eVMKMlMPkALz6yT1AA8Zr5%2BneCuIytVGq1OsBer52ENmGt%2BtoFuNNqgtDtH0CXzAjOY704EZ%2BuAgEndwIyELyhRBENlWJzubz%2BfzDXZcwxBbL5cLCL1dPTzK8pYrjYrRcVj3iLxoYGStBLybSADpYA2myOC7Wa1SiJGnh2IF3aGAeSQQJlkiiq0tBwArTBmmBQLdht7Z0eNlvEciZCh0MgbXVLT0tFhEMJkSJMGAqjXAX7%2FaVh2MQmgJAAEEACUAGUAFEABFMF%2BaJYEQVA0HDDgfwTORQMg2D6l%2FCRsOgmDAiAA
(let iINPUT (array:concat-with '(
"7 6 4 2 1"
"1 2 7 8 9"
"9 7 6 2 1"
"1 3 2 4 5"
"8 6 4 4 1"
"1 3 6 7 9"
) char:new-line))
(let parse (lambda input (|> input (string:lines) (array:map (lambda l (|> l (string:words) (array:map (lambda w (|> w (from:chars->digits) (from:digits->number))))))))))

(let part1 (lambda input (|> input (array:select (lambda line (do 
  (let slice (|> line (array:zip (array:slice line 1 (length line))) (array:map (lambda x (tuple:subtract x)))))
  (or (array:every? slice (lambda x (and (>= x 1) (<= x 3)))) (array:every? slice (lambda x (and (<= x -1) (>= x -3))))))))
(length))))

(let part2 (lambda input (|> input 
                            (array:map 
                              (lambda line (|> line 
                                (array:enumerated-map (lambda . i 
                                  (|> line (array:enumerated-exclude (lambda . j (= i j)))))))))
                            (array:count-of (lambda x (math:positive? (part1 x)))))))

(let PARSED (parse iINPUT))
'((part1 PARSED) (part2 PARSED))