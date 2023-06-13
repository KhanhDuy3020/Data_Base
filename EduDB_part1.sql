--1
SELECT *
FROM   subject
WHERE  credit >= 5

--2
SELECT last_name,first_name,name
FROM   student natural join clazz
WHERE  clazz.name='CNTT 2 K58'

--3
SELECT last_name,first_name,name
FROM   student natural join clazz
WHERE  clazz.name LIKE '%CNTT%'

--4
SELECT  *
FROM    student
WHERE   student_id in (SELECT  student_id
FROM    enrollment natural join subject
WHERE   subject.name = 'Tin học đại cương' AND student_id IN (SELECT student_id FROM subject WHERE subject.name = 'Mạng máy tính'))

--5
SELECT  *
FROM    student
WHERE   student_id in (SELECT  student_id
FROM    enrollment natural join subject
WHERE   subject.name = 'Tin học đại cương' OR student_id IN (SELECT student_id FROM subject WHERE subject.name = 'Mạng máy tính'))

-- 6.Display subjects that have never been registered by any student
select subject.name
from   subject
where  subject_id not in (select distinct subject_id from enrollment)

--7.List of subject(subject name and credit number corresponding) that student "Nguyễn Hoài An" have enrolled in the semester "20171"
select name, credit
from   subject
where  subject_id in (select subject_id from student natural join enrollment,concat(last_name,' ',first_name) as name_student 
					 where name_student='Nguyễn Hoài An' and semester='20171')

--8.
select student_id,concat(last_name,' ',first_name) as name_student,midterm_score,final_score,
(midterm_score*(1-cast(percentage_final_exam as float)/100)+final_score*cast(percentage_final_exam as float)/100) as subject_score
from enrollment
inner join student using (student_id)
inner join subject using (subject_id)
where name='Cơ sở dữ liệu' and semester='20172' 

--9
WITH table_fake as (select student_id, first_name, last_name, midterm_score, final_score,
(midterm_score * (1- CAST(percentage_final_exam AS FLOAT)/100) + final_score*CAST(percentage_final_exam AS FLOAT)/100)
AS subject_score 
from enrollment
inner join student using (student_id)
inner join subject using (subject_id)
where subject_id='IT1110' and semester = '20171')
select student_id
from   table_fake
where  midterm_score<3 or final_score<3 or subject_score<4

--10
select *
from   student inner join clazz using (clazz_id) 
