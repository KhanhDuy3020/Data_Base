--1
SELECT *
FROM   subject
WHERE  credit >= 0

--2
SELECT last_name,first_name,name
FROM   student natural join clazz
WHERE  clazz.name='CNTT1.01-K61'

--3
SELECT last_name,first_name,name
FROM   student natural join clazz
WHERE  clazz.name LIKE '%CNTT%'

--4
SELECT *
FROM   student
WHERE  student_id in (
	SELECT student_id
	FROM   enrollment natural join subject
	WHERE  subject.name = 'Tin học đại cương' AND student_id in (
		SELECT student_id
		FROM   enrollment natural join subject
		WHERE  subject.name = 'Mạng máy tính'
	)
)

--5
SELECT *
FROM   student
WHERE  student_id in (
	SELECT student_id
	FROM   enrollment natural join subject
	WHERE  subject.name = 'Lập trình Java' OR student_id in (
		SELECT student_id
		FROM   enrollment natural join subject
		WHERE  subject.name = 'Lập trình hướng đối tượng'
	)
)

SELECT *
FROM   student
WHERE  student_id in (
	SELECT student_id
	FROM   enrollment natural join subject
	WHERE  subject.name = 'Lập trình hướng đối tượng'
)