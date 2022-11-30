(deftemplate person 
(multislot fullname)
(multislot children)
)

(defrule morethan3
(person(fullname $?fullname)(children ?w ?x ?z ?y $?))
=>
(printout t $?fullname crlf) 
)

(defrule parent
(person(fullname $?fullname)(children $?c ))
(child-name ?name)
(test (member$ ?name $?c))
=>
(printout t $?fullname " is the parent of " ?name crlf) 
)

(deffacts test 
(person (fullname Reem) (children Ahmed Rana Ali))
(person (fullname Ammar ) (children Bassant Rania Doaa Ehab))
(person (fullname Rowan) )
(child-name Rana)
)
