--지난시간 퀴즈 답
select * from emp
where mod(empno, 2) = 1;

select hiredate, substr(hiredate,1,2) 년도,
                 substr(hiredate,4,2) 월,
                 substr(hiredate,7,2) 일
                 from emp;
                 
select hiredate, to_char(hiredate,'yyyy') 년도, 
                 to_char(hiredate,'mm') 월,
                 to_char(hiredate,'dd') 일
                 from emp;
                 
select empno, ename, nvl(to_char(mgr, '9999'), 'c e o') as 직속상관
        from emp
        where mgr is null;
        
select * from emp;

select * from emp where comm is null;

--그룹함수
select deptno, count(*) "부서별 사원수", count(comm) "커미션 받는 사원수"
from emp
group by deptno
order by deptno;



select job, sum(sal) as "월급합계"
from emp
group by job;


select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 500;



select job, count(*), sum(sal)
from emp
where job not like '%사원%'
group by job
having sum(sal) >= 1000
order by sum(sal) desc; -- 기본은 asc(오름차순)

select ename, sal, to_char(hiredate,'yyyy-mm-dd') as 입사일 from emp;


--테이블구조를 만드는 create table
create table emp01(
    empno number(4),
    ename varchar2(14),
    sal number(7,3)
);

--만든 테이블확인하기
desc emp01;

--컬럼추가하기
alter table emp01
add(birth date);

--컬럼 변경하기
alter table emp01
modify ename varchar2(30);

--컬럼 제거하기
alter table emp01
drop column ename;

desc emp01;


--테이블명 수정
rename emp01 to emp02;
rename emp02 to emp01;
desc emp02;

--테이블 제거, 지울때는 관계를 먼저 살펴보고 자식 -> 부모 순으로 지워야 한다.
drop table emp02;
desc emp02;

--중간고사 10문제 안팍, 30점배점

--1.table 3 생성쿼리 + desc table
--쿼리 + desc___ + 결과
--2.table 컬럼추가 Query + desc table 결과
--3.rename 쿼리 + desc table 결과
--4. ctas사용쿼리 + desc table 결과
--5. drop table 쿼리


--테이블생성
create table  customer
(
    CTMR_NO         varchar2(50) not null,
    CTMR_LICE_NO    varchar2(20) null,
    CTMR_NAME       varchar2(30) null,
    CTMR_ADDRESS    varchar2(100) null,
    CTMR_TEL        varchar2(15) null,
    CTMR_HP         varchar2(15) null,
    CTMR_MGMT_NAME  varchar2(20) null,
    CTMR_ETC        varchar2(100) null
);
desc customer;

create table employee
(
    EMP_NO          VARCHAR2(50) NOT NULL,
    EMP_NAME        VARCHAR2(20) NULL,
    EMP_POSI        VARCHAR2(20) NULL,
    EMP_DEPT        VARCHAR2(20) NULL,
    EMP_HP          VARCHAR2(15) NULL,
    EMP_EMAIL       VARCHAR2(30) NULL,
    EMP_PW          VARCHAR2(20) NULL,
    EMP_AUTH        CHAR(18) NULL
);
DESC EMPLOYEE;

CREATE TABLE CUSTOMER_EMPLOYEE
(
    ORDR_NO         VARCHAR2(50) NOT NULL,
    CTMR_NO         VARCHAR2(50) NOT NULL,
    EMP_NO          VARCHAR2(50) NOT NULL
);
DESC CUSTOMER_EMPLOYEE;

create table test_s(
    one_no       varchar2(10) not null,
    twotwo       varchar2(40) null);
    
desc test_s;

alter table test_s add(tree varchar2(20) null);
desc test_s;

rename test_s to testtest;
desc testtest;

create table temp_test as select * from testtest;
desc temp_test;

drop table temp_test;
desc temp_tesp;

--테이블 수정
ALTER TABLE CUSTOMER_EMPLOYEE ADD(ODR_DATE DATE);
DESC CUSTOMER_EMPLOYEE;

--테이블명 변경
RENAME CUSTOMER_EMPLOYEE TO PDCT_ORDER;
DESC PDCT_ORDER;

--테이블 삭제
CREATE TABLE TEMP_EMP AS SELECT * FROM EMPLOYEE;
DESC TEMP_EMP;
DROP TABLE TEMP_EMP;
