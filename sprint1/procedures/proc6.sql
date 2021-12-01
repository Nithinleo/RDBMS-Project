/*
	Creating Procedure to do Transaction Processing i.e,
		Customer is able to CANCEL the Flight and Status in Bookings Details TABLE Changes to CANCELLED.
			ALSO delete Ticket Information FROM Ticket Details TABLE.
*/
CREATE OR REPLACE PROCEDURE cancel_flight (p_user IN NUMBER, p_pass IN VARCHAR2, p_booking_no IN OUT NUMBER) IS
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
			DBMS_OUTPUT.PUT_LINE ('-----No Data is Found-----');
END cancel_flight;
/

/*
	DECLARE
		bookno NUMBER(10) := 1000;
	BEGIN
		cancel_flight(100,'nithinleo12',bookno);
	END;
	/
*/