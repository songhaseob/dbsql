hssong.v_emp ==> v_emp

SELECT *
FROM hssong.v_emp;

CREATE SYNONYM v_emp FOR hssong.v_emp;

SELECT *
FROM v_emp;