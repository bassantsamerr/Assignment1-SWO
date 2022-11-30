(deftemplate c
	(slot countryName (type STRING))
	(multislot colors)
)
(deffacts countries
	(c (countryName "Egypt") (colors red white black))
	(c (countryName "United states") (colors red white blue))
	(c (countryName "Belgium") (colors black yellow red))
	(c (countryName "Sweden") (colors yellow blue))
	(c (countryName "Italy") (colors green white red))
	(c (countryName "Ireland") (colors green white orange))
	(c (countryName"Greece") (colors blue white))
)

(defrule readingInput
	=>
	(printout t "Please type the color" crlf)
	(assert (color (read)))
 )
(defrule check 
	(color ?color)
	(c (countryName ?countryName) (colors $?colors))
	(test (member$ ?color ?colors))
	=>
	(printout t "Country Is: " ?countryName " and its flag's colors are " ?colors crlf)
)
	
