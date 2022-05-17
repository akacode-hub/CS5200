use lotrfinal_1;

-- question 1 
DROP PROCEDURE IF EXISTS track_character;
DELIMITER //
CREATE PROCEDURE track_character( character_name varchar(50))
BEGIN 
DECLARE character_name_var varchar(50);
SELECT character2_name AS character_name, region_name, title, character1_name as name_encountered_character
FROM (  
SELECT character2_name , region_name ,title, character1_name
FROM lotr_first_encounter, lotr_book  WHERE character1_name = character_name
UNION ALL
SELECT character1_name, region_name , title, character2_name
FROM lotr_first_encounter, lotr_book  WHERE character2_name = character_name ) AS character_encounters
GROUP BY character2_name, region_name,title;
END //
DELIMITER ;
-- using below statements to check the output of the procedure
call track_character('Frodo');
call track_character('Aragorn');

-- question  2 
DROP PROCEDURE IF EXISTS track_region;
DELIMITER //
CREATE PROCEDURE track_region(IN region varchar(50))
BEGIN 
DECLARE region_name_var varchar(50);
SELECT lfe.region_name, lb.title as book_name , count(character1_name) as no_of_encounters, lr.leader as leader_of_region
FROM lotr_first_encounter lfe
JOIN lotr_book lb ON lfe.book_id = lb.book_id
JOIN lotr_region lr ON lfe.region_name=lr.region_name
WHERE lfe.region_name = region GROUP BY lfe.region_name,lb.title;
END //
DELIMITER ;
-- using below statements to check the output of the procedure
call track_region('Mordor');
call track_region('Bree');
call track_region('Shire');
call track_region('Gondor');

-- question 3
DROP FUNCTION IF EXISTS strongerSpecie;
DELIMITER //
CREATE FUNCTION strongerSpecie(specie1 varchar(45) , specie2 varchar(45))
RETURNS int
DETERMINISTIC READS SQL DATA 
BEGIN
DECLARE size1 int;
DECLARE size2 int;
SELECT size into size1 from lotr_species where species_name= specie1;
SELECT size into size2 from lotr_species where species_name= specie2;
IF size1 > size2
THEN RETURN 1;
ELSEIF size1 = size2
THEN RETURN 0;
ELSE RETURN -1;
END IF;
END //
DELIMITER ;
-- using below statements to check the output of the fuction 
select strongerSpecie('elf','ent');
select strongerSpecie('human','orc');
select strongerSpecie('balrog','dwarf');

-- question 4
DROP FUNCTION IF EXISTS region_most_encounters;
DELIMITER $$
CREATE FUNCTION region_most_encounters(character_name varchar(50))
RETURNS varchar(50)
DETERMINISTIC READS SQL DATA 
BEGIN
DECLARE regchen varchar(50);
SELECT region_name INTO regchen FROM lotr_first_encounter
WHERE character1_name = character_name or character2_name = character_name
GROUP BY region_name ORDER BY SUM(region_name) DESC LIMIT 1;
RETURN regchen;
END $$
DELIMITER ;
-- using below statements to check the output of the fuction 
select region_most_encounters('Aragorn');
select region_most_encounters('Frodo');
select region_most_encounters('Sauron');

-- question 5 
DROP FUNCTION IF EXISTS home_region_encounter;
DELIMITER// 
create function home_region_encounter(
    in character_name varchar(50),
    out val varchar(30)
)
BEGIN
select case when ch.homeland=xyz.region_name then 'TRUE'
when ch.homeland!=xyz.region_name then 'FALSE'
else 'NULL'
end
as enc_homeland
into val
from lotr_character ch left join (SELECT s3.character1_name as character_name, (s3.region_name) as region_name
from
(SELECT s1.character1_name as character1_name, s1.character2_name as character2_name, s1.region_name as region_name
FROM lotr_first_encounter s1
UNION
SELECT s1.character2_name as character1_name, s1.character1_name as character2_name, s1.region_name as region_name
FROM lotr_first_encounter s1   
) s3
group by 1) xyz  on ch.character_name=xyz.character_name
where ch.character_name= character_name 
END //
DELIMITER ;
-- using below statements to check the output of the fuction 
select home_region_encounter('Frodo');


-- question 6 
DROP FUNCTION IF EXISTS encounters_in_num_region;
DELIMITER $$
CREATE FUNCTION encounters_in_num_region(region varchar(50))
RETURNS int
DETERMINISTIC READS SQL DATA 
BEGIN
DECLARE numbers int;
SELECT count(character1_name) INTO numbers FROM lotr_first_encounter WHERE region_name = region;
RETURN numbers;
END $$
DELIMITER ;
-- using below statements to check the output of the fuction 
select encounters_in_num_region('Rivendell');
select encounters_in_num_region('Bree');
select encounters_in_num_region('Shire');

-- question 7 
drop procedure if exists fellowship_encounters;
delimiter //
create procedure fellowship_encounters(book_name varchar(50))
begin 
declare book_name_var varchar(50);
select ch.*
from lotr_character ch join
(SELECT s3.character1_name as character_name
from lotr_book lb left join
(SELECT s1.character1_name as character1_name, s1.character2_name as character2_name, s1.book_id as book_id
FROM lotr_first_encounter s1
UNION
SELECT s1.character2_name as character1_name, s1.character1_name as character2_name, s1.book_id as book_id
FROM lotr_first_encounter s1   
) s3 using (book_id)
where lb.title=book_name
) tab using (character_name);
END //
DELIMITER ;
-- using below statements to check the output
call fellowship_encounters('the return of the king');


-- question 8 
ALTER Table lotr_book
ADD COLUMN encounters_in_book INT;
DROP PROCEDURE IF EXISTS initialize_encounters_count;
DELIMITER //
CREATE PROCEDURE initialize_encounters_count(bookid int)
BEGIN
SELECT count(character1_name) as no_of_encounters_for_book FROM lotr_first_encounter lfe
WHERE lfe.book_id = bookid;
END //
DELIMITER ;
-- using below statements to check the output of the fuction 
call initialize_encounters_count(1);
SELECT * FROM lotrfinal_1.lotr_book;

-- question 9 
DROP TRIGGER IF EXISTS firstencounters_after_insert;
DELIMITER //
CREATE TRIGGER firstencounters_after_insert
AFTER INSERT ON lotr_first_encounter
FOR EACH ROW BEGIN
DECLARE book int;
SELECT count(character1_name) INTO book FROM lotr_first_encounter lfe WHERE book_id =NEW.book_id;
UPDATE lotr_book set encounters_in_book = book WHERE book_id = NEW.book_id;
END //
DELIMITER ;

INSERT INTO lotr_first_encounter (character1_name, character2_name, book_id, region_name)
VALUES ('Legolas', 'Frodo', 1,'Rivendell');

-- using below statements to check the output of the fuction 
select * from lotr_first_encounter;

-- question 10 
PREPARE home_region_en FROM 'SELECT home_region_encounter(?)';
SET @Aragorn = 'Aragorn';
EXECUTE home_region_en USING @Aragorn;
DEALLOCATE PREPARE home_region_en;

-- question 11 
PREPARE region_most_en FROM 'SELECT region_most_encounters(?)';
SET @Aragorn = 'Aragorn';
EXECUTE region_most_en USING @Aragorn;
DEALLOCATE PREPARE region_most_en;