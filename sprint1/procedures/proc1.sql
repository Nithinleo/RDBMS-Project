/*
	Creating a Procedure to Show number_of_bookings, number_of_emails, 
			number_of_phones, number_of_faxs For each Customer
*/

CREATE OR REPLACE PROCEDURE get_details(p_custid IN NUMBER) IS
v_bookings NUMBER;
v_emails NUMBER;
v_phones NUMBER;
v_faxs NUMBER;
v_email1 customer_email.email_id1%TYPE;
v_email2 customer_email.email_id2%TYPE;
v_phn1 customer_phn_mast.phone1%TYPE;
v_phn2 customer_phn_mast.phone2%TYPE;
v_fax1 customer_fax_mast.fax_num1%TYPE;
v_fax2 customer_fax_mast.fax_num2%TYPE;
fname customer_master.first_name%TYPE;
lname customer_master.last_name%TYPE;

BEGIN
	SELECT COUNT(*) INTO v_bookings FROM booking_details WHERE customer_id = p_custid;
	SELECT first_name, last_name INTO fname, lname FROM customer_master WHERE customer_id = p_custid;
	SELECT email_id1, email_id2 INTO v_email1,v_email2 FROM customer_email WHERE customer_id = p_custid;
	SELECT phone1, phone2 INTO v_phn1, v_phn2 FROM customer_phn_mast WHERE customer_id = p_custid;
	SELECT fax_num1, fax_num2 INTO v_fax1, v_fax2 FROM customer_fax_mast WHERE customer_id = p_custid;

	-- No. of Emails
	IF v_email1 IS NULL AND v_email2 IS NOT NULL THEN 
		v_emails := 1;
    ELSIF v_email1 IS NOT NULL AND v_email2 IS NULL THEN 
    	v_emails := 1;
    ELSIF v_email1 IS NOT NULL AND v_email2 IS NOT NULL THEN
    	v_emails := 2;
    ELSE v_emails := 0;
    END IF;

	-- No. of Phones
	IF v_phn1 IS NULL AND v_phn2 IS NOT NULL THEN 
		v_phones := 1;
    ELSIF v_phn1 IS NOT NULL AND v_phn2 IS NULL THEN 
    	v_phones := 1;
    ELSIF v_phn1 IS NOT NULL AND v_phn2 IS NOT NULL THEN
    	v_phones := 2;
    ELSE v_phones := 0;
    END IF;

    -- No. of Faxs
    IF v_fax1 IS NULL AND v_fax2 IS NOT NULL THEN 
		v_faxs := 1;
    ELSIF v_fax1 IS NOT NULL AND v_fax2 IS NULL THEN 
    	v_faxs := 1;
    ELSIF v_fax1 IS NOT NULL AND v_fax2 IS NOT NULL THEN
    	v_faxs := 2;
    ELSE v_faxs := 0;
    END IF;
    DBMS_OUTPUT.PUT_LINE ('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE ('Details of Customer of ID: '||p_custid);
    DBMS_OUTPUT.PUT_LINE ('Name: '||INITCAP(fname)||' '||INITCAP(lname));
	DBMS_OUTPUT.PUT_LINE ('Total Number of Bookings: '||v_bookings);
	DBMS_OUTPUT.PUT_LINE ('Total Number of Emails: '||v_emails);
	DBMS_OUTPUT.PUT_LINE ('Total Number of Phones: '||v_phones);
	DBMS_OUTPUT.PUT_LINE ('Total Number of Faxs: '||v_faxs);
	DBMS_OUTPUT.PUT_LINE ('--------------------------------------');
	EXCEPTION
		WHEN no_data_found THEN
			DBMS_OUTPUT.PUT_LINE ('----Please Enter Correct Customer ID----');
END get_details;
/

/*
	EXEC get_details(100);
*/