/*
	Creating Booking Details TABLE
		Constraints with ON DELETE CONSTRAINT:
			booking_no AS PRIMARY KEY,
			customer_id as FOREIGN KEY which References to Customer Master TABLE,
			class_id as FOREIGN KEY which References to Class Master TABLE,
			airport_code as FOREIGN KEY which References to Airpot Master TABLE,
			status_id as FOREIGN KEY which References to Status Master TABLE,
			Some other attribues as COMPOSITE FOREIGN KEY which 
					References to COMPOSITE PRIMARY KEYS of Flight Availability TABLE.
*/

CREATE TABLE booking_details
(
	booking_no	NUMBER(5) CONSTRAINT booking_pk	PRIMARY KEY,
	booking_city	VARCHAR2(10),
	booking_date	DATE NOT NULL,
	customer_id	NUMBER(10) CONSTRAINT book_cust_fk	
			REFERENCES customer_master(customer_id) ON DELETE CASCADE NOT NULL,
	flight_no	VARCHAR2(10) NOT NULL,
	class_id	NUMBER(2)	CONSTRAINT book_class_fk
			REFERENCES	class_master(class_id) ON DELETE CASCADE NOT NULL,
	airport_code	NUMBER(5) CONSTRAINT b_aircode_fk
			REFERENCES airport_master(airport_code) ON DELETE CASCADE NOT NULL,
	origin_name	VARCHAR2(40) NOT NULL,
	destination_name VARCHAR2(40) NOT NULL,
	depature_time	TIMESTAMP NOT NULL,
	arrival_time	TIMESTAMP NOT NULL,
	flight_price NUMBER(8,2) NOT NULL,
	total_price NUMBER(8,2) NOT NULL,
	amount_paid NUMBER(8,2) NOT NULL,
	amt_paid_by VARCHAR2(20),
	balance NUMBER(8,2) NOT NULL,
	status_id	CHAR(1) CONSTRAINT b_statusid_fk
			REFERENCES status_master(status_id),
	CONSTRAINT book_dtl_fk FOREIGN KEY (flight_no,depature_time,arrival_time,flight_price)
			REFERENCES flight_availability(flight_no,depature_time,arrival_time,flight_price)
);