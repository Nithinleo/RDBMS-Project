/*
	Creating a Procedure to Display all Customer's First_name, Last_name
		Phone_no and Email. Sorting them by Customer ID
		Taking Customer_id as Input Parameter to Procedure
*/

/*
	CREATE OR REPLACE FUNCTION format_phone ( p_phone_no IN OUT VARCHAR2 ) RETURN VARCHAR2 PARALLEL_ENABLE
	IS
	BEGIN
		p_phone_no := '+91('||SUBSTR(p_phone_no,1,3)||')'||SUBSTR(p_phone_no,4,3)||'-'||SUBSTR(p_phone_no,7);
		RETURN p_phone_no;
	END format_phone;
	/
*/

/*
	SubProgram Inlining :-

	SQL> CONN / AS SYSDBA
	SQL> ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 3;
*/

CREATE OR REPLACE PROCEDURE customer_details(p_cust_id IN NUMBER,
						p_fname OUT customer_master.first_name%TYPE,
						p_lname OUT customer_master.last_name%TYPE)
IS
--DECLARE
no_data EXCEPTION;
PRAGMA EXCEPTION_INIT(no_data,100);
-- (-1403 ) ORACLE error code cannot be used, so we use SQLCODE (ANSI Standards)
v_id customer_master.customer_id%TYPE;
v_gender customer_master.gender%TYPE;
v_age NUMBER(3);
v_phn1 VARCHAR2(20);
v_phn2 VARCHAR2(20);
v_email1 customer_email.email_id1%TYPE;
v_email2 customer_email.email_id2%TYPE;
v_fax1 customer_fax_mast.fax_num1%TYPE;
v_fax2 customer_fax_mast.fax_num2%TYPE;
BEGIN
	SELECT customer_id, first_name, last_name, gender, age, phone1, phone2, email_id1, email_id2, fax_num1, fax_num2
		INTO v_id, p_fname, p_lname, v_gender, v_age, v_phn1, v_phn2, v_email1, v_email2, v_fax1, v_fax2
			FROM customer_master NATURAL JOIN customer_phn_mast NATURAL JOIN customer_email NATURAL JOIN customer_fax_mast
				WHERE customer_id = p_cust_id;
	DBMS_OUTPUT.PUT_LINE ('-------------------------------------');
	DBMS_OUTPUT.PUT_LINE ('-----------CUSTOMER DETAILS----------');
	DBMS_OUTPUT.PUT_LINE ('-------------------------------------');
	DBMS_OUTPUT.PUT_LINE ('Customer ID: '||v_id);
	DBMS_OUTPUT.PUT_LINE ('Customer Name: '||INITCAP(p_fname)||' '||INITCAP(p_lname));
	DBMS_OUTPUT.PUT_LINE ('Gender: '||v_gender);
	DBMS_OUTPUT.PUT_LINE ('Age: '||v_age);
	--Displaying Phone Numbers
	--Used FORMAT_PHONE Function.

	PRAGMA INLINE (format_phone, 'YES');

	IF v_phn1 IS NOT NULL AND v_phn2 IS NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Phone No: '||FORMAT_PHONE(v_phn1));
	ELSIF v_phn1 IS NULL AND v_phn2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Phone No: '||FORMAT_PHONE(v_phn2));
	ELSIF v_phn1 IS NOT NULL AND v_phn2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Phone No1: '||FORMAT_PHONE(v_phn1));
		DBMS_OUTPUT.PUT_LINE ('Phone No2: '||FORMAT_PHONE(v_phn2));
	END IF;
	--Displaying Email ID
	IF v_email1 IS NOT NULL AND v_email2 IS NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Email ID: '||v_email1);
	ELSIF v_email1 IS NULL AND v_email2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Email ID: '||v_email2);
	ELSIF v_email1 IS NOT NULL AND v_email2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Email ID1: '||v_email1);
		DBMS_OUTPUT.PUT_LINE ('Email ID2: '||v_email2);
	END IF;
	--Displaying Fax Number
	IF v_fax1 IS NOT NULL AND v_fax2 IS NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Fax Number: '||v_fax1);
	ELSIF v_fax1 IS NULL AND v_fax2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Fax Number: '||v_fax2);
	ELSIF v_fax1 IS NOT NULL AND v_fax2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Fax Number1: '||v_fax1);
		DBMS_OUTPUT.PUT_LINE ('Fax Number2: '||v_fax2);
	ELSE
		DBMS_OUTPUT.PUT_LINE ('Fax Number: '||'Not Availablie');
	END IF;
	DBMS_OUTPUT.PUT_LINE ('-------------------------------------');

	EXCEPTION
		WHEN no_data THEN
			DBMS_OUTPUT.PUT_LINE ('-----Please Enter Correct Customer ID-----');
			
END customer_details;
/

/*
DECLARE
	fname customer_master.first_name%TYPE;
	lname customer_master.last_name%TYPE;
BEGIN
	customer_details (101,fname,lname);
END;
/

*/