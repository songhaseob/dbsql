1번문제
SELECT ename,hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101','yyyymmdd') AND hiredate <= TO_DATE('19830101');

2번문제
SELECT *
FROM emp
WHERE JOB = 'SALESMAN' AND hiredate >= TO_DATE('19810601','yyyymmdd');

3번문제
SELECT *
FROM emp
WHERE deptno NOT IN( 10) AND hiredate >= TO_DATE('19810601','yyyymmdd');

4번문제
SELECT ROWNUM,empno,ename
FROM emp
WHERE ROWNUM < 15
ORDER BY empno;

5번문제
SELECT *
FROM emp
WHERE deptno IN (10,30) AND sal > 1500
ORDER BY ename desc;

6번문제
SELECT deptno,max(sal)MAX_SAL,min(sal)MIN_SAL,round(avg(sal),2)AVG_SAL
FROM emp
GROUP BY deptno;

7번문제
SELECT e.empno,e.ename,e.sal,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal > 2500 AND e.empno > 7600 AND d.dname IN ('RESEARCH');



8번문제
SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND d.deptno in (10,30)
ORDER BY empno;

9번문제

SELECT *
FROM emp
WHERE mgr = (SELECT ename,mgr
FROM emp         ----------돌대가리인가...........어제풀었는데...........
WHERE mgr is null);

10번문제
SELECT TO_CHAR(hiredate,'yyyymm')hire_yyyymm,count(*)cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyymm');

11번문제
SELECT *
FROM emp
WHERE deptno in(SELECT deptno
               FROM emp
               WHERE ename IN ('SMITH') OR ename IN ('WARD'));
               
12번문제
SELECT *
FROM emp
WHERE sal >(SELECT AVG(sal)
FROM emp);

13번 문제
INSERT INTO dept VALUES (99,'ddit','대전');


14번 문제
UPDATE dept SET dname = 'ddit_modi',loc = '대전_modi'
WHERE dname = 'ddit', loc = '대전';

15번문제
DELETE dept
WHERE deptno = 99;


16번문제
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test 
FOREIGN KEY (deptno) REFERENCES dept_test(deptno);

17번문제
SELECT deptno,SUM(sal)sal
FROM emp
GROUP BY ROLLUP (deptno);

18번문제
SELECT ename,sal,deptno,hiredate, rank() OVER (PARTITION BY deptno ORDER BY sal desc,hiredate asc)dept_sal_rank
FROM emp;

19번문제
SELECT empno,ename,hiredate,sal, lead(sal) OVER (ORDER BY sal desc, hiredate asc)lead_sal
FROM emp;

20번문제
SELECT empno,ename,deptno,sal, lag(sal) OVER (ORDER BY sal asc, hiredate asc)c_sum
FROM emp; -------------풀었는데 ㅆ...................ㅂ
