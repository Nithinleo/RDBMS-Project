CREATE OR REPLACE FUNCTION format_phone ( p_phone_no IN OUT VARCHAR2 ) RETURN VARCHAR2
PARALLEL_ENABLE -- Optimizer HINT 
IS
BEGIN
	p_phone_no := '+91('||SUBSTR(p_phone_no,1,3)||')'||SUBSTR(p_phone_no,4,3)||'-'||SUBSTR(p_phone_no,7);
	RETURN p_phone_no;
END format_phone;
/