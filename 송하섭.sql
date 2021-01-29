==========과제==================
===========문제11===============
 
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR hiredate >= TO_DATE('19810601', 'yyyymmdd');

============문제12===================
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR EMPNO  LIKE '78%%';
=============문제13===================
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR EMPNO >= 7800 AND EMPNO <= 7899;
=============문제14===================
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR EMPNO LIKE '78%' 
  AND hiredate >= TO_DATE('19810601','yyyymmdd');
  =====================================
