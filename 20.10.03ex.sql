SELECT *
FROM lprod;

SELECT buyer_id,buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id,mem_pass,mem_name
FROM member;

SELECT prod_id id,prod_name name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;

SELECT 'SELECT * FROM' || ' ' || table_name ||';'query
FROM user_tables;

SELECT ename,hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','yyyymmdd') AND  TO_DATE('19830101','yyyymmdd');

SELECT ename,hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101','YYYYMMDD') AND hiredate <=TO_DATE ('19830101','YYYYMMDD');

SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid IN ('brown','cony','sally');

SELECT mem_id,mem_name
FROM member
WHERE mem_name LIKE '신%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('19810601','yyyymmdd');

SELECT *
FROM emp
WHERE deptno != 10 AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE deptno IN (20,30) AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE deptno NOT IN (10) AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job='SALESMAN' OR hiredate >= TO_DATE('19810601','yyyymmdd');

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%';

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno >= 7800 AND empno <= 7899;

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%%' AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY deptno asc;

SELECT *
FROM emp
WHERE comm != 0
ORDER BY comm desc;

SELECT *
FROM emp
WHERE mgr is not null
ORDER BY job, empno desc;

SELECT *
FROM emp
WHERE deptno IN (10,30) AND sal > 1500
ORDER BY ename desc;

SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM < 10;

SELECT *
FROM
(SELECT ROWNUM rn,empno,ename
FROM emp)
WHERE rn >= 11 AND rn <= 20;

SELECT *
FROM(SELECT ROWNUM rn,empno,ename
FROM(SELECT empno,ename
FROM emp
ORDER BY ename asc))
WHERE rn >= 11 AND rn <=20;

SELECT TO_DATE('20191231','yyyy/mm/dd') LASTDAY,
       TO_DATE('20191231','yyyy/mm/dd') -5 LASTDAY_BEFORE5,
       TO_DATE(SYSDATE,'yyyy/mm/dd')NOW,
       TO_DATE(SYSDATE,'yyyy/mm/dd')-3 NOW_BEFORE3
FROM dual;

SELECT TO_CHAR(sysdate,'yyyy-mm-dd') dt_dash,
       TO_CHAR(sysdate,'yyyy-mm-dd hh-mi-ss') dt_dash_with_time,
       TO_CHAR(sysdate,'dd-mm-yyyy') dt_dd_mm_yyyy
FROM dual;

SELECT empno,ename,
       NVL(mgr,null) mgr_n,
       NVL2(mgr,mgr,9999) mgr_n_1,
       COALESCE(mgr,9999) mgr_n_2
FROM emp;

SELECT userid,usernm,reg_dt,NVL(reg_dt,sysdate) n_reg_dt
FROM users
WHERE userid NOT IN ('brown');

SELECT empno, ename,
       decode(deptno, 10, 'ACCOUNTING',
                      20, 'RESEARCH',
                      30, 'SALES',
                      40, 'OPERATIONS',
                      'DDIT')DNAME
FROM emp;

SELECT MAX(sal) max_sal ,
       MIN(sal) min_sal,
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(sal) count_sal,
       COUNT(mgr) count_mgr,
       COUNT(*) count_all
FROM emp;

SELECT deptno,
       MAX(sal) max_sal,
       MIN(sal) min_sal,
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal) sum_sal,
       count(sal) count_sal,
       count(mgr) count_mgr,
       count(*) count_all
FROM emp
GROUP BY deptno;

SELECT decode(deptno,10,'ACCOUNTING',
                     20, 'RESEARCH',
                     30, 'SALES')DNAME,
                     MAX(sal) max_sal,
                     MIN(sal) min_sal,
                     ROUND(AVG(sal),2) avg_sal,
                     SUM(sal) sum_sal,
                     count(sal) count_sal,
                     count(mgr) count_mgr,
                     count(*) count_all
FROM emp
GROUP BY deptno
ORDER BY dname;

