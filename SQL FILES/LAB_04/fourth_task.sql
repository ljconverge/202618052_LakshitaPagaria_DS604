SET SEARCH_PATH TO acad;

---1. List Faculty (ID, Name) for all courses of Autumn'2010.
SELECT DISTINCT i.instructorid, i.instructorname
FROM instructor i
JOIN offers o
    ON i.instructorid = o.instructorid
WHERE o.acadyear = '2010'
  AND o.semester = 'Autumn';

---2. List Students (ID, Name) from batch 2008 registered for course MT101 in Autumn'2008.
SELECT DISTINCT s.studentid, s.name
FROM student s
JOIN registers r
    ON s.studentid = r.studentid
WHERE s.batch = 2008
  AND r.courseno = 'MT101'
  AND r.acadyear = '2008'
  AND r.semester = 'Autumn';

---3. List Students (ID, Name) from B Tech (progid='01') batch 2008 registered for course MT101 in Autumn'2008.
SELECT DISTINCT s.studentid, s.name
FROM student s
JOIN registers r
    ON s.studentid = r.studentid
WHERE s.progid = '01'
  AND s.batch = 2008
  AND r.courseno = 'MT101'
  AND r.acadyear = '2008'
  AND r.semester = 'Autumn';

---4. List courses that were offered but students were not registered in those offerings.
SELECT DISTINCT
       o.courseno,
       c.coursename,
       c.credit,
       o.acadyear,
       o.semester
FROM offers o
JOIN course c
    ON o.courseno = c.courseno
LEFT JOIN registers r
    ON o.courseno = r.courseno
   AND o.acadyear = r.acadyear
   AND o.semester = r.semester
WHERE r.studentid IS NULL;

---5. List students (id, name, courseno, grade) who got 'F' grade in Autumn'2008
SELECT s.studentid,
       s.name,
       r.courseno,
       r.grade
FROM student s
JOIN registers r
    ON s.studentid = r.studentid
WHERE r.grade = 'F'
  AND r.acadyear = '2008'
  AND r.semester = 'Autumn';

---6. List Courses (Course No, Title, Credits) offered by Instructor (ID='PMJ') in semester Winter'2010.
SELECT DISTINCT c.courseno,
       c.coursename,
       c.credit
FROM course c
JOIN offers o
    ON c.courseno = o.courseno
WHERE o.instructorid = 'PMJ'
  AND o.acadyear = '2010'
  AND o.semester = 'Winter';

---7. Produce transcript of student '200711002' for Academic year 2008-09. List Course No, Course Name, Course Credit, Grade
SELECT c.courseno,
       c.coursename,
       c.credit,
       r.grade
FROM registers r
JOIN course c
    ON r.courseno = c.courseno
WHERE r.studentid = '200711002'
  AND r.acadyear = '2008';
  
---8. List ID of students who have taken both courses - 'MT101' AND 'MT104'.
SELECT studentid
FROM registers
WHERE courseno IN ('MT101', 'MT104')
GROUP BY studentid
HAVING COUNT(DISTINCT courseno) = 2;

---9. List ID of students who have taken 'MT101' but not 'MT104'.
SELECT studentid
FROM registers
WHERE courseno = 'MT101'

EXCEPT

SELECT studentid
FROM registers
WHERE courseno = 'MT104';