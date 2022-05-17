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
;
END //
DELIMITER ;
-- using below statements to check the output of the procedure
call track_character('Frodo');
call track_character('Aragorn');