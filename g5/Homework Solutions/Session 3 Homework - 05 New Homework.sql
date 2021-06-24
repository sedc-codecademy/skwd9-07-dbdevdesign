--	List all student First Name that are duplicated more than 3 time 
select FirstName, count(*) from dbo.Student
group by FirstName
having count (*) > 3

--	List the First Name for all the student's that their Last Name is duplicated and they are born in 1985  (Hint use View)
create or alter view LastName 
as
select LastName, count (*) cnt from dbo.Student
where DateOfBirth >= '19850101' and DateOfBirth <= '19851231'
group by LastName
having count (*) > 1

select distinct Firstname from LastName l 
join dbo.Student s on l.LastName = s.LastName
where DateOfBirth >= '19850101' and DateOfBirth <= '19851231'

-- Find how many courses each student (using First Name and Last Name) has attended
select FirstName + ' ' + LastName, count(*) as Courses 
from dbo.Student s
left join dbo.Grade g on g.StudentID = s.ID
group by FirstName + ' ' + LastName


-- Find the students (using First Name and Last Name) that have attended less than 20 courses and get their Min, Max and Average grade ordered by the Average Grade ascending
select FirstName + ' ' + LastName, min(Grade) as MinGrade, max(Grade) as MaxGrade, AVG(Grade) as AvgGrade 
from dbo.Student s
left join dbo.Grade g on g.StudentID = s.ID
group by FirstName + ' ' + LastName
having count(*) < 20
order by AVG(Grade) 

-- For all the students (using First Name and Last Name) get their Min, Max and Average grade (Create view vv_StudentSuccess)
create or alter view vv_StudentSuccess
as 
select FirstName + ' ' + LastName as StudentName, min(Grade) as MinGrade, max(Grade) as MaxGrade, AVG(Grade) as AvgGrade 
from dbo.Grade g
join dbo.Student s on g.StudentID = s.ID
group by FirstName + ' ' + LastName

select * from vv_StudentSuccess

-- Find all the students that have achieved less than 25% from the AchievementMaxPoints for the AchievementType  'Domasni' 
create or alter view vv_Students
as
select distinct FirstName + ' ' + LastName as Student 
from dbo.GradeDetails gd
join dbo.AchievementType at on gd.AchievementTypeID = at.ID
join dbo.Grade g on gd.GradeID = g.ID
join dbo.Student s on g.StudentID = s.ID
where at.Name = 'Domasni' and AchievementPoints < AchievementMaxPoints / 4

-- For the Students from the above list check what is their Success (Min, Max and Average grade) and order them by the AVG grade
select * from vv_Students t1
join vv_StudentSuccess t2 on t1.Student = t2.StudentName
order by AvgGrade

select top 100 t.AcademicRank, count(*)
from dbo.GradeDetails gd
join dbo.AchievementType at on gd.AchievementTypeID = at.ID
join dbo.Grade g on gd.GradeID = g.ID
join dbo.Student s on g.StudentID = s.ID
join dbo.Teacher t on g.TeacherID = t.ID