SELECT TO_CHAR(hiredate,'yyyymm')hire_yyyymm,COUNT(*)cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyymm');

SELECT TO_CHAR(hiredate,'yyyy')hire_yyyymm, count(*)cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyy');

SELECT count(*) cnt
FROM dept;

SELECT COUNT(*) CNT
FROM
(SELECT deptno
FROM emp
GROUP BY deptno);

SELECT e.empno, e.ename, d.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno = d.deptno
ORDER BY d.deptno;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.deptno IN(10,30) AND d.deptno IN(10,30);

SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal > 2500
ORDER BY sal desc;

SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal > 2500 AND e.empno > 7600;

SELECT e.empno,e.ename,e.sal,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal > 2500 AND e.empno > 7600 AND dname IN ('RESEARCH')
ORDER BY e.empno desc;

SELECT l.lprod_gu, l.lprod_nm, p.prod_id,p.prod_name
FROM lprod l, prod p
WHERE p.prod_lgu = l.lprod_gu;

SELECT b.buyer_id, b.buyer_name,p.prod_id,p.prod_name
FROM buyer b, prod p
WHERE b.buyer_lgu = p.prod_lgu
ORDER BY p.prod_id;

SELECT *
FROM customer;

SELECT c.cid, c.cnm, y.pid,y.day,y.cnt
FROM customer c, cycle y
WHERE c.cid = y.cid AND c.cnm IN ('brown','sally');

SELECT c.cid,c.cnm,y.pid,p.pnm,sum(y.cnt)
FROM customer c, cycle y, product p
WHERE c.cid = y.cid AND y.pid = p.pid
GROUP BY c.cid,c.cnm,y.pid,p.pnm;

SELECT c.pid,p.pnm,sum(c.cnt)
FROM cycle c, product p
WHERE c.pid = p.pid
GROUP BY c.pid,p.pnm;

SELECT c.region_id,r.region_name,c.country_name
FROM countries c, regions r
WHERE c.region_id = r.region_id AND r.region_name IN ('Europe');

SELECT b.buy_date,b.buy_prod,p.prod_id,p.prod_name,b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id AND b.buy_date(+) = TO_DATE('05/01/25','YY/MM/DD');

SELECT NVL(b.buy_date,'05/01/25'),b.buy_prod,p.prod_id,p.prod_name,NVL(b.buy_qty,0)
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id AND b.buy_date(+) = TO_DATE('05/01/25','YY/MM/DD');

SELECT c.cid,p.pnm,:cid cid,NVL(c.day,0),NVL(c.cnt,0)
FROM cycle c, product p
WHERE c.pid(+) = p.pid AND c.cid(+)= 1;

SELECT *
FROM customer,product;

SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
FROM emp
WHERE deptno IN('20','30'));

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
FROM emp
WHERE ename = 'SMITH' OR ename = 'WARD');

INSERT INTO dept VALUES (99,'ddit','daejeon');

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
FROM emp);

SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
from cycle
WHERE cid= 1);

SELECT *
FROM cycle
WHERE cid = 1 AND pid IN
(SELECT pid
FROM cycle 
WHERE cid=2);

SELECT *
FROM cycle
WHERE cid =1 
AND pid  IN (SELECT Pid
             FROM cycle
             WHERE cid = 2);
             
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test
FOREIGN KEY (deptno) REFERENCES dept_test(deptno);

SELECT empno,ename,sal,deptno, ROUND(AVG(sal) OVER (PARTITION BY deptno),2) AVG_SAL 
from emp;

SELECT empno,ename,sal,deptno,MAX(sal) OVER (PARTITION BY deptno)
FROM emp;

SELECT empno,ename,sal,deptno,min(sal) OVER (PARTITION BY deptno)
FROM emp;

SELECT empno,ename,hiredate,sal, LAG(sal) OVER (ORDER BY sal DESC, hiredate ASC)LAG_SAL
FROM emp
ORDER BY sal DESC, hiredate ASC;

