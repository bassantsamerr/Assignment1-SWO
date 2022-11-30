(defclass Shape
(is-a USER)
(role abstract)
(slot ID (type SYMBOL))
(slot color (allowed-values red blue green yellow)))

(defclass Square
(is-a Shape)
(role concrete)
(slot length)
)

(defclass Rectangle
(is-a Shape)
(role concrete)
(slot width)
(slot length)
)

(definstances shapes 
(s1 of Square (ID A)(color blue) (length 3))
(r1 of Rectangle (ID C) (width 2) (length 5)))

(defmessage-handler Square calcArea ()
(bind ?length(send ?self get-length))
(printout t (* ?length ?length) crlf))

(defmessage-handler Rectangle calcArea ()
(bind ?length(send ?self get-length))
(bind ?width(send ?self get-width))
(printout t (* ?length ?width) crlf))

(defmessage-handler Square calcPer ()
(bind ?length(send ?self get-length))
(printout t (* ?length 4) crlf))

(defmessage-handler Rectangle calcPer ()
(bind ?length(send ?self get-length))
(bind ?width(send ?self get-width))
(printout t ( * (+ ?length ?width) 2 ) crlf))
