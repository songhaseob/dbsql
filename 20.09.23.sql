 인덱스 생성 방법
1.자동생성
    UNIQUE, PRIMARY KEY 생성시
    해당 컬럼으로 이루어진 인덱스가 없을 경우 해당 제약조건 명으로 인덱스를 자동생성

    ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);
    empno 컬럼을 선두컬럼으로 하는 인덱스가 없을 경우 pk_emp이름으로 UNIQUE 인덱스를 자동 생성
    
    UNIQUE : 컬럼의 중복된 값이 없음을 보장하는 제약조건
    PRIMARY KEY : UNIQUE + NOT NULL
    
    DBMS입장에서는 신규 데이터가 입력되거나 기존 데이터가 수정될 때
    UNIQUE 제약에 문제가 없는지 확인 ==> 무결성을 지키기 위해
    
    빠른 속도로 중복 데이터 검증을 위해 오라클에서는 UNIQUE, PRIMARY KEY 생성시
    해당 컬럼으로 인덱스 생성을 강제한다
    
    PRIMARY KEY 제약조건 생성후 해당 인덱스 삭제 시도시 삭제가 불가
    
    FOREIGN KEY : 입력하려는 데이터가 참조하는 테이블의 컬럼에 존재하는 데이터만
                  입력되도록 제한
    emp 테이블에 brown 사원을 50번 부서에 입력을 하게되면 50번 부서가 dept테이블의
    dptno 컬럼에 존재여부를 확인하여 존재할 시에만 emp 테이블에 데이터를 입력
    
    idx1]
    CREATE TABLE DEPT_TEST2 AS
    SELECT *
    FROM dept
    WHERE 1 = 1;
    1.
    CREATE UNIQUE INDEX idx_dept_test2_u_01 ON dept_test2 (deptno);
    DROP INDEX idx_dept_test2_u_01;
    2.
    CREATE INDEX idx_dept_test2_n_02 ON dept_test2(dname);
    DROP INDEX idx_dept_test2_n_02;
    3.
    CREATE INDEX idx_dept_test2_n_03 ON dept_test2(deptno, dname);
    DROP INDEX idx_dept_test2_n_03;
    
    CREATE INDEX idx_emp_test_n_01 ON emp_test(empno); 
    DROP INDEX idx_emp_test_n_01 ;
    
    CREATE INDEX idx_emp_n_03 ON emp(detptno) AND
                 idx_dept_n_04 ON dept(deptno);
    
    SELECT *
    FROM emp;
    
    시스템에서 사용하는 쿼리가 다음과 같다고 할 때 적절한 emp테이블에 필요하다고 생각되는
    인덱스 생성 스크립트를 만들어보세요
    
    실습 idx3]
    1) empno(=) (1)
    2) ename(=)
    3) deptno(=), empno(LIKE : empno || '%') (1)
    4) deptno (=), sal(BETWEEN)
    5) deptno(=), mgr컬럼이 있을경우 테이블 액세스 불필요
       empno(=) (1)
    6)deptno, hiredate 컬럼으로 구성된 인덱스가 있을 경우 테이블 액세스 불필요
    
CREATE UNIQUE INDEX idx_emp_u_01 ON emp (empno,deptno);
CREATE INDEX idx_emp_02 ON emp (ename);
CREATE INDEX idx_emp_03 ON emp (deptno, sal, mgr, hiredate);

실습4번 과제

인덱스 사용에 있어서 중요한점
인덱스 구성컬럼이 모두 NULL이면 인덱스에 저장을 하지 않는다
즉 테이블에 접근을 해봐야 해당 행에 대한 정보를 알 수 있다
가급적이면 컬럼에 값이 NULL이 들어오지 않을 경우는 NOT NULL 제약을 적극적으로 활용
==>오라클 입장에서 실행계획을 세우는데 도움이 된다

DROP INDEX idx_dept_u_03;
CREATE UNIQUE INDEX idx_emp_u_01 ON emp (empno,deptno);
CREATE INDEX idx_emp_02 ON emp(deptno,sal);
CREATE UNIQUE INDEX idx_dept_u_03 ON dept (deptno, loc);

