select ename as "사원명", sal*12+nvl(comm,0) as "연봉" from emp;
select * from emp;

select ename, nvl(comm,0) from emp;
select ename, nvl2(comm,comm,0) from emp;


select ename || '의 직급은' || job || '입니다.' as 직급
from emp;

select ename, sal*12 || '만원' as 연금 from emp;


--중복제거
select * from emp;
select DISTINCT deptno from emp; 
select distinct job from emp;



select * from emp where sal >= 500; 

select * from emp where deptno >= 20;

select * from emp where ename = '안성기';  --문자열은 작은따음표 필수

select * from emp where hiredate < to_date('2005/01/01','YYYY/MM/DD');

select * from emp where deptno = 10 and job ='과장';
select * from emp where deptno = 30 and job ='과장';
select * from emp where deptno = 10 or job ='과장';

--not연산자의 3가지 방법 // <> 을 추천!
select * from emp where not deptno = 10;
select * from emp where deptno != 10;
select * from emp where deptno <> 10;

--'between and' 연산자로 and를 함께 외울것.
select * from emp where sal >= 400 and sal <= 500; --sal이 400이상 500이하인 값
select * from emp where sal between 400 and 500; --위와 동일
select * from emp where sal between 500 and 600;
select * from emp where  sal not between 400 and 600;
select * from emp where  not sal between 400 and 600;

select * from emp where hiredate between 
to_date('2003/01/01','YYYY/MM/DD') and to_date('2003/12/31','YYYY/MM/DD');

--in연산자
select * from emp;
select * from emp where comm = 80 or comm = 100 or comm = 200;
select * from emp where comm in(80,100,200);
select * from emp where comm <> 80 and comm <> 100 and comm <> 200;
select * from emp where comm not in(80,100,200);

--like연산자
select * from emp where ename like '이%';
select * from emp where ename like '이__'; --특정자리 검색
select * from emp where ename like '김%';
select * from emp where ename like '%기';
select * from emp where ename like '%이%'; --포함 검색 //주로 사용됨
select * from emp where ename like '_성%'; --성(첫번째 자리문자)은 검색제외
select * from emp where ename like '__성';

--null 무한의 공간, 값이 없는 상태
select * from emp;
select * from emp where comm is null;
select * from emp where comm is not null; --실습하다보면 많이 쓰임. 미정의 값을 숨기기 위해
select * from emp where not comm is null;



--order by 절
 select * from emp;
 select * from emp order by ename asc;
 select * from emp order by sal;
 select * from emp order by sal asc;
 select * from emp order by sal desc;
 select * from emp order by hiredate asc;
 select * from emp order by hiredate desc, ename asc;
 
 
 
 /*[3장] 오라클 주요함수
 Dual테이블*/--가상테이블..?
 select 24*60 from dual;
 select sysdate from dual;
 select 34.5678,floor(34.5678),abs(-34.5678), round(34.5678,2),trunc(34.5678,2) from dual;
 select mod(11,4) from dual;--나머지값
 
 --문자길이
 select length('oracle'), length('오라클') from dual;
 select lengthb('오라클') from dual;--한글자 3바이트
 
 --문자추출
 select substr('welcome to oracle',4,3) from dual;
 select substr('welcome to oracle',1,7) from dual;
 select substr('오라클',1,2) from dual;
 select substrb('오라클',1,6) from dual;
 
 select ename, sal, hiredate from emp;
 
 select deptno 부서번호, dname as 부서명 from dept;
 
 select distinct job from emp;
 
 select empno, ename, sal from emp where sal <= 300;
 
 select empno, ename, sal from emp where ename = '오지호';
 
 select empno, ename, sal from emp where sal=250 or sal = 300 or sal = 500;
 select empno, ename, sal from emp where sal in(250, 300, 500);
 
 select empno, ename, sal from emp where sal <> 250 and sal <> 300 and sal <> 500;
 select empno, ename, sal from emp where sal not in(250, 300, 500);
 
 select empno, ename from emp where ename like '김%' or ename like '%기%';
 
 select * from emp where mgr is null;
 
 select empno, ename, job, to_char(hiredate, 'YYYY/MM/DD') from emp order by hiredate desc;
 
 select deptno, empno, ename, job, to_char(hiredate, 'YYYY/MM/DD') from emp order by deptno asc, hiredate asc;

select empno, ename, sal from emp where ename = '오지호';

select empno, ename, sal from emp where sal = 250 or sal = 300 or sal = 500;
select empno, ename, sal from emp where sal in(250,300,500);

select empno, ename, sal from emp where sal != 250 and sal != 300 and sal != 500;
select empno, ename, sal from emp where sal not in(250,300,500);

select deptno, empno, ename, job, to_char(hiredate,'YYYY/MM/DD') from emp order by deptno , hiredate;
select sal*12 + nvl(comm,0) as 연봉 from emp;

select * from emp;
select to_char(hiredate,'YYYY/MM/DD') from emp;
select * from emp where substr(hiredate,4,2) = 09;

select empno, ename, job, sal,
    decode(job, '부장', sal+sal*0.05, 
                '과장', sal+sal*0.1,
                '대리', sal+sal*0.15,
                '사원', sal+sal*0.2,
                '사장', sal,
                '차장', sal) as upsal
from emp;

select empno, ename, job, sal, 
    case when job='부장' then sal+sal*0.05
    else sal
    end as upsal
    from emp;

select hiredate, to_char(hiredate,'YY/MON/DD DY') from emp;


select round(sysdate-hiredate,0) 근무일수 from emp;

select max(sal) Maximum, min(sal) Minimum, sum(sal) sum, trunc(avg(sal)) average from emp; 

select job, max(sal) Maximum, min(sal) Minimum, sum(sal) sum, trunc(avg(sal)) average from emp group by job;

select job, count(*) from emp group by job;

select * from emp;

select count(mgr) from emp where job = '과장';\

select decode(deptno, 10, '영업부',
                      20, '인사부', 
                      30, '경리부') as dname, 
       decode(deptno, 10, '용인',
                      20, '인천', 
                      30, '서울') as location, count(*) as "number of people", round(avg(sal)) as sal
from emp group by deptno order by deptno;

