-- use sql.cs61a.org

SELECT name FROM records WHERE supervisor = "Oliver Warbucks";

SELECT name FROM records WHERE name = supervisor;

SELECT name FROM records WHERE salary > 50000 ORDER BY name;

SELECT name, day, time FROM records, meetings
  WHERE supervisor = "Oliver Warbucks"
  AND records.division = meetings.division;

SELECT a.name FROM records AS a, records AS b
  WHERE a.supervisor = b.name AND a.division <> b.division;

SELECT r1.name, r2.name
  FROM records AS r1, meetings as m1, records AS r2, meetings as m2
  WHERE r1.division = m1.division AND r2.division = m2.division
    AND m1.time = m2.time AND r1.name < r2.name;

SELECT supervisor, SUM(salary) FROM records GROUP BY supervisor;

SELECT day FROM records, meetings
  WHERE records.division = meetings.division
  GROUP BY day HAVING COUNT(name) < 5;

SELECT r1.division FROM records AS r1, records AS r2
  WHERE r1.name < r2.name AND r1.division = r2.division
  GROUP BY r1.division HAVING MAX(r1.salary + r2.salary) < 100000;

CREATE TABLE num_taught AS
  SELECT professor, course, COUNT(*) AS count
    FROM courses GROUP BY course, semester;

SELECT t1.professor, t2.professor, t1.course
  FROM num_taught AS t1, num_taught AS t2
  WHERE t1.professor > t2.professor
    AND t1.course = t2.course AND t1.count = t2.count;

SELECT t1.professor, t2.professor
  FROM courses AS t1, courses AS t2
  WHERE t1.professor < t2.professor
    AND t1.semester = t2.semester AND t1.course = t2.course
  GROUP BY a.course, a.professor, b.professor HAVING COUNT(*) > 1;
