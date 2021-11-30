/* Creating Customer Address Table
 Adding CONSTRAINT cust_addr_fk as FOREIGN KEY which references to 
		PRIMARY KEY(customer_id) in customer_master TABLE
	Also, giving ON DELETE CASCADE Constraint to it.
*/

CREATE TABLE customer_address
(
	customer_id CONSTRAINT cust_addr_fk REFERENCES customer_master(customer_id) ON DELETE CASCADE,
	street	VARCHAR2(30),
	city	VARCHAR2(10),
	state 	VARCHAR2(10),
	postalcode	NUMBER(10)
);


--Inserting Values into Customer Address TABLE.

INSERT INTO customer_address VALUES (100,'Royal Streets 101H','Hyderabad','Telangana',500040);
INSERT INTO customer_address VALUES (101,'Brindavan Colony','Warangal','Telangana',540324);
INSERT INTO customer_address VALUES (102,'Street Guys 112OH','Banjara','Tamil Nadu',839694);
INSERT INTO customer_address VALUES (103,'TRS Street 1JK','Mysoore','Bangalore',239841);
INSERT INTO customer_address VALUES (104,'Habibii Colony','Mumbai','Maharastra',489211);
INSERT INTO customer_address VALUES (105,'Netajis Colony','Bombay','Maharastra',571281);
INSERT INTO customer_address VALUES (106,'12H Street','Chennai','Tamil Nadu',687191);
INSERT INTO customer_address VALUES (107,'Niranjaan Colony','kolkatha','WestBengal',772913);
INSERT INTO customer_address VALUES (108,'Sri Bhavaan Streets 1H','Calcutta','WestBengal',772891);
INSERT INTO customer_address VALUES (109,'Dr. APJ Abdul Kalam Road','Delhi','New Delhi',668124);