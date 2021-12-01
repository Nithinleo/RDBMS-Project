/*
	Creating a Procedure to List all Customers Who did not Place any Bookings.
*/

CREATE OR REPLACE PROCEDURE no_booking_details IS

CURSOR cust_dtls IS SELECT customer_id, first_name, last_name
		FROM customer_master WHERE customer_id NOT IN ( SELECT customer_id FROM booking_details )
			ORDER BY customer_id;
v_id customer_master.customer_id%TYPE;
v_fname customer_master.first_name%TYPE;
v_lname customer_master.last_name%TYPE;
A EXCEPTION;

BEGIN
	DBMS_OUTPUT.PUT_LINE ('----------------------------------');
	DBMS_OUTPUT.PUT_LINE ('----Customers With No Bookings----');
	DBMS_OUTPUT.PUT_LINE ('----------------------------------');
	DBMS_OUTPUT.PUT_LINE ('ID:   '||'   Customer Name');
	DBMS_OUTPUT.PUT_LINE ('--------------------------');
	OPEN cust_dtls;
	LOOP
		FETCH cust_dtls INTO v_id, v_fname, v_lname;
		IF cust_dtls%NOTFOUND AND cust_dtls%ROWCOUNT = 0 THEN
			RAISE A;
		END IF;
		EXIT WHEN cust_dtls%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE ('   '||v_id||'       '||INITCAP(v_fname)||' '||INITCAP(v_lname));
	END LOOP;
	CLOSE cust_dtls;
	EXCEPTION
		WHEN A THEN
			DBMS_OUTPUT.PUT_LINE ('--There are No Customers without Bookings--');
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE ('--OTHER Errors--');
END no_booking_details;
/

/*
	EXEC no_booking_details;
*/