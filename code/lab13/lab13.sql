.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color = 'blue' AND pet = 'dog';


CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE color = 'blue' AND pet = 'dog';


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color
    FROM students AS A, students AS B
    WHERE a.pet = b.pet AND a.song = b.song AND a.time < b.time;


CREATE TABLE sevens AS
  SELECT seven FROM students, numbers
    WHERE students.time = numbers.time
      AND numbers.'7' = 'True' AND students.number = 7;


CREATE TABLE favpets AS
  SELECT pet, COUNT(*) AS count
    FROM students GROUP BY pet ORDER BY count DESC LIMIT 10;


CREATE TABLE dog AS
  SELECT pet, COUNT(*) FROM students WHERE pet='dog';


CREATE TABLE bluedog_agg AS
  SELECT song, COUNT(*) AS count
    FROM bluedog_songs GROUP BY song ORDER BY count DESC;


CREATE TABLE instructor_obedience AS
  SELECT seven, instructor, COUNT(*) AS count FROM students WHERE seven='7'
    GROUP BY instructor ORDER BY count DESC;

