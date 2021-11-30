/*
	Creating Flight Availability TABLE
		Adding Constraints, flight_no as FOREIGN KEY which references to Flight Master TABLE
		Origin and Destination as FOREIGN KEY which references to Airport Master TABLE
		Giving some attributes as COMPOSITE PRIMARY KEYS.
*/

CREATE TABLE flight_availability
(
	flight_no VARCHAR2(10) CONSTRAINT favail_fk 
		REFERENCES flight_master(flight_no) ON DELETE CASCADE NOT NULL,
	origin	NUMBER(5) CONSTRAINT f_origin_fk 
		REFERENCES airport_master(airport_code) ON DELETE CASCADE NOT NULL,
	destination NUMBER(5) CONSTRAINT f_dest_fk
		REFERENCES airport_master(airport_code) ON DELETE CASCADE NOT NULL,
	depature_time	TIMESTAMP,
	arrival_time	TIMESTAMP,
	flight_price	NUMBER(8,2),
	available_seats_bc	NUMBER(5) NOT NULL,
	booked_seats_bc	NUMBER(5) NOT NULL,
	available_seats_ec	NUMBER(5) NOT NULL,
	booked_seats_ec	NUMBER(5) NOT NULL,
	CONSTRAINT f_avail_pk PRIMARY KEY (flight_no,depature_time,arrival_time,flight_price)
);


--Inserting Values into Flight Availability TABLE.

INSERT INTO flight_availability VALUES ('A1001',1030,1010,'01-NOV-21 13:00','01-NOV-21 14:45',2000,0,0,95,5);
INSERT INTO flight_availability VALUES ('A1002',1060,1010,'05-NOV-21 11:15','05-NOV-21 13:00',1750,70,10,0,0);
INSERT INTO flight_availability VALUES ('A1003',1040,1030,'25-OCT-21 08:45','25-OCT-21 10:00',1399,0,0,50,50);
INSERT INTO flight_availability VALUES ('A1004',1010,1050,'10-DEC-21 16:00','10-DEC-21 17:00',1299,45,5,0,0);
INSERT INTO flight_availability VALUES ('A1005',1010,1020,'21-NOV-21 23:00','22-NOV-21 00:30',4850,25,15,30,40);
INSERT INTO flight_availability VALUES ('B1001',1020,1030,'29-NOV-21 21:15','30-NOV-21 00:00',3999,60,10,0,0);
INSERT INTO flight_availability VALUES ('B1002',1050,1010,'01-DEC-21 15:45','01-DEC-21 17:05',1900,20,20,35,5);
INSERT INTO flight_availability VALUES ('B1003',1050,1040,'15-NOV-21 00:00','15-NOV-21 01:30',1599,0,0,60,35);
INSERT INTO flight_availability VALUES ('B1004',1060,1020,'12-JAN-21 13:15','12-JAN-21 17:00',6050,25,30,15,60);
INSERT INTO flight_availability VALUES ('B1005',1040,1010,'29-OCT-21 12:00','29-OCT-21 13:50',1450,0,0,25,70);
INSERT INTO flight_availability VALUES ('A1001',1030,1020,'03-NOV-21 18:10','30-NOV-21 20:00',2599,0,0,35,50);
INSERT INTO flight_availability VALUES ('B1001',1020,1040,'05-DEC-21 20:15','05-DEC-21 23:30',3500,15,50,0,0);
INSERT INTO flight_availability VALUES ('A1002',1010,1030,'10-NOV-21 20:00','10-NOV-21 21:45',2500,0,50,0,0);
INSERT INTO flight_availability VALUES ('B1002',1010,1040,'29-OCT-21 11:00','29-OCT-21 12:30',1700,20,35,5,70);
INSERT INTO flight_availability VALUES ('A1003',1010,1060,'20-OCT-21 14:00','20-OCT-21 16:05',1600,0,0,25,65);