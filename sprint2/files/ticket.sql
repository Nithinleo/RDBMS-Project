/*
	Creating Ticket Details TABLE
		Constraints:
			Ticket no. as PRIMARY KEY,
			booking_no as FOREING KEY references to Bookings Details TABLE
			customer_id as FOREIGN KEY references to Customer Master TABLE	
*/

CREATE TABLE ticket_details
(
	ticket_no	VARCHAR2(20) CONSTRAINT t_no_pk PRIMARY KEY,
	booking_no	NUMBER(5) CONSTRAINT t_bkno_fk REFERENCES booking_details(booking_no),
	customer_id NUMBER(5) CONSTRAINT t_custid_fk REFERENCES customer_master(customer_id)
);