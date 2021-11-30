/* Creating Customer Fax Master TABLE
	 Adding customer_id as FOREIGN KYE which references to 
		PRIMARY KEY(customer_id) in customer_master TABLE
*/

CREATE TABLE customer_fax_mast
(
	customer_id	NUMBER(10) CONSTRAINT cust_fax_fk 
			REFERENCES customer_master(customer_id) ON DELETE CASCADE,
	fax_num1	VARCHAR2(20),
	fax_num2	VARCHAR2(20)
);


--Inserting Values into Customer FAX Master TABLE.

INSERT INTO customer_fax_mast VALUES (100,'+44 (161) 999 8888','');
INSERT INTO customer_fax_mast VALUES (101,'+44 (791) 889 6491','');
INSERT INTO customer_fax_mast VALUES (102,'+43 (791) 012 5591','+91 (781) 661 9721');
INSERT INTO customer_fax_mast VALUES (103,'+49 (471) 764 9010','');
INSERT INTO customer_fax_mast VALUES (104,'+12 (401) 847 0012','+11 (413) 999 0941');
INSERT INTO customer_fax_mast VALUES (105,'','');
INSERT INTO customer_fax_mast VALUES (106,'+44 (001) 019 1103','');
INSERT INTO customer_fax_mast VALUES (107,'+91 (124) 312 9714','+91 (901) 205 6948');
INSERT INTO customer_fax_mast VALUES (108,'+77 (781) 771 1234','');
INSERT INTO customer_fax_mast VALUES (109,'+32 (479) 666 9000','+33 (471) 790 0000');