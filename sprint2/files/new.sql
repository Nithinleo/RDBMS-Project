CREATE OR REPLACE PROCEDURE new (p_deptno NUMBER, p_table VARCHAR2) IS
v_count NUMBER(2);
v_sql VARCHAR2(100);
BEGIN
v_sql := 'SELECT COUNT(*) FROM :p_table WHERE deptno = :DEPT';
EXECUTE IMMEDIATE v_sql INTO v_count USING p_table,p_deptno;
DBMS_OUTPUT.PUT_LINE('COUNT :'||v_count);
END;
/