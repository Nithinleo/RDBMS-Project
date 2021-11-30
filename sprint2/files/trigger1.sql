CREATE OR REPLACE TRIGGER btrig
AFTER INSERT OR UPDATE ON booking_details FOR EACH ROW
BEGIN
	INSERT INTO audit_bookings VALUES (:NEW.booking_no,:NEW.customer_id,:OLD.status_id,:NEW.status_id);
END;
/

/*
CREATE GLOBAL TEMPORARY TABLE audit_bookings ( 
	booking_no NUMBER(5), 
	customer_id NUMBER(10), 
	old_status CHAR(1), 
	new_status CHAR(1)) ON COMMIT PRESERVE ROWS;
*/