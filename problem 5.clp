(deftemplate square (slot id) (slot side-length))
(deftemplate rectangle (slot id) (slot width) (slot height))
(deftemplate circle (slot id) (slot radius))

(defrule squareInfo 
?delete <-(square (id ?id) (side-length ?S))
=>
(retract ?delete)
(assert (area (* ?S ?S) ) )
(assert (perimeter(* ?S 4)) )
)

(defrule RecInfo 
?delete<-(rectangle (id ?id) (width ?w) (height ?h))
=>
(retract ?delete)
(assert (area (* ?w ?h) )) 
(assert (perimeter( * (+ ?h ?w) 2)) )
)

(defrule circleInfo 
?delete <-(circle (id ?id) (radius ?r))
=>
(retract ?delete)
(assert (area (* 3.1415 ?r ?r) )) 
(assert (perimeter( * ?r 2 3.1415)))

)

(defrule addArea 
?a <- (area ?area)  
?sa <- (sumArea ?sum)
=>
(retract ?a ?sa)
(assert  ( sumArea (+ ?sum ?area)) )
)

(defrule addPerimeter
?p <- (perimeter ?perimeter)
?sp <- (sumPerimeter ?sumPerimeter)
=>
(retract ?p ?sp)
(assert  ( sumPerimeter (+ ?sumPerimeter ?perimeter)) )
)


(deffacts test 
(sumArea 0) 
(sumPerimeter 0)
(square (id A) (side-length 3))
(square (id B) (side-length 5))
(rectangle (id C) (width 2) (height 5))
(circle (id D) (radius 2))
(circle (id E) (radius 6)))
