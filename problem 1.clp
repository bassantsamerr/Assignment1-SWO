(deftemplate Father 
	(slot father)
	(slot son)
)

(deftemplate Mother 
	(slot mother)
	(slot son)
)

(deftemplate parent
	(slot parentName)
	(slot sonName)
)

(deftemplate Grandmother 
	(slot Grandmother)
	(slot son)
)

(deftemplate Grandfather 
	(slot Grandfather)
	(slot son)
)

(deffacts facts
 (Father
		(father Ahmed)
		(son Mohammed)
	)
	(Mother
		(mother Mona)
		(son Ali)
	)
	(Father
		(father Ali)
		(son sara)
	)

	(Father
		(father Hassan)
		(son Ahmed)
	)
)

(defrule isParentOf 
	(or(Mother(mother ?parent) (son ?son))
	   (Father(father ?parent)(son ?son))
	)
	=>
	(printout t ?parent " is a parent of " ?son crlf)
	(assert (parent 
		(parentName ?parent)
		(sonName ?son)
		)
	)
)

(defrule isGrandMotherOf 
	(Mother(mother ?parent) (son ?son))
	    (or(Mother(mother ?son)(son ?child))
	    (Father(father ?son)(son ?child))
	    )
	=>
	(printout t ?parent " is a grandMother of " ?child crlf)
	(assert (Grandmother 
		(Grandmother ?parent)
		(son ?child)
		)
	)
)
(defrule isGrandFatherOf 
	(Father(father ?parent) (son ?son))
	    (or(Mother(mother ?son)(son ?child))
	    (Father(father ?son)(son ?child))
	    )
	=>
	(printout t ?parent " is a grandFather of " ?child crlf)
	(assert (Grandfather 
		(Grandfather ?parent)
		(son ?child)
		)
	)
)
