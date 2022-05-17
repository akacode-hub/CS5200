/*solution to question 1 */
drop database PerfectPets;
create database PerfectPets;
use PerfectPets;

drop table clinic;
drop table staffmember;
drop table manager;
drop table owner;
drop table pet;
drop table examination;
drop table pettreatement;

CREATE TABLE clinic (
clinicno int(10),
clinic_name varchar(60),
 town varchar(30), 
 street varchar(30), 
 zipcode int, 
 phone int,
 PRIMARY KEY(clinicno));


CREATE TABLE staffmember(
staffno int, 
first_name varchar(30), 
last_name varchar(30),
sex varchar(20), 
PRIMARY KEY(staffno), 
Foreign Key(staffno) REFERENCES clinic(clinicno)
on update cascade on delete cascade);

CREATE TABLE manager(
staffno int,
first_name varchar(30), 
last_name varchar(30),
sex varchar(20),
dob date,
PRIMARY KEY(staffno), 
Foreign Key(staffno) REFERENCES clinic(clinicno)
on update cascade on delete cascade,
Foreign Key(staffno) REFERENCES staffmember(staffno)
on update cascade on delete cascade);

create table Owner(
ownerNo char(5) primary key not null,           
firstName varchar(50) not null,
lastName varchar(50) not null,
clinicNo char(10)    
);

create table Pet(
petNo int(10) primary key ,          
petName varchar(50) not null,
registeredDate date not null,
ownerNo char(5),
clinicNo char(10),
foreign key (ownerno) references Owner(ownerNo)
on update cascade on delete cascade,   
foreign key (petNo) references clinic(clinicno)
on update cascade on delete cascade    
);

create table Examination(
examNo int(5) primary key not null,          
examResults varchar(50) not null,
petNo char(10),
staffNo char(10),
foreign key (examNo) references Pet(petNo)
on update cascade on delete cascade,      
foreign key (examNo) references Staffmember(staffno) 
on update cascade on delete cascade
);

create table PetTreatment(
treatmentNo int(5) primary key not null,     
Treatmenttype varchar(100) not null,
foreign key (treatmentNo) references Examination(examNo)
on update cascade on delete cascade
);

/*solution to question 2*/
CREATE DATABASE IF NOT EXISTS REGIONAL_SCHOOL;
USE REGIONAL_SCHOOL;

DROP TABLE school;
drop table teacher;
drop table managing_teacher;
drop table pupil;
drop table subject;
drop table teaches;

CREATE TABLE school(
identificationno int(10),
school_name varchar(60),
 town varchar(30), 
 street varchar(30),
 zipcode int, 
 phone int, 
 PRIMARY KEY(identificationno));


CREATE TABLE teacher(
NIN int,
 first_name varchar(30), 
 last_name varchar(30),
 sex varchar(20),
 qualification varchar(30), 
 PRIMARY KEY(NIN), 
 Foreign Key(NIN) REFERENCES school(identificationno)
 on update cascade on delete cascade
 );

CREATE TABLE managing_teacher(
NIN int,
first_name varchar(30),
 last_name varchar(30), 
 sex varchar(20),
 qualification varchar(30),
 start_date date,
 PRIMARY KEY(NIN), 
 Foreign Key(NIN) REFERENCES school(identificationno)
 on update cascade on delete cascade,
 Foreign Key(NIN) REFERENCES teacher(NIN)
 on update cascade on delete cascade);

CREATE TABLE pupil(
pupil_ID int,
 first_name varchar(30), 
 last_name varchar(30), 
 sex varchar(20), 
 dob date,
 PRIMARY KEY(pupil_ID), 
 Foreign Key(pupil_ID) REFERENCES school(identificationno)
 on update cascade on delete cascade);

CREATE TABLE subject(
subjecttitle varchar(40),
 type varchar(30), 
 pupil_ID int, 
 PRIMARY KEY(subjecttitle), 
 Foreign Key(pupil_ID) REFERENCES pupil(pupil_ID)
 on update cascade on delete cascade);

CREATE TABLE teaches( 
numofhours int,
 NIN int , 
 subjecttitle varchar(40),
 Foreign Key(NIN) REFERENCES teacher(NIN)
 on update cascade on delete cascade, 
 Foreign Key(subjecttitle) REFERENCES subject(subjecttitle)
 on update cascade on delete cascade);
 
 /*solution to question 3*/
CREATE DATABASE IF NOT EXISTS BUSYBEE_CLEANING_COMPANY;
USE BUSYBEE_CLEANING_COMPANY;

DROP TABLE BusyBee;
DROP TABLE client;
DROP TABLE cleaningstaff;
DROP TABLE adminisrativestaff;
DROP TABLE squad;
DROP TABLE administrator;
DROP TABLE cleaningsupervisor;
DROP TABLE cleaningjob;

create table BusyBee(
areacode int primary key );

create table client (
client_id int primary key ,
company_name varchar(30)  ,
company_type varchar(30),
Foreign Key(client_id) REFERENCES BusyBee(areacode)
on update cascade on delete cascade );

create table cleaningstaff(
id_cleaningstaff int primary key,
first_name varchar(30),
last_name varchar(30),
Foreign Key(idc) REFERENCES BusyBee(areacode)
on update cascade on delete cascade
);

create table administrativestaff(
id int primary key,
first_name varchar(30),
last_name varchar(30),
type_of_work varchar(30),
Foreign Key(id) REFERENCES BusyBee(areacode)
on update cascade on delete cascade
);

create table squad(          
groupno int primary key,
groupmember varchar(30),
id_cleaningstaff int ,
Foreign Key(id_cleaningstaff) REFERENCES cleaningstaff(id_cleaningstaff)
on update cascade on delete cascade
);

create table administrator(
id_admin int primary key,
first_name varchar(30),
last_name varchar(30),
Foreign Key(id_admin) REFERENCES administrativestaff(id)
on update cascade on delete cascade
);

create table cleaningsupervisor(
id_supervisor int primary key,
first_name varchar(30),
last_name varchar(30),
groupno int,
Foreign Key(id_supervisor) REFERENCES squad(groupno)
on update cascade on delete cascade
);

create table cleaning_job(
Cleaning_hour int primary key ,
specific_type_of_cleaningjob_name varchar(30),
cleaning_specific_equipment varchar(30),
no_of_job int,
time int,
day varchar(10),
id_admin int,
groupno int,
id_supervisor int,
client_id int,
Foreign Key(Cleaning_hour) REFERENCES administrator(id_admin)
on update cascade on delete cascade,
Foreign Key(groupno) REFERENCES squad(groupno)
on update cascade on delete cascade,
Foreign Key(id_supervisor) REFERENCES cleaningsupervisor(id_supervisor)
on update cascade on delete cascade,
Foreign Key(client_id) REFERENCES client(client_id)
on update cascade on delete cascade
);


 

