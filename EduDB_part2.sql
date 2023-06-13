--11
SELECT CONCAT(student.last_name, ' ', student.first_name) AS student_full_name,
(EXTRACT('year' FROM current_date ) - EXTRACT('year' FROM student.dob)) AS age_student
FROM student
WHERE (EXTRACT('year' FROM current_date ) - EXTRACT('year' FROM student.dob))>=25;

--12
SELECT *
FROM student
WHERE EXTRACT('year' FROM student.dob) = 1988 AND EXTRACT('month' FROM student.dob) = 1;

--13
select name, count(*) as total 
from clazz 
group by (clazz_id) 
order by (total) desc, (name) asc;

--14
select max(midterm_score), min(midterm_score), avg(midterm_score) from enrollment
where subject_id in 
(select subject_id from subject where name = 'Mạng máy tính') and semester = '20172';

--15
select lecturer_id, concat(last_name,' ',first_name) as name_lecturer, count(*)
from lecturer join teaching using (lecturer_id)
group by (lecturer_id)
order by (count) desc, (first_name) asc, (last_name) asc

--16
select subject_id, subject.name , count(*) as lecturers_in_charge
from subject join teaching using(subject_id)
group by (subject_id)
having count(*) >= 2
order by subject_id

--17
select subject_id, subject.name , count(*) as lecturers_in_charge
from subject join teaching using(subject_id)
group by (subject_id)
having count(*) < 2
order by subject_id

--18
select student_id, concat(last_name,' ',first_name) as name_student
from student join enrollment using(student_id)
join subject using(subject_id)
where (midterm_score*(1-cast(percentage_final_exam as float)/100)+final_score*cast(percentage_final_exam as float)/100) = (
	select max((midterm_score*(1-cast(percentage_final_exam as float)/100)+final_score*cast(percentage_final_exam as float)/100))
	from student join enrollment using(student_id)
	join subject using(subject_id)
	where subject_id = 'IT3080' and semester = '20172' x
)