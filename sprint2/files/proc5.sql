/*
	Creating Procedure to do Transaction Processing i.e,
		Customer is able to Book Flight and Result Goes to Booking Details TABLE.
				If booked with Status 'B' Then Inserts Row in Ticket Details TABLE.
*/
CREATE OR REPLACE PROCEDURE book_flight(p_user IN OUT NUMBER,p_pass IN VARCHAR2,p_origin IN NUMBER,
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
/
/* 
	--Create Sequence because used in Procedure

	CREATE SEQUENCE booking
		START WITH 1000
		INCREMENT BY 10;


SQL>DECLARE
		user NUMBER:=102;
		pass VARCHAR2(20):='ronaldo@123';
		origin NUMBER:=1060;
		dest NUMBER:=1020;
		fno VARCHAR2(10):='B1004';
		amount NUMBER:=7049;
	BEGIN
		book_flight(user,pass,origin,dest,fno,amount);
	END;
	/
*/
