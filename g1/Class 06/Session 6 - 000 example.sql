



select s.FirstName as StudentFirstName, s.LastName as StudentLastName, AVG(g.Grade) as AvgGrade
into #temp
	from dbo.Grade as g 
	inner join dbo.Student as s on s.Id=g.StudentID
	Where TeacherID=1
	group by s.FirstName, s.LastName 
	


	select * from #temp

	select * , 
	CASE WHEN AvgGrade>7.5 then 'Yes' else 'No' END as ForReward
	from #temp t


	select * , 
	CASE WHEN AvgGrade=10 then 'deset' 
		 WHEN AvgGrade=9 then 'devet' 
		 WHEN AvgGrade=8 then 'osum' 
		 ELSE 'se drugo'
    END
	from #temp t