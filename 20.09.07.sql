git 특징중 : 분산저장소

working area -- staging area, INDEX -- local 저장소 -- remote 저장소
(작업공간,폴더)           git             -git           github.com
          
              add                  commit            push
                                      pull

SELECT
FROM 테이블명 || 인라인뷰 || 뷰 [별칭]
WHERE 
ORDER BY;

리터럴표기법 = '문자'

table 에는 정렬의 개념이 없다

SELSECT *
FROM emp

OREDER BY
오늘 실행 했을 때랑 내일 했을 때랑 조회 순서가 달라질 수 있음

페이징 처리
1. 정렬 기준 (ex 게시판 :게시글 작성 순서 - 최신글이 가장위로 올라오도록)
2. page당 사이즈 
===============================================================================================================================

ROWNUM : 1부터 읽어야 된다
        SELECT 절이 ORDER BY 절보다 먼저 실행된다
        ==> ROWNUM을 이용하여 순서를 부여 하려면 정렬 부터 해야한다
            ==> 인라인뷰 {ORDER BY - ROWNUM을 분리}
            
row_1]             
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM <= 10;

row_2]    11~20

SELECT *
FROM (SELECT ROWNUM rn, empno, ename
FROM  emp )
WHERE rn >= 11 AND rn <= 20;

row_3] emp 테이블에서 사원이름으로 오름차순 정렬하고 11~14번에 해당하는 순번,사원번호,이름 출력
    1. 정렬기준 : ORDER BY eanme ASC;
    2. 페이징 사이즈 : 11~ 14(페이지당)

SELECT *
FROM
(SELECT ROWNUM rn, empno, ename
FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename ASC))
WHERE rn > 10 AND rn <= 20;


SELECT dummy
FROM dual;

ORACLE 함수 분류
**** 1. SINGLE ROW FUNCTION : 단일 행을 작업의 기준, 결과도 한건 변환
2. MULTI ROW ROW FUNCTION : 여러 행을 작업의 기준, 하나의 행을 결과로 변환

dual 테이블
    1. sys 계정에 존재하는 누구나 사용할수 있는 테이블
    2. 테이블에는 하나의 컬럼, dummy 존재, 값은 x
    3. 하나의 행만 존재 
        ***** SINGLE ROW
SELECT empno, eanme, LENGTH(ename), LENGTH('hello')
FROM emp;

SELECT LENGTH('hello')
FROM dual;

sql 칠거지악
1. 좌변을 가공하지말아라 (테이블 컬럼에 함수를 사용하지 말것
    - 함수 실행 횟수
    - 인덱스 사용관련(추후에)
SELECT ename, LOWER(ename)
FROM emp
WHERE LOWER(ename) = 'smith';

SELECT ename, LOWER(ename)
FROM emp
WHERE ename = UPPER('smith'); // 이것을 사용!!


문자열 관련함수 : 
SELECT CONCAT('Hello', ', World') concat,
    SUBSTR('Hello, World', 1, 5) substr,  
    SUBSTR('Hello, World', 5) substr2,    
    LENGTH('Hello, World') length,        
    INSTR('Hello, World', 'W', 'o') instr,
    INSTR('Hello, World', 'W', 'o', 5 +1 ) instr2,
    INSTR('Hello, World', 'o', INSTR('Hello, World', 'o') + 1) instr3,
    LAPD('Hello, World', 15, '*') lpad,
    LAPD('Hello, World', 15) lpad2,
    RAPD('Hello, World', 15, '*') rpad,
    REPLACE('Hello, World', 'Hello', 'Hell') replace,
    TRIM('Hello, World') trim,
    TRIM('         Hello, World      ') trim2,
    TRIM(  'H' FROM 'Hello, World') trim3

FROM dual;

숫자 관련 함수

ROUND : 반올림 함수
TRUNC : 버림함수
    ==> 몇번째 자리에서 반올림, 버림을 할지?
    두번째 자리수가 0, 양수 : ROUND(숫자, 반올림 결과 자리수)
    두번째 인자가 음수 : ROUND(숫자, 반올림 해야되는 위치)
MOD : 나머지를 구하는 함수

SELECT ROUND(105.54, 1) round,
       ROUND(105.55, 1) round2,
       ROUND(105.54, 0) round3,
       ROUND(105.55, -1) round4
FROM dual;

SELECT TRUNC(105.54, 1) trunc,
       TRUNC(105.55, 1) trunc,
       TRUNC(105.54, 0) trunc,
       TRUNC(105.55, -1) trunc
FROM dual;

mod 나머지 구하는 함수
피제수 - 나눔을 당하는 수, 제수 - 나누는수
a / b = c
a : 피제수
b : 제수

10을 3으로 나눴을때 몫을 구하기
SELECT TRUNC(10/3, 0)
FROM dual;

날짜 관련함수
문자열==날짜 타입으로 TO_DATE
SYSDATE : 오라클 서버의 현재 날짜, 시간을 돌려주는 특수함수
          함수의 인자가 없다
          (java
          public void test()[
          }
          test();
          
          SQL
          length('Hello, World')
          SYSDATE ;
    
SELECT SYSDATE
FROM dual;

날짜 타입 +- 정수(일자) : 날짜에서 정수만큼 더한(뺀) 날짜
하루 = 24
1일 = 24h
1/24일 = 1h
1/24일/60 = 1m
1/24일60/60 = 1s

emp hiredate + 5, -5

SELECT SYSDATE, SYSDATE +5, SYSDATE -5,
       SYSDATE + 1/24, SYSDATE + 1/24/60
FROM dual;

sql : "Hello,World', 5
java : "HELLO, World", 5
날짜를 어떻게 표현할까?
java : java.util.Date
sql : ns1 포맷에 설정된 문자열 형식을 따르거나
    ==> 툴 때문일수도 있음 예측하기 힘듬.
    TO_DATE 함수를 이용하여 명확하게 명시
    TO_DATE ('날짜 문자열', '날짜 문자열 형식')
    


SELECT TO_DATE('20191231','YYYYMMDD') LASTDAY,
       TO_DATE('20191231','YYYYMMDD') -5 LASTDAY_BEFORES,
       SYSDATE NOW,
       SYSDATE -3 NOW_BEFORE3
FROM dual;