1. --(emp)empno(=)
2. (emp)empno(LIKE) , (emp)deptno(=)
3. (dept)deptno(=)
4. (emp)deptno(=), (emp)sal(BETWEEN)
5. (emp)deptno(=), (dept)deptno(=), (dept)loc(=)

EXPLAIN PLAN FOR
SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.deptno = :deptno
AND d.loc = :loc;


EXPLAIN PLAN FOR
SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.deptno = :deptno
AND e.empno LIKE :empno || '%';




SELECT *
FROM dept d
WHERE e.deptno = d.deptno
AND e.deptno = :deptno
AND d.loc = :loc;

SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = :empno;

SELECT *
FROM TABLE(dbms_xplan.display);


synonym : 동의어
오라클 객체에 별칭을 생성한 객체
오라클 객체를 짧은 이름으로 지어줄 수 있다

생성방법
CREATE [PUBLIC] SYNONYM 동의어_이름 FOR 오라클 객체;
PUBLIC : 공용동의어 생성시 사용하는 옵션.
         시스템 관리자 권한이 있어야 생성가능
         
emp테이블에 e라는 이름으로 synonym을 생성
CREATE SYNONYM e FOR emp;

SELECT *
FROM e;


dictionary : 오라클의 객체정보를 볼수 있는 view
dictionary의 종류는 dictionary view를 통해 조회 가능

SELECT *
FROM dictionary;

dictionary는 크게 4가지로 구분 가능
USER_ : 해당 사용자가 소유한 객체만 조회
ALL_ : 해당 사용자가 소유한 객체 + 다른 사용자로부터 권한을 부여 받은 객체
DBA_ : 시스템 관리자만 볼수 있으며 모든 사용자의 객체 조회
VS : 시스템 성능과 관련된 특수 VIEW

DBA 권한이 있는 계정에서만 조회 가능(SYSTEM, SYS)
SELECT *
FROM dba_tables;

multiple insert : 조건에 따라 여러 테이블에 데이터를 입력하는 INSERT

기존에 배운 쿼리는 하나의 테이블에 여러건의 데이터를 입력하는 쿼리
INSERT INTO emp(empno,ename)
SELECT empno, ename
FROM emp;

multiple insert 구분
1. uncoditional insert : 여러 테이블에 insert
2. conditional all insert : 조건을 만족하는 모든 테이블에 insert
3. conditional first insert : 조건을 만족하는 첫번째 테이블에 insert

1. unconditional insert : 조건과 관계없이 여러테이블에 insert

DROP TABLE emp_test;
DROP TABLE emp_test2;

CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp
WHERE 1=2; ---------거짓 1=1 참

CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp
WHERE 1=2;

INSERT ALL INTO emp_test
           INTO emp_test2
SELECT 9999, 'brown' FROM dual UNION ALL
SELECT 9999, 'sally' FROM dual;
         
SELECT *
FROM emp_test;

uncondition insert 실행시 테이블 마다 데이터를 입력할 컬럼을 조작하는 것이 가능
위에서 : INSERT INTO emp_test VALUES(.....) 테이블의 모든 컬럼에 대해 입력
         INSERT INTO emp_test (empno) VALUES (9999) 특정 컬럼을 지정하여 입력 가능
         
INSERT ALL 
    INTO emp_test (empno) VALUES(eno)
    INTO emp_test2 (empno, ename) VALUES(eno, enm)
SELECT 9999 eno, 'brown' enm FROM dual UNION ALL
SELECT 9999, 'sally' FROM dual;

conditional insert : 조건에 따라 데이터를 입력
CASE
    WHEN job = 'MANAGER THEN' sal * 1.05
    WHEN job = 'MANAGER THEN' sal * 1.2
END


INSERT ALL
    WHEN eno >= 9500 THEN 
       INTO emp_test VALUES (eno,enm)
       INTO emp_test2 VALUES (eno,enm)
    WHEN eno >=9900 THEN
        INTO emp_test2 VALUES (eno,enm)
SELECT 9500 eno, 'brown' enm FROM dual UNION ALL
SELECT 9998, 'sally' FROM dual;

SELECT *
FROM emp_test;