REPORT GOUP FUNCTION
GROUP BY의 확장 : SUBGROUP을 자동으로 생성하여 하나의 결과로 합쳐준다
1.ROLLUP(col1, col2...)
    -기술된 컬럼을 오른쪽에서 부터 지워 나가며 서브 그룹을 생성
    
2. GROUPING SETS ( (col1, col2), col3)
, 단위로 기술된 서브 그룹을 생성

3. CUBE(col1, col2....)
 . 컬럼의 순서는 지켜되, 가능한 모든 조합을 생성한다

GROUP BY CUBE (job,detno) ==> 4개
      job     deptno
       o        o     ==> GROUP BY job, deptno
       o        x     ==> GROUP BY job
       x        o     ==> GROUP BY deptno (ROLLUP에는 없던 서브 그룹)
       x        x     ==> GROUP BY 전체
       
GROUP BY ROLLUP(job, deptno) ==> 3개

SELECT job, deptno, SUM(sal + NVL(comm, 0 )) sal
FROM emp
GROUP BY CUBE(job, deptno);

CUBE의 경우 가능한 모든 조합으로 서브 그룹을 생성하기 때문에
2의 기술한 컬럼개수 승 만큼의 서브 그룹이 생성된다
CUBE(col1, col2) : 4
CUBE(col1, col2, col3) : 8
CUBE(col1, col2, col3, col4) : 16

REPORT GROUP FUNCTION 조합
GROUP BY job, ROLLUP(deptno), CUBE(mgr)  -------그룹바이 잡은 항상 default
                deptno            mgr
                 전체             전체

            job,deptno,mgr
              job,deptno
                job,mgr
                job, 전체

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);


상호 연관 서브 쿼리를 이용한 업데이트
1. EMP_TEST 테이블 삭제

DROP TABLE emp_test;

2. EMP테이블을 사용하여 EMP_TEST 테이블 생성(모든 컬럼, 모든 데이터)

CREATE TABLE emp_test AS
SELECT *
FROM emp;

3. EMP_TEST테이블에는 DNAME 컬럼을 추가 VARCHAR2(14)
ALTER TABLE emp_test ADD (dname VARCHAR2(14));

4. 상호 연관 서브쿼리를 이용하여 EMP_TEST테이블의 DNAME 컬럼을 DEPT을 이용하여 UPDATE

SELECT *
FROM emp_test;
UPDATE emp_test SET dname = (SELECT dname FROM dept WHERE deptno = emp_test.deptno)

SUB1]
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD ( empcnt NUMBER(2));

SELECT *
FROM dept_test;


SELECT COUNT(*)
FROM dept_test;
UPDATE dept_test SET empcnt = (SELECT COUNT(deptno) FROM emp WHERE deptno = dept_test.deptno)

SELECT *
FROM emp_test;

COMMIT;

SUB_A2]
INSERT INTO dept_test (deptno, dname, loc) VALUES (99, 'it1', 'daejeon');
INSERT INTO dept_test (deptno, dname, loc) VALUES (98, 'it2', 'daejeon');

SELECT *
FROM emp_test;

SELECT *
FROM dept_test;

부서에 속한 직원이 없는 부서를 삭제하는 쿼리를 작성하세요
DELETE emp_test

ALTER TABLE dept_test DROP COLUMN empcnt;

SELECT *
FROM dept_test;

DELETE dept_test
WHERE 0 = (SELECT COUNT(*)
         FROM emp
         WHERE deptno = dept_test.deptno);
         
SUB_a3] 과제






달력 만들기 : 행을 열로 만들기 - 레포트 쿼리에서 자주 사용하는 형태
주어진것 : 년월 (수업시간에는 '202009' 문자열을 사용)

'202009' ==> 30
'202008' ==> 31

SELECT TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD) 
FROM dual;


SELECT TO_DATE('202002','YYYYMM') + LEVEL-1
FROM dual;

SELECT SYSDATE + LEVEL, LEVEL
FROM dual 
CONNECT BY LEVEL TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD);



SELECT DECODE (d, 1, iw +1, iw), MIN(DECODE(d, 1, day)) sun, 
        MIN(DECODE(d, 2, day)) mon, 
        MIN(DECODE(d, 3, day)) tue,
        MIN(DECODE(d, 4, day)) wed, 
        MIN(DECODE(d, 5, day)) thu, 
        MIN(DECODE(d, 6, day)) fri, 
        MIN(DECODE(d, 7, day)) sat
FROM (SELECT TO_DATE(:yyyymm, 'YYYYMM') + LEVEL-1 day,
             TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + LEVEL-1 , 'D') d,
             TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + LEVEL-1 , 'iw') iw
FROM dual 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')),'DD') )
GROUP BY DECODE (d, 1, iw +1, iw)
ORDER BY DECODE (d, 1, iw +1, iw);

SELECT TO_CHAR(TO_DATE('20191229','yyyymmdd'), 'iw'),
       TO_CHAR(TO_DATE('20191230','yyyymmdd'), 'iw'),
       TO_CHAR(TO_DATE('20191231','yyyymmdd'), 'iw')
FROM dual;

SELECT *
FROM sales;


SELECT  NVL(MIN(DECODE(mm,'01',sales)),0) jan,  
        NVL(MIN(DECODE(mm,'02',sales)),0) feb,  
        NVL(MIN(DECODE(mm,'03',sales)),0) mar, 
        NVL(MIN(DECODE(mm,'04',sales)),0) apr, 
        NVL(MIN(DECODE(mm,'05',sales)),0) may, 
        NVL(MIN(DECODE(mm,'06',sales)),0) jun
FROM
(SELECT TO_CHAR(dt, 'mm') mm, SUM(sales) sales
FROM sales
GROUP BY TO_CHAR(dt, 'mm'));

SELECT deptcd,LPAD(' ', (LEVEL-1)*3) || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;








