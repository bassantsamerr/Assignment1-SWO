"problem 1"

(deftemplate isFatherOf 
	(slot father)
	(slot son)
)
(deftemplate isMotherOf 
	(slot mother)
	(slot son)
)
(deftemplate parent
	(slot parentName)
	(slot sonName)
)
(deftemplate isGrandmotherOf 
	(slot Grandmother)
	(slot son)
)
(deftemplate isGrandfatherOf 
	(slot Grandfather)
	(slot son)
)
(assert (isFatherOf
		(father Ahmed)
		(son Mohammed)
	)
	(isMotherOf
		(mother Mona)
		(son Ali)
	)
	(isFatherOf
		(father Ali)
		(son sara)
	)
	(isFatherOf
		(father Hassan)
		(son Ahmed)
	)
)
(defrule isParentOf 
	(or(isMotherOf(mother ?parent) (son ?son))
	   (isFatherOf(father ?parent)(son ?son))
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
	(isMotherOf(mother ?parent) (son ?son))
	    (or(isMotherOf(mother ?son)(son ?child))
	    (isFatherOf(father ?son)(son ?child))
	    )
	=>
	(printout t ?parent " is a grandMother of " ?child crlf)
	(assert (isGrandmotherOf 
		(Grandmother ?parent)
		(son ?child)
		)
	)
)
(defrule isGrandFatherOf 
	(isFatherOf(father ?parent) (son ?son))
	    (or(isMotherOf(mother ?son)(son ?child))
	    (isFatherOf(father ?son)(son ?child))
	    )
	=>
	(printout t ?parent " is a grandFather of " ?child crlf)
	(assert (isGrandfatherOf 
		(Grandfather ?parent)
		(son ?child)
		)
	)
)
