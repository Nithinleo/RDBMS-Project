/*
	Creating a Procedure to Display all Customer's First_name, Last_name
		Phone_no and Email. Sorting them by Customer ID
		Taking Customer_id as Input Parameter to Procedure
*/

CREATE OR REPLACE PROCEDURE customer_details(p_cust_id IN NUMBER,
						p_fname OUT customer_master.first_name%TYPE,
						p_lname OUT customer_master.last_name%TYPE)
IS
v_id	customer_master.customer_id%TYPE;
v_gender customer_master.gender%TYPE;
v_age NUMBER(3);
v_phn1	VARCHAR2(20);
v_phn2	VARCHAR2(20);
v_email1 customer_email.email_id1%TYPE;
v_email2 customer_email.email_id2%TYPE;
BEGIN
	SELECT c.customer_id, c.first_name, c.last_name, c.gender, c.age, p.phone1, p.phone2, e.email_id1, e.email_id2
		INTO v_id, p_fname, p_lname, v_gender, v_age, v_phn1, v_phn2, v_email1, v_email2
			FROM customer_master c, customer_phn_mast p, customer_email e
				WHERE c.customer_id = p.customer_id 
					AND c.customer_id = e.customer_id AND c.customer_id = p_cust_id;
	DBMS_OUTPUT.PUT_LINE ('-------------------------------------');
	DBMS_OUTPUT.PUT_LINE ('-----------CUSTOMER DETAILS----------');
	DBMS_OUTPUT.PUT_LINE ('-------------------------------------');
	DBMS_OUTPUT.PUT_LINE ('Customer ID: '||v_id);
	DBMS_OUTPUT.PUT_LINE ('Customer Name: '||INITCAP(p_fname)||' '||INITCAP(p_lname));
	DBMS_OUTPUT.PUT_LINE ('Gender: '||v_gender);
	DBMS_OUTPUT.PUT_LINE ('Age: '||v_age);
	--USED FORMAT_PHONE Function.
	IF v_phn1 IS NOT NULL AND v_phn2 IS NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Phone No: '||FORMAT_PHONE(v_phn1));
	ELSIF v_phn1 IS NULL AND v_phn2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Phone No: '||FORMAT_PHONE(v_phn2));
	ELSIF v_phn1 IS NOT NULL AND v_phn2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Phone No1: '||FORMAT_PHONE(v_phn1));
		DBMS_OUTPUT.PUT_LINE ('Phone No2: '||FORMAT_PHONE(v_phn2));
	END IF;
	IF v_email1 IS NOT NULL AND v_email2 IS NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Email ID: '||v_email1);
	ELSIF v_email1 IS NULL AND v_email2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Email ID: '||v_email2);
	ELSIF v_email1 IS NOT NULL AND v_email2 IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE ('Email ID1: '||v_email1);
		DBMS_OUTPUT.PUT_LINE ('Email ID2: '||v_email2);
	END IF;
	DBMS_OUTPUT.PUT_LINE ('-------------------------------------');
	EXCEPTION
		WHEN no_data_found THEN
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


	CREATE OR REPLACE FUNCTION format_phone ( p_phone_no IN OUT VARCHAR2 ) RETURN VARCHAR2
	IS
	BEGIN
		p_phone_no := '+91('||SUBSTR(p_phone_no,1,3)||')'||SUBSTR(p_phone_no,4,3)||'-'||SUBSTR(p_phone_no,7);
		RETURN p_phone_no;
	END format_phone;

*/