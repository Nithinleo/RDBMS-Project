CREATE OR REPLACE PACKAGE airline IS
--Procedure 1
	PROCEDURE get_details(p_custid IN OUT NOCOPY NUMBER);
		PRAGMA RESTRICT_REFERENCES(get_details,WNDS);
--Procedure 2
	PROCEDURE customer_details(p_cust_id IN NUMBER,
						p_fname OUT customer_master.first_name%TYPE,
						p_lname OUT customer_master.last_name%TYPE);
		PRAGMA RESTRICT_REFERENCES(customer_details, WNDS);
--Procedure 3
	PROCEDURE no_booking_details;
		PRAGMA RESTRICT_REFERENCES(customer_details, WNDS);
--Procedure 4
	PROCEDURE cancelled_bookings;
		PRAGMA RESTRICT_REFERENCES(customer_details, WNDS);
--Procedure 5
	PROCEDURE book_flight(p_user IN OUT NUMBER,p_pass IN VARCHAR2,p_origin IN NUMBER,
					p_dest IN NUMBER,p_fno IN VARCHAR2,p_amount IN NUMBER);
--Procedure 6
	PROCEDURE cancel_flight (p_user IN NUMBER, p_pass IN VARCHAR2, p_booking_no IN OUT NUMBER);
END airline;
/