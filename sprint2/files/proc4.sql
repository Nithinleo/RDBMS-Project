/*
	Creating Procedure to Show all Cancelled Bookings.
*/

CREATE OR REPLACE PROCEDURE cancelled_bookings IS
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
/

/*
	EXEC cancelled_bookings;
*/