SELECT empno,ename,hiredate,sal,LAG(sal) OVER (ORDER BY sal DESC, hiredate ASC)LAG_SAL
FROM emp;

SELECT empno,ename,hiredate,sal,LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC,hiredate ASC)LAG_SAL
FROM emp;


SELECT empno,ename,deptno,sal,
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal, empno
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

SELECT job,deptno,SUM(SAL),
        DECODE(job,null,'총계')sal
FROM EMP
GROUP BY ROLLUP(job,deptno);

SELECT deptno,job,sum(sal + NVL(comm,0))sal
FROM emp
GROUP BY ROLLUP(deptno,job);

SELECT decode(deptno, 10, 'ACCOUNTING',
                      20, 'RESEARCH',
                      30, 'SALES'),
       job,sum(sal + NVL(comm,0))sal
FROM emp
GROUP BY ROLLUP(deptno,job);

SELECT dept.dname,emp.job, sum(emp.sal + NVL(comm,0))sal
FROM emp,dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname,job);

SELECT d.dname,e.job,sum(e.sal + NVL(comm,0))sal
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP(dname,job)
ORDER BY d.dname, sal desc;

SELECT deptno,job,sum(sal + NVL(comm,0))sal
FROM emp
GROUP BY ROLLUP(deptno,job);

SELECT d.dname, e.job, SUM(e.sal + nvl(comm , 0))sal
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP(dname,job);

SELECT deptno,job,sum(sal + nvl(comm,0))sal
FROM emp
group by rollup(deptno,job);

SELECT deptno,job,sum(sal + NVL(comm,0))SAL
FROM emp
GROUP BY ROLLUP(deptno,job);

SELECT d.dname, e.job, sum(sal + nvl(comm,0))sal
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP(dname,job)
ORDER BY dname asc, sal DESC;

SELECT NVL(d.dname,'총합'), e.job,SUM(sal + nvl(comm,0))sal
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP (dname,job)
ORDER BY dname asc, sal DESC;


SELECT NVL(job,'총계'),decode(deptno,'소계'),sum(sal+nvl(comm,0))sal
FROM emp
GROUP BY ROLLUP (job,deptno);


SELECT DECODE(GROUPING(job),1,'총',job) job,
       NVL(DECODE(GROUPING(deptno),1,
       DECODE(GROUPING(job),1,'계'),deptno),'소계')sal,
       sum(sal+nvl(comm,0)) sal
FROM emp
GROUP BY ROLLUP(job,deptno);

SELECT empno,ename,decode(hiredate,1
FROM emp

SELECT userid,usernm,reg_Dt,nvl(reg_dt,sysdate)n_reg_Dt
FROM users
WHERE userid NOT IN('brown');

SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno = d.deptno;

SELECT c.cid,c.cnm,y.pid,y.day,y.cnt
FROM customer c, cycle y
WHERE c.cid = y.cid AND c.cnm IN ('brown','sally');

SELECT c.pid,p.pnm,sum(c.cnt)cnt
FROM cycle c, product p
WHERE c.pid = p.pid
GROUP BY c.pid,p.pnm;

SELECT NVL(b.buy_date,TO_DATE('05/01/25','YY/MM/DD')),b.buy_prod,p.prod_id,p.prod_name,b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id AND b.buy_date(+) = TO_DATE('05/01/25','YY/MM/DD');

SELECT *
FROM customer,product;

SELECT *
FROM emp
WHERE deptno IN
(SELECT deptno
FROM emp
WHERE ename IN ('SMITH') OR ename IN('WARD'));

SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM emp);

SELECT p.pid, p.pnm
FROM cycle,product
WHERE cid = 1 IN(SELECT 'X'
FROM cycle c, product p
WHERE p.pid = c.pid);

SELECT *
FROM product
WHERE EXISTS (SELECT *
              FROM cycle
              WHERE cid = 1
              AND pid = product.pid);
              
              SELECT *
              FROM CYCLE;
              
