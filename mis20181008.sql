--substr  문자를 잘라 추출(대상, 시작, 개수)
select substr('welcome to oracle', 4,3) from dual;
select substr('welcome to oracle', 9,2) from dual;

select substr('1234 6789 11',11,2) from dual;
select * from dual;

--instr 문자의 위치 추출(대상, 찾을 글자, 시작, 몇번째발견)
select instr('welcome to oracle','o',1,3) from dual;

--특정 기호로 채우기
select lpad('welcome',10,'#') from dual;
select rpad('welcome',20,'#') from dual;

select lpad('abc',5,'1') from dual;
select rpad('12345',6,'*') from dual;


--기본 날짜 포맷확인하기
select sysdate from dual;

--형변환함수(TO_CHAR, TO_DATE, TO_NUMBER)
select sysdate, to_char(sysdate,'yyyy-mm-dd') from dual;
select sysdate, to_char(sysdate,'yyyy-mm-dd(day)') from dual;
select sysdate, to_char(sysdate,'yyyy-mm-dd-day') from dual;
select sysdate, to_char(sysdate,'yyyy-mon-dd-day') from dual;
select hiredate, to_char (hiredate, 'YYYY/MM/DD day') from emp;
select sysdate, to_char(sysdate, 'yyyy-mm-dd, pm hh:mi:ss') from dual;


select to_char(1230000), to_char(1230000,'L999,999,999') from dual;

select hiredate from emp;

--to_date(변환할 값, 포맷) //where에 검색할 때 많이 사용됨
select ename, hiredate from emp where hiredate=to_date('20070301','yyyy-mm-dd');

--근무일
select trunc(sysdate-to_date('2018-01-01','yyyy-mm-dd')) from dual;

select to_number('20,000','99,999') - to_number('10,000','99,999') from dual;

select * from emp;
--근무달수 구하기
select ename, to_char(sysdate,'yyyy/mm/dd') 오늘, to_char(hiredate, 'yyyy/mm/dd') 입사일, 
       trunc(months_between (sysdate, hiredate)) 근무개월 from emp;
        
        
--개월 수 더하기
select ename, to_char(hiredate, 'yyyy/mm/dd') 입사일, 
       to_char(add_months(hiredate,6),'yyyy/mm/dd') "입사 6개월 후" ,
       to_char(last_day(hiredate),'YYYY/mm/dd') "입사달의 마지막날"
from emp;

select ename, to_char(hiredate, 'yyyy/mm/dd') as 입사일,
        to_char(add_months(hiredate,7),'yyyy/mm/dd, dy') as test
from emp;

select * from emp;

--null을 다른 값으로 변환하는 nvl(컬럼, 대치값) //자료형은 일치하여야함
--nvl2(컬럼, null이 아닌경우 대치값, null인 경우 대치값)
select ename, sal, comm,
       nvl2(comm, sal*10+comm, sal*10) 연봉
from emp
order by 연봉 desc;

select * from emp;

--decoode 여러가지 선택(기준, 조건1,결과1,...) <- case문과 같음, 규칙적인 조건이 있을 경우
select ename, deptno,
       decode (deptno, 10, '경리부',
                       20, '인사과',
                       30, '영업부',
                       40, '전산부') as dname
from emp;

select ename, job, decode(job, '사장','선물1', 
                               '과장','선물2',
                               '부장','선물3',
                               '차장','선물4',
                               '대리','선물5',
                               '사원','선물6') as gift 
from emp;
                               


--case when 조건1 then 결과1 ...  <- ifelse문과 같음, 특정조건이 있을 경우
select ename, deptno,
    case when deptno = 10 then '경리부'
         when deptno = 20 then '인사과'
         when deptno = 30 then '영업부'
         when deptno = 40 then '전산부'
    end as dname
from emp;

select * from emp;

select ename, deptno,
    case when deptno = 10 then '경리부'
         when deptno = 20 then '인사과'
end from emp;


select * from emp
where to_char(hiredate,'mm')='09';
select * from emp
where to_char(hiredate,'yyyy')='2003';


--그룹함수에서는 null을 자동으로 처리해준다

--count
select count(*) from emp;
select count(comm) from emp; --null은 제외하고 개수를 센다

--grounp by
select deptno 부서번호, sum(sal) "월급 합계", max(sal),min(sal), trunc(avg(sal)) 
from emp group by deptno;



select * from emp;

--Quiz p156~8
--1. 사원번호가 홀수 인 사람들을 검색해 보시오
select * from emp
where mod(empno,2)=1;

--2. 사원들의 입사일에 대해서 년도, 월, 일을 개별적으로 출력하시오.
select hiredate, to_char(hiredate,'YYYY') 년도,
                 to_char(hiredate,'mm') 월,
                 to_char(hiredate,'dd') 일
from emp;

--3. 상급자가 없는 사원만 출력하되, 상급자 값을 CEO로 출력 하시오.
select empno, ename, nvl(to_char(mgr,'9999'),'C E O') as "직속 상관"
from emp
where mgr is null;














      


