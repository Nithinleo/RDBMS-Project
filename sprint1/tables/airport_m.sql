/* Creating Airpot Master TABLE
	 Giving airport_code as PRIMARY KEY
	 Adding Constraint to city_id FOREIGN KEY which reference to city_master TABLE
*/

CREATE TABLE airport_master
(
	airport_code	NUMBER(5) CONSTRAINT airp_code_pk PRIMARY KEY,
	airport_name	VARCHAR2(40),
	city_id	CHAR(5) CONSTRAINT airport_city_fk 
			REFERENCES city_mast(city_id) ON DELETE CASCADE,
	airport_tax	NUMBER(8,2)
);

--Inserting values into Airport Master TABLE

INSERT INTO airport_master VALUES (1010,'Shamshabad Airport','HYD',1299);
INSERT INTO airport_master VALUES (1020,'Indira Gandhi International Airport','DL',1599);
INSERT INTO airport_master VALUES (1030,'Shivaji Maharaj Airport','MB',1099);
INSERT INTO airport_master VALUES (1040,'Chennai International Airport','CHN',1299);
INSERT INTO airport_master VALUES (1050,'Netaji Subash ChandraBose Airport','KL',1199);
INSERT INTO airport_master VALUES (1060,'Kempegowda Airport','BGL',999);
INSERT INTO airport_master VALUES (1070,'Pune International Airport','PU',599);
INSERT INTO airport_master VALUES (1080,'JayaPrakash Narayan Airport','PA',900);
INSERT INTO airport_master VALUES (1090,'Jaipur International Airport','JP',199);