SELECT *
FROM product
WHERE NOT EXISTS (SELECT *
                  FROM cycle
                  WHERE cid = 1
                  AND pid = product.pid);

SELECT *
FROM product
WHERE EXISTS(SELECT *
             FROM cycle
             WHERE cid = 1 AND pid=product.pid);

SELECT *
FROM product
WHERE NOT EXISTS(SELECT *
FROM cycle
WHERE cid = 1 AND pid = product.pid);

SELECT empno,ename,hiredate,sal,LAG(sal) OVER (ORDER BY sal DESC, hiredate ASC)LAG_SAL
FROM emp;



SELECT empno,ename,hiredate,sal,LAG(sal) OVER (ORDER BY sal DESC, hiredate ASC)LAG_SAL
FROM emp;

ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno);


SELECT ROWNUM rn,empno,ename
FROM emp
WHERE ROWNUM <= 10;

SELECT *
FROM emp(SELECT ROWNUM rn,empno,ename
          FROM emp)
WHERE rn >= 10 and rn <=20;

SELECT rn,empno,ename
FROM
(SELECT ROWNUM rn,empno,ename
FROM emp
(SELECT empno,ename
FROM emp
ORDER BY ename asc))
WHERE rn >= 10 and rn <=20;

SELECT DEPTNO,SUM(SAL)
FROM emp
GROUP BY ROLLUP (deptno);


SELECT LEVEL lv, deptcd,LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;


SELECT LEVEL lv,deptcd,lpad(' ',(level-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LEVEL lv,deptcd,lpad(' ',(level-1)*3) || deptnm deptnm,p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LEVEL lv,deptcd,lpad(' ',(level-1)*3) || deptnm deptnm,p_deptcd
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;



SELECT LEVEL lv,deptcd,lpad(' ', (level-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;



SELECT 'SELECT * FROM' || table_name || ';' query
FROM user_tables;


SELECT ROWNUM rn, empno,ename
FROM emp
WHERE ROWNUM <= 10;

SELECT *
FROM(SELECT ROWNUM rn, empno,ename
FROM emp)
WHERE rn >= 11 and rn<= 20;

SELECT *
FROM(SELECT ROWNUM rn, empno, ename
FROM(SELECT empno,ename
FROM emp))
WHERE rn >= 11 and rn<=20;

SELECT userid,usernm,reg_dt,nvl(reg_dt,sysdate)
FROM users
WHERE userid not in ('brown');

SELECT *
FROM users;

SELECT *
FROM product
WHERE pid not IN (SELECT pid
FROM cycle
WHERE cid = 1);

SELECT *
FROM cycle
WHERE cid = 1 and pid  IN (SELECT pid
FROM cycle
WHERE cid = 2 and);


SELECT LEVEL lv,deptcd,lpad(' ', (level-1)*3) || deptnm deptnm,p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT e.empno,e.ename,e.sal,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and sal > 2500 and empno > 7600;

SELECT TO_CHAR(hiredate,'yyyymm')hire_yyyymm,count(*)
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyymm');

SELECT TO_CHAR(hiredate,'yyyy')hire_yyyy,count(*)
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyy');

SELECT COUNT(*)
FROM dept;

SELECT COUNT(*)
FROM(SELECT deptno
FROM emp
GROUP BY deptno);

SELECT empno,ename,decode(deptno, 10, 'ACCOUNTING',
                                  20, 'RESEARCH',
                                  30, 'SALES',
                                  40, 'OPERTIONS',
                                  'DDIT')DNAME
FROM emp;

SELECT empno,ename,mgr,nvl(mgr,9999)mgr_n,nvl2(mgr,mgr,9999)mgr_n_1,coalesce(mgr,9999)mgr_n_2
FROM emp;

SELECT ROWNUM rn, empno,ename
FROM emp
WHERE ROWNUM <= 10;

SELECT *
FROM(SELECT ROWNUM rn,empno,ename
FROM emp)
WHERE rn >= 11 and rn <= 20;

