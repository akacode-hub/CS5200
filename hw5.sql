use lotrfinal_1;

 -- 3
 select count(*)
from lotr_region
where major_species='hobbit';

-- 12
select count(homeland) from lotr_character where homeland ='gondor';

-- 9 -- print maximum size 
select species_name , MAX(size)
from lotr_species
group by species_name,size
having MAX(size) ;

select species_name , size from lotr_species having MAX(size);

select *  from lotr_species ;

-- 10
select count(*) from lotr_character where species='human';

-- 13
select count(*) from lotr_character where species='hobbit';

-- 7 
select i.book_id , title  FROM lotr_book i JOIN lotr_first_encounter v ON 
i.book_id= v.book_id 
where v.character1_name = 'faramir' and v.character2_name ='frodo';

-- 5
select r2.region_name , count(*) as visitor_count
 from
 (select r1.character1_name , r1. region_name as region_name
  from lotr_first_encounter r1    
  union 
  select r1.character2_name as character1_name, r1.region_name as region_name
  from lotr_first_encounter r1) r2 group by r2.region_name having visitor_count =(
  select count(*) from lotr_character);
 
 select * from lotr_region;
 select * from lotr_character;
 
 -- 4
 select * from lotr_first_encounter;
 
select region_name from lotr_first_encounter group by region_name having count(*) = (
select max(num) from ( 
select  distinct count(region_name) as num 
from lotr_first_encounter as subalias  group by region_name ) as alias) ;

-- 1

SELECT  e.character1_name, count(distinct e.character2_name) as count
FROM lotr_character c
inner join  lotr_first_encounter e  ON (c.character_name = 
e.character1_name OR c.character_name = e.character2_name)
where c.character_name = 
e.character1_name OR c.character_name = e.character2_name ;

select r3.character1_name as character_name , count(distinct r3.character2_name)
as encounter_count
from
( select r1.character1_name , r1.character2_name from lotr_first_encounter r1
union 
select r1.character2_name as character1_name , r1.character1_name as character2_name
 from lotr_first_encounter r1 ) r3 group by 1;

select * from lotr_character;
select * from lotr_first_encounter;

-- 2
-- Count the number of regions each character has visited 
-- (as documented in the database). Each tuple in the result 
-- should contain the character’s name and the number of regions
 --  the character has been documented as visiting as specified in the database.
 -- Note: the character’s home region should be included in the count. 
 
 select distinct c.character_name ,
 count(r.region_name) from lotr_character c join  lotr_region r
 ON c.homeleand = r.region_name; 

 select distinct character_name , count(homeland) from lotr_character c
 join  lotr_region r
 ON c.homeland = r.region_name ;  
 
 -- 8
 -- For each Middle Earth region (each region in the lotr_region table) , 
 -- create an aggregated field that contains a list of character names
 -- that have it as his homeland. The result set should contain the region
 -- name and the grouped character names.
 -- Do not duplicate names within the grouped list of character names
 
 select distinct r.region_name , c.character_name from lotr_region as r
 join lotr_character as c
 on r.region_name = c.homeland 
 group by r.region_name;
 
 -- 6
-- Make a separate table from the lotr_first_encounters table – 
-- where the records are for the first book. 
-- Name the new table book1 encounters.

 create table book1_encounters 
 as select 
 * from lotr_first_encounter
 where book_id=1; 
 
 select *  from book1_encounters;
 select * from lotr_first_encounter;
 select * from lotr_character; 
 
 -- 11
 
 create table HumanHobbitFirstEncounters
 as select 
 * from lotr_first_encounter where ( select distinct c.character_name
FROM lotr_character c
join  lotr_first_encounter e  ON (c.character_name = 
e.character1_name OR c.character_name = e.character2_name)
where c.character_name = 
e.character1_name OR c.character_name = e.character2_name and species ='hobbit'
 or species ='human');

create table HumanHobbitFirstEncounters
 as select 
* from lotr_first_encounter where (
SELECT character1_name, character2_name, book_id, region_name
 FROM lotr_first_encounter JOIN lotr_character
ON (character_name = character1_name and species = 'hobbit') or 
(character_name = character2_name and species = 'human'));


-- 14 
-- For each Middle Earth region, 
-- determine the number of characters from each homeland. 
-- The result set should contain the region name and 
-- the count of the number of characters. 
-- Make sure you do not count characters more than once.

select distinct r.region_name , count(c.character_name)
 from lotr_region as r
 join lotr_character as c
 on r.region_name = c.homeland 
 group by r.middle_earth_location ;
 
 -- 15 ) For each character determine the number of first encounters 
 -- they have had according to the database.
 -- Rename the computed number of encounters as encounters. 
-- Make sure each character appears in the result. If a character has not
 -- had any encounters, the number of encounters should be equal to NULL or 0. 
 
 select * from lotr_character;
 select * from lotr_first_encounter;
 
SELECT  distinct c.character_name, count(*) 
FROM lotr_character c left outer join lotr_first_encounter e 
ON (c.character_name = 
e.character1_name OR c.character_name = e.character2_name)
where c.character_name = 
e.character1_name OR c.character_name = e.character2_name ;

select species_name, MAX(size)
from lotr_species
group by species_name,size
having MAX(size) ;


