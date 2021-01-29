SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SELECT prod_id id, prod_name name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;

SELECT userid || usernm AS id_name, CONCAT(userid, usernm) AS concot_id_name
FROM users;

SELECT '아이디 : ' || userid,
       '아이디 : ' || userid "id userId"
FROM users;

SELECT 'SELECT * FROM' || table_name || ';' query
FROM user_tables;

SELECT userid,usernm, alias, reg_dt
FROM users
WHERE userid = 'brown';

DESC emp;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','YYYYMMDD') AND TO_DATE('19830101','YYYYMMDD');

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101','YYYYMMDD') AND hiredate <= TO_DATE('19830101','YYYYMMDD');

SELECT userid 아이디, usernm 이름, alias 별명 
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

SELECT *
FROM emp
WHERE mgr IS NULL;

SELECT *
FROM emp
WHERE mgr = '';

SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE job='SALESMAN' AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE deptno != 10 AND hiredate >= TO_DATE('19810601','yyyymmdd');

SELECT *
FROM emp
WHERE deptno NOT IN(10) AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE deptno IN(20,30) AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job='SALESMAN' OR  hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job='SALESMAN' OR empno LIKE '78%';

SELECT *
FROM emp
WHERE job='SALESMAN' OR empno >= 7800 AND empno <= 7899;

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%' AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

SELECT *
FROM emp
WHERE comm != 0      --------또풀기
ORDER BY comm DESC, empno DESC;

SELECT *
FROM emp
WHERE mgr IS NOT NULL  ----------------------또 풀기
ORDER BY job, empno DESC;

SELECT *
FROM emp
WHERE deptno IN (10,30) AND sal > 1500 ------------ 문제좀 제대로 또박또박 읽자 ㅅㅂ 
ORDER BY ename DESC;

SELECT ROWNUM rn, empno, ename
FROM emp          -------개념 제대로 이해하자! 또풀기
WHERE ROWNUM <= 10;

SELECT *
FROM(SELECT ROWNUM rn, empno, ename
FROM emp)                            ------또풀기 이해 완료
WHERE rn >= 11 AND rn <= 20;

SELECT *
FROM(SELECT ROWNUM rn,empno,ename
FROM
(SELECT empno,ename
FROM emp
ORDER BY ename ASC))
WHERE rn >= 10 AND rn <= 20;




SELECT *
FROM
(SELECT ROWNUM rn, empno, ename
FROM
    (SELECT empno, ename
    FROM emp         --------이해는됨 근데 계속풀어봐라
    ORDER BY ename ASC))
WHERE rn > =11 AND rn <= 20;

SELECT TO_DATE('20191231','yyyymmdd')LASTDAY, TO_DATE('20191231','YYYYMMDD')-5 LASTDAY_BEFORES,
       SYSDATE NOW, SYSDATE -3 NOW_BEFORE3          --또풀기
FROM dual;


SELECT TO_CHAR(SYSDATE,'yyyy-mm-dd') dt_dash , 
       TO_CHAR(SYSDATE, 'yyyy-mm-dd hh-mi-ss') dt_dash_wiht_time, 
       TO_CHAR(SYSDATE, 'dd-mm-yyyy') dt_dd_mm_yyyy
FROM dual;

SELECT 
       NVL(MGR, 9999) MRG_N,
       NVL2(MGR,MGR, 9999) MGR_N_1,
       coalesce(MGR, 9999) MGR_N_2
FROM emp;

SELECT userid,usernm,reg_dt,NVL(reg_dt,SYSDATE) n_reg_dt
FROM users
WHERE userid NOT IN('brown');

SELECT empno,ename,
        DECODE(deptno,
               10, 'ACCOUNTING',
               20, 'RESEARCH',
               30, 'SALES',       -----------또풀기
               40, 'OPERATIONS',
               'DDIT')dname
FROM emp;

SELECT MAX(sal),
       MIN(sal),
       ROUND(AVG(sal),2),
       SUM(sal),
       COUNT(sal) COUNT_SAL,
       COUNT(mgr) COUNT_MGR,
       COUNT(*) COUNT_ALL
       
FROM emp;

SELECT deptno,
       MAX(sal) MAX_SAL,
       MIN(sal) MIN_SAL,
       ROUND(AVG(sal), 2),
       SUM(sal)SUM_SAL,
       COUNT(sal) COUNT_SAL,
       COUNT(mgr)COUNT_MGR,
       COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno;

SELECT TO_CHAR(hiredate,'yyyymm') HIRE_YYYYMM, COUNT(*)CNT
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyymm');

SELECT TO_CHAR(hiredate,'yyyy') HIER_YYYY, COUNT(*) CNT
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyy');

SELECT COUNT(deptno) cnt
FROM dept;

SELECT COUNT(*)
FROM
(SELECT deptno
FROM emp
GROUP BY deptno);

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON( e.deptno = d.deptno)-----------완벽히 이해 
ORDER BY deptno;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON( e.deptno = d.deptno)-----------완벽히 이해
WHERE d.deptno IN(10,30);

SELECT e.empno, e.ename,e.sal, e.deptno,d.dname  -----------완벽히 이해
FROM emp e JOIN dept d ON (e.deptno = d.deptno)
WHERE sal > 2500;

SELECT e.empno, e.ename,e.sal, e.deptno,d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno)-----------완벽히 이해
WHERE e.sal > 2500 AND e.empno > 7600;

SELECT e.empno, e.ename,e.sal, e.deptno,d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno)-----------완벽히 이해
WHERE e.sal > 2500 AND e.empno > 7600 AND d.dname IN ('RESEARCH');

SELECT c.cid, c.cnm, y.pid, y.day, y.cnt
FROM  customer c JOIN cycle y ON (c.cid = y.cid)
WHERE c.cnm IN('brown', 'sally');

SELECT c.cid, c.cnm, y.pid, p.pnm, y.cnt
FROM customer c JOIN cycle y ON(c.cid = y.cid)
                JOIN product p ON (y.pid = p.pid)
WHERE c.cnm IN('brown', 'sally');

SELECT c.cid, c.cnm, y.pid, p.pnm, y.cnt
FROM customer c JOIN cycle y ON(c.cid = y.cid)
                JOIN product p ON (y.pid = p.pid)
WHERE c.cnm IN('brown', 'sally');

SELECT *
FROM emp
WHERE sal >= (SELECT AVG(sal)
FROM emp);

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE DEPTNO IN (20,30));
