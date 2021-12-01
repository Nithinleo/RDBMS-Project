-- Creating City Master TABLE
-- city_id is a PRIMARY KEY

CREATE TABLE city_mast
(
	city_id	CHAR(5) CONSTRAINT city_id_pk PRIMARY KEY,
	city_name	VARCHAR2(20)
);

--Inserting values into City_master Table

INSERT INTO city_mast VALUES('HYD','Hyderabad');
INSERT INTO city_mast VALUES('DL','Delhi');
INSERT INTO city_mast VALUES('KL','Kolkatha');
INSERT INTO city_mast VALUES('CHN','Chennai');
INSERT INTO city_mast VALUES('BGL','Bangalore');
INSERT INTO city_mast VALUES('MB','Mumbai');
INSERT INTO city_mast VALUES('PU','Pune');
INSERT INTO city_mast VALUES('JP','Jaipur');
INSERT INTO city_mast VALUES('LK','Lucknow');
INSERT INTO city_mast VALUES('PA','Patna');