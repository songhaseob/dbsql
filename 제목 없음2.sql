SELECT 'SELECT * FROM ' || table_name || ';' query
FROM user_tables;

SELECT ename, hiredate
FROM emp
WHERE hiredate between TO_DATE('19820101','yyyymmdd') AND TO_DATE('19830101','YYYYMMDD');

SELECT ename,hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101','YYYYMMDD') AND hiredate <= TO_DATE('19830101','YYYYMMDD');

SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid IN ('brown','cony','sally');

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

SELECT mem_id,mem_name
FROM member
WHERE mem_name LIKE '%이%';

SELECT *
FROM emp
WHERE comm is not null;

SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('19810601','yyyymmdd');

SELECT *
FROM emp
WHERE deptno != 10 AND hiredate >= TO_DATE('19810601','yyyymmdd');

SELECT *
FROM emp
WHERE deptno NOT IN(10) AND hiredate >= TO_DATE('19810601','yyyymmdd');

SELECT *
FROM emp
WHERE deptno IN (20,30) AND hiredate >= TO_DATE('19810601','yyyymmdd');

SELECT *
FROM emp
WHERE job='SALESMAN' OR hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job='SALESMAN' OR empno LIKE '78%';

SELECT *
FROM emp
WHERE job='SALESMAN' OR empno >= 7800 AND empno <= 7899;

SELECT *
FROM emp
WHERE job='SALESMAN' OR empno LIKE '78%' AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc desc;

SELECT *
FROM emp
WHERE comm != 0
ORDER BY comm desc, empno desc;

SELECT *
FROM emp
WHERE mgr is not null
ORDER BY job asc, empno desc;

SELECT *
FROM emp
WHERE deptno NOT IN (20) AND sal > 1500
ORDER BY ename desc;

SELECT ROWNUM rn, empno,ename
FROM emp
WHERE ROWNUM <= 10;

SELECT *
FROM(SELECT ROWNUM rn,empno,ename
FROM emp)
WHERE rn > 10 AND rn < 20;

SELECT *
FROM(SELECT ROWNUM rn,empno,ename
FROM(SELECT empno,ename
FROM emp
ORDER BY ename asc))
WHERE rn > 10 and rn < 20;

SELECT TO_DATE('19/12/31','yy/mm/dd')lastday,
       TO_DATE('19/12/31','yy/mm/dd')-5 lastday_before5,
       TO_DATE(SYSDATE,'YY/MM/DD') NOW,
       TO_DATE(SYSDATE,'YY/MM/DD') -3 NOW_BEFORE3
FROM dual;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')DT_DASH,
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH-MI-SS')DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YY')
FROM dual;

SELECT empno,ename,mgr,nvl(mgr,9999)mgr_n,
                       nvl2(mgr,mgr,9999)mgr_n_1,
                       coalesce(mgr,9999)mgr_n_2
FROM emp;

SELECT userid,usernm,reg_dt,nvl(reg_dt,sysdate)
FROM users
WHERE userid NOT IN ('brown');

SELECT empno,ename, DECODE(deptno, 10, 'ACCOUNTING',
                                   20, 'RESEARCH',
                                   30, 'SALES',
                                   40, 'OPERTIONS',
                                   'DDIT')dname
FROM emp;

SELECT max(sal)max_sal,
       min(sal)min_sal,
       round(avg(sal),2)avg_sal,
       SUM(sal)sum_sal,
       COUNT(sal)count_sal,
       COUNT(mgr)count_mgr,
       COUNT(*)count_all
       
FROM emp;

SELECT deptno, max(sal)max_sal,
       min(sal)min_sal,
       round(avg(sal),2)avg_sal,
       SUM(sal)sum_sal,
       COUNT(sal)count_sal,
       COUNT(mgr)count_mgr,
       COUNT(*)count_all
       
FROM emp
GROUP BY deptno;

SELECT decode(deptno,10, 'ACCOUNTIN',
                     20, 'RESEARCH',
                     30, 'SALES')DNAME,
       max(sal)max_sal,
       min(sal)min_sal,
       round(avg(sal),2)avg_sal,
       SUM(sal)sum_sal,
       COUNT(sal)count_sal,
       COUNT(mgr)count_mgr,
       COUNT(*)count_all
       
FROM emp
GROUP BY deptno;

SELECT hiredate hire_yyyymm, count(*)
FROM emp
GROUP BY hiredate;

SELECT TO_CHAR(hiredate,'YYYY')hire_yyyy,count(*)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY') ;

SELECT COUNT(*)
FROM(SELECT deptno
FROM emp
GROUP BY deptno);

SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno = d.deptno AND e.deptno IN (10,30);

SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno = d.deptno AND sal > 2500;

SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno = d.deptno AND sal > 2500 AND empno > 7600;

SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno = d.deptno AND sal > 2500 AND empno > 7600 AND dname IN ('RESEARCH');


SELECT b.buy_date,b.buy_prod,p.prod_id,p.prod_name,b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id AND b.buy_date(+) = TO_DATE('05/01/25','yy/mm/dd');


SELECT nvl(b.buy_date,TO_DATE('05/01/25','YY/MM/DD')),b.buy_prod,p.prod_id,p.prod_name,b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id AND b.buy_date(+) = TO_DATE('05/01/25','yy/mm/dd');

SELECT nvl(b.buy_date,TO_DATE('05/01/25','YY/MM/DD')),b.buy_prod,p.prod_id,p.prod_name,NVL(b.buy_qty,0)
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id AND b.buy_date(+) = TO_DATE('05/01/25','yy/mm/dd');

SELECT COUNT(*)
FROM emp
WHERE SAL > (SELECT AVG(sal)
FROM emp);

SELECT *
FROM emp
WHERE sal >(SELECT AVG(sal)
FROM emp);

SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
FROM emp
WHERE ename IN ('SMITH') OR ename IN('WARD'));

SELECT *
FROM product
WHERE EXISTS(SELECT *
FROM cycle
WHERE cid = 1 and product.pid = pid);

SELECT *
FROM product
WHERE NOT EXISTS(SELECT *
FROM cycle
WHERE cid = 1 and product.pid = pid);

SELECT pid,pnm
FROM product
WHERE pid  not in(SELECT pid
FROM cycle
WHERE cid = 1);

SELECT *
FROM cycle
WHERE cid =1
AND pid IN(SELECT pid
FROM cycle
WHERE cid = 2);

SELECT deptno,sum(sal)
FROM emp
GROUP BY ROLLUP (deptno);

SELECT NVL(job,'총계'),deptno,sum(sal+ nvl(comm,0))
FROM emp
GROUP BY ROLLUP (job,deptno);

SELECT DECODE(deptno,10,'ACCOUNTING',
                     20,'RESEARCH',
                     30,'SALES',
                     '총합')dname,job,sum(sal+nvl(comm,0))sal
FROM emp
GROUP BY ROLLUP(deptno,job);

SELECT empno,ename,sal,deptno,ROUND(avg(sal) OVER (PARTITION BY deptno),2) avg_sal
FROM emp;

SELECT empno,ename,deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

SELECT empno,ename,sal,deptno,max(sal) OVER (PARTITION BY deptno)max_sal
FROM emp;

SELECT empno,ename,hiredate,sal, LAG(sal) OVER (ORDER BY sal desc, hiredate asc)
FROM emp;

SELECT empno,ename,hiredate,job,sal,LAG(sal) OVER (PARTITION BY job ORDER BY sal desc)
FROM emp;

SELECT empno,ename,sal, LAG(sal+NVL(COMM,0)) OVER (ORDER BY sal asc)
FROM emp;
