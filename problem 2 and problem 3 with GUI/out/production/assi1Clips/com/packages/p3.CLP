  (deftemplate student 
    (slot name)
    (multislot courseGrades)
  ) 

  (defrule ReadFromFile
  =>
    (open "D:\\Faculty\\Semester 7\\Semantic Web\\Labs\\input.txt" data "r")
    (bind ?name (read data))
    (while (neq ?name EOF)
    (printout t ?name crlf)
    (bind $?courseGrades (explode$ (readline data))) 
    (printout t $?courseGrades crlf)
    (assert (student (name ?name) (courseGrades $?courseGrades) ))
    (bind ?name (read data))
    )
	(close data)
  )

  (defrule CalculateAndWrite
  (student (name ?name)(courseGrades $?courseGrades))
  =>(open "D:\\Faculty\\Semester 7\\Semantic Web\\Labs\\output.txt" data "a")
  (bind ?res (+ (expand$ ?courseGrades)))
  (bind ?res (/ ?res 4))
  (printout data ?name " "$?courseGrades " "?res crlf)
  (close data)
  )