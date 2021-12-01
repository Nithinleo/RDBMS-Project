CREATE OR REPLACE PACKAGE BODY airline IS
	
--Procedure 1
PROCEDURE get_details(p_custid IN OUT NOCOPY NUMBER) IS
--USING NOCOPY Hint to Improve Performance of OUT and IN OUT Parameters in PL/SQL Code
--DECLARE
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
	SELECT /*Number of Bookings*/ COUNT(*) INTO v_bookings FROM booking_details WHERE customer_id = p_custid;
	SELECT CM.first_name, CM.last_name, CE.email_id1, CE.email_id2, CP.phone1, CP.phone2, CF.fax_num1, CF.fax_num2
		INTO fname, lname, v_email1, v_email2, v_phn1, v_phn2, v_fax1, v_fax2
    		FROM customer_master CM JOIN customer_email CE ON (CM.customer_id = CE.customer_id)
    	    	JOIN customer_phn_mast CP ON (CM.customer_id = CP.customer_id)
            	JOIN customer_fax_mast CF ON (CM.customer_id = CF.customer_id)
                	WHERE CM.customer_id = p_custid;
	
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

--Procedure 2
PROCEDURE customer_details(p_cust_id IN NUMBER,
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

--Procedure 3
PROCEDURE no_booking_details IS
--DECLARE
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
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE ('--Some Other Errors--');
END no_booking_details;

--Procedure 4
PROCEDURE cancelled_bookings IS
--DECLARE
TYPE booking_type IS TABLE OF booking_details%ROWTYPE;
booking_table booking_type;

CURSOR c_bookings IS SELECT * BULK COLLECT INTO booking_table
				FROM booking_details WHERE status_id = 'C'
					ORDER BY booking_no, customer_id, flight_no;
v_flag NUMBER := 0;
BEGIN
	DBMS_OUTPUT.PUT_LINE ('----------------------------------------');
	DBMS_OUTPUT.PUT_LINE ('-----------CANCELLED BOOKINGS-----------');
	DBMS_OUTPUT.PUT_LINE ('----------------------------------------');
	FOR i IN c_bookings LOOP
		v_flag := 1;
		DBMS_OUTPUT.PUT_LINE ('Booking No: '||i.booking_no);
		DBMS_OUTPUT.PUT_LINE ('Customer ID: '||i.customer_id);
		DBMS_OUTPUT.PUT_LINE ('Flight No: '||i.flight_no);
		DBMS_OUTPUT.PUT_LINE ('Origin: '||i.origin_name);
		DBMS_OUTPUT.PUT_LINE ('Desination: '||i.destination_name);
		DBMS_OUTPUT.PUT_LINE ('Booking City: '||i.booking_city);
		DBMS_OUTPUT.PUT_LINE ('----------------------------------------');
	END LOOP;
	IF v_flag = 0 THEN
		DBMS_OUTPUT.PUT_LINE ('###### NO DATA FOUND ######');
	END IF;
END cancelled_bookings;

--Procedure 5
PROCEDURE book_flight(p_user IN OUT NUMBER,p_pass IN VARCHAR2,p_origin IN NUMBER,
					p_dest IN NUMBER,p_fno IN VARCHAR2,p_amount IN NUMBER) IS
PRAGMA AUTONOMOUS_TRANSACTION;
--DECLARE
c_pass VARCHAR2(20);
fname customer_master.first_name%TYPE;
lname customer_master.last_name%TYPE;
ccity customer_address.city%TYPE;
v_fno VARCHAR2(10);
v_dtime flight_availability.depature_time%TYPE;
v_atime flight_availability.arrival_time%TYPE;
v_fprice NUMBER(8,2);
a_taxprice NUMBER(8,2);
v_ftotalprice NUMBER(8,2);
v_balance NUMBER(8,2);
cl_id flight_master.class_id%TYPE;
an_origin airport_master.airport_name%TYPE;
an_dest airport_master.airport_name%TYPE;
v_status booking_details.status_id%TYPE;
v_tno ticket_details.ticket_no%TYPE;
v_bno NUMBER;

BEGIN
	SELECT password INTO c_pass 
			FROM customer_login_dtls WHERE customer_id = p_user;
	SELECT first_name, last_name, city INTO fname, lname, ccity
			FROM customer_master JOIN customer_address USING (customer_id) 
				WHERE customer_id = p_user;
	IF p_pass = c_pass THEN
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');
		DBMS_OUTPUT.PUT_LINE ('LOGIN SUCESSFULL');
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');
		DBMS_OUTPUT.PUT_LINE ('WELCOME: '||UPPER(fname)||' '||UPPER(lname));
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');
		DBMS_OUTPUT.PUT_LINE ('Selected Origin: '||p_origin);
		DBMS_OUTPUT.PUT_LINE ('Selected Destination:  '||p_dest);
		SELECT flight_no, depature_time, arrival_time, flight_price
			INTO v_fno, v_dtime, v_atime, v_fprice 
				FROM flight_availability 
					WHERE flight_no = p_fno AND origin = p_origin AND destination = p_dest ;
		SELECT airport_tax INTO a_taxprice FROM airport_master WHERE airport_code = p_origin;
		SELECT /*ORIGIN*/airport_name INTO an_origin FROM airport_master WHERE airport_code = p_origin;
		SELECT /*DESTINATION*/airport_name INTO an_dest FROM airport_master WHERE airport_code = p_dest;
		/*Flight Total Price*/ v_ftotalprice := v_fprice + a_taxprice;
		--Balance Amount to be paid (if exists)
		v_balance := v_ftotalprice - p_amount;
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');
		DBMS_OUTPUT.PUT_LINE ('FLIGHT DETAILS:  ');
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');
		DBMS_OUTPUT.PUT_LINE ('FLGHT NO. : '||v_fno);
		DBMS_OUTPUT.PUT_LINE ('ORIGIN: '||an_origin);
		DBMS_OUTPUT.PUT_LINE ('DESTINATION: '||an_dest);
		DBMS_OUTPUT.PUT_LINE ('DEPATURE TIME: '||v_dtime);
		DBMS_OUTPUT.PUT_LINE ('ARRIVAL TIME: '||v_atime);
		DBMS_OUTPUT.PUT_LINE ('FLIGHT PRICE: '||v_ftotalprice);
		DBMS_OUTPUT.PUT_LINE ('PAID AMOUNT: '||p_amount);
		DBMS_OUTPUT.PUT_LINE ('BALANCE AMOUNT: '||v_balance);
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');
		--Getting Class ID of a Flight No given
		SELECT class_id INTO cl_id FROM flight_master WHERE flight_no = v_fno;
		IF v_balance = 0 THEN
			v_status := 'B';
		ELSE v_status := 'S';
		END IF;
		--changing available seats in Flight Availability TABLE.
		IF v_status = 'S' OR v_status = 'B' THEN
			IF cl_id = 0 THEN
				UPDATE flight_availability 
					SET available_seats_bc = available_seats_bc - 1,
						booked_seats_bc = booked_seats_bc + 1,
						available_seats_ec = available_seats_ec - 1,
						booked_seats_ec = booked_seats_ec + 1
						WHERE flight_no = v_fno AND origin = p_origin AND destination = p_dest;
			ELSIF cl_id = 1 THEN
				UPDATE flight_availability 
					SET available_seats_bc = available_seats_bc - 1,
						booked_seats_bc = booked_seats_bc + 1
						WHERE flight_no = v_fno AND origin = p_origin AND destination = p_dest;
			ELSIF cl_id = 2 THEN
				UPDATE flight_availability
					SET available_seats_ec = available_seats_ec - 1,
						booked_seats_ec = booked_seats_ec + 1
						WHERE flight_no = v_fno AND origin = p_origin AND destination = p_dest;
			END IF;
		END IF;
		v_bno := booking.NEXTVAL;
		--Inserting Values into Booking Details TABLE.
		INSERT INTO booking_details VALUES (v_bno,ccity,current_date,p_user,v_fno,cl_id,
					p_origin,an_origin,an_dest,v_dtime,v_atime,v_fprice,v_ftotalprice,p_amount,
					fname,v_balance,v_status);
		--IF Status is Booked Inserting Booking Details values into Ticket Details TABLE
		IF v_status = 'B' THEN
			v_tno := DBMS_RANDOM.STRING('U',10);
			DBMS_OUTPUT.PUT_LINE ('Booking is Confirmed and Details as been Inserted in Ticket Details TABLE.');
			INSERT INTO ticket_details VALUES (v_tno,v_bno,p_user);
		END IF;
		COMMIT;
	ELSE
		DBMS_OUTPUT.PUT_LINE ('Hello! '||INITCAP(fname)||', '||'Your Password is Wrong.');
	END IF;

	EXCEPTION
		WHEN no_data_found THEN
			DBMS_OUTPUT.PUT_LINE ('-----No Data is Found-----');
END book_flight;

--Procedure 6
PROCEDURE cancel_flight (p_user IN NUMBER, p_pass IN VARCHAR2, p_booking_no IN OUT NUMBER) IS
PRAGMA AUTONOMOUS_TRANSACTION;
--DECLARE
c_user NUMBER;
c_pass VARCHAR2(20);
fname customer_master.first_name%TYPE;
lname customer_master.last_name%TYPE;
v_tprice NUMBER(8,2);
v_bal NUMBER(8,2);
v_fprice NUMBER(8,2);
v_fno booking_details.flight_no%TYPE;
v_return NUMBER(8,2);
v_status CHAR(1);
v_acode airport_master.airport_code%TYPE;
v_atax airport_master.airport_tax%TYPE;

BEGIN
	SELECT customer_id, password INTO c_user, c_pass 
			FROM customer_login_dtls WHERE customer_id = p_user;
	SELECT first_name, last_name INTO fname, lname
			FROM customer_master WHERE customer_id = p_user;
	IF c_pass = p_pass THEN
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');
		DBMS_OUTPUT.PUT_LINE ('LOGIN SUCESSFULL');
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');
		DBMS_OUTPUT.PUT_LINE ('Welcome: '||INITCAP(fname)||' '||INITCAP(lname));
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');
		DBMS_OUTPUT.PUT_LINE ('CANCELLED Flight of BOOKING NO: '||p_booking_no);
		DBMS_OUTPUT.PUT_LINE ('------------------------------------');

		SELECT flight_no, flight_price, total_price, balance, status_id, airport_code 
			INTO v_fno, v_fprice, v_tprice, v_bal, v_status, v_acode
				FROM booking_details 
					WHERE booking_no = p_booking_no AND customer_id = p_user;

		SELECT airport_tax INTO v_atax FROM airport_master WHERE airport_code = v_acode;
		-- total price = flight price + airport tax
		-- airport tax is not returned
		v_return := v_atax - v_bal;

		IF v_status = 'B' OR v_status = 'S' THEN
			UPDATE booking_details
				SET status_id = 'C', balance = v_return
					WHERE booking_no = p_booking_no AND customer_id = p_user;
			DBMS_OUTPUT.PUT_LINE ('Remaining Amount= '||v_return||' , Will be Credited to your BANK.');
		ELSIF v_status = 'C' THEN
			DBMS_OUTPUT.PUT_LINE ('Flight is Already CANCELLED.');
		END IF;

		DELETE FROM ticket_details 
			WHERE booking_no = p_booking_no AND customer_id = p_user;
		COMMIT;
	ELSE
		DBMS_OUTPUT.PUT_LINE ('Hello! '||INITCAP(fname)||', '||'Your PASSWORD is wrong.');
	END IF;
	EXCEPTION
		WHEN no_data_found THEN
			DBMS_OUTPUT.PUT_LINE ('-----DATA IS NOT FOUND-----');
END cancel_flight;

END airline;
/