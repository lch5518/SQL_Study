--7번문제 : 서브 쿼리를 사용하여 테이블emp06에 emp테이블의 모든 데이터를 추가합니다.
drop table emp06;
desc emp06;

create table emp06
as
select * from emp;
select * from emp06;

--13번문제 : '이문세'의 급여와 동일하거나 더 많이 받는 사원명과 급여를 출력하는 SQL문을 완성하시오
select * from emp;
select ename, sal from emp
where  sal >= (select sal from emp 
              where ename = '이문세' ) 
              and not ename = '이문세';--혹은 and ename <> '이문세'
              
select sal from emp 
where ename = '이문세';

--14번문제 : '인천'에서 근무하는 사원의 이름, 부서번호를 출력하는 SQL문을 완성하시오
select ename, deptno from emp
where deptno = (select deptno from dept where loc = '인천');

--15번문제 : 직속상관이 감우성인 사원의 이름과 급여를 출력하는 SQL문을 완성하시오
select * from emp;
--내가 적은  답
select ename, sal, mgr from emp
where ename in (select ename from emp where mgr = 
               (select empno from emp where ename = '감우성'))
               and not mgr = 1003;
--답              
select ename, sal, mgr from emp
where mgr = (select empno from emp where ename = '감우성');
            
select * from emp where ename = '이병헌'; --두명이었네
select ename, empno, mgr from emp where ename = '감우성'; --감우성 번호 검색

select ename from emp where mgr = (select mgr from emp where ename = '감우성');

--16번문제 : 부서별로 가장 급여를 많이 받는 사원의 정보(사원 번호, 사원이름, 급여, 부서번호)를 출력하는 sql문을 완성하시오
select empno, ename, sal, deptno from emp e
where sal = (select max(sal) from emp where deptno = e.deptno)
order by deptno, empno asc;

select empno, ename, sal, empno from emp e
where sal = (select max(sal) from emp where e.deptno = deptno);


--가상테이블 뷰

--가상테이블만들기
create table emp_copy as 
select * from emp;

select * from emp_copy;

--뷰는 왜 만들까? 개발자가 쿼리를 좀더 간단하게 조회하기 위해(단축키..?), 물리적으로 저장되지 않음
select empno, ename, deptno from emp_copy where deptno = 30; --30번부서의 사원번호, 이름, 부서번호를 자주 조회한다고 할 때

--뷰로 정의
create view emp_view30
as
select empno, ename, deptno from emp_copy where deptno = 30;

--뷰로 조회해보자
select * from emp_view30; 

--뷰 확인
select view_name, text from user_views;
select * from user_views;

--뷰에도 데이터추가가 가능하기에 조심!
insert into emp_view30
values(1111,'aaaa',30);


--사원,부서 테이블 조인(복잡한쿼리 예시)
select e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno;

--복잡한쿼리를 뷰테이블로 만들기
create view emp_view_dept as
select e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno;

--뷰로 조회
select * from emp_view_dept;

--영업팀을 위한 view
create view emp_view
as
select empno, ename, job, comm, deptno from emp_copy;

--개발팀을 위한 view
create view emp_view_dev
as
select empno, ename, job, deptno from emp_copy;

select * from emp_view;--영업팀
select * from emp_view_dev;--개발팀

--view삭제하기
drop view emp_view;
select view_name, text from user_views;


--view의 다양한 옵션

--create OR REPLACE : 없으면 만들고 있으면 생성!☆★☆★
create or replace view emp_view30
as
select empno, ename, sal, comm, deptno from emp_copy where deptno = 30;

select * from emp_view30;

--force : 기본 테이블 없이 뷰를 생성, 미리 뷰를 만들고 싶을 때(원하는 뷰이름을 선점하고자 할때)
create or replace force view employees_view
as
select empno, ename, sal, comm, deptno from employees where deptno = 30;

select view_name, text from user_views;

--noforce 테이블이 없으면 뷰가 만들어지지 않는다
create or replace noforce view employees_view
as
select empno, ename, sal, comm, deptno from employees where deptno = 30;


--조건 컬럼 값을 변경하지 못하게 하는 with check option  ☆★☆★중요
create or replace view view_chk30
as
select empno, ename, sal, comm, deptno from emp_copy where deptno = 30 --조건문에 해당하는 쿼리만 제어가 됨
with check option;


select * from view_chk30;

update view_chk30 set deptno = 20;

--with read only : 넌 읽기만해
create or replace view view_read30
as
select empno, ename, sal, comm, deptno from emp_copy where deptno = 30
with read only;

update view_read30 set comm = 200; --수정이 안되는걸 확인

--☆★☆★☆★중요
--rownum : 컬럼 성격 파악하기 //오라클에만 있음
--
select rownum, empno, ename, hiredate 
from emp 
order by hiredate;

--뷰에서 정렬 후 정의하면 rownum도 다시 정의
create or replace view view_hire
as
select empno, ename, hiredate from emp_copy
order by hiredate;

select * from view_hire;
select rownum, empno, ename, hiredate 
from view_hire
order by hiredate;


--인라인 뷰
select * from
(
    select e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc
    from emp e, dept d
    where e.deptno = d.deptno
) emp_dept; --별칭



--부서별 최대 급여와 최소 급여를 출력하는 뷰를 정의하기
create view sal_view
as
select d.dname, max(e.sal) as max_sal, min(e.sal) as min_sal
from emp_copy e, dept d
where e.deptno = d.deptno
group by d. dname;

select * from sal_view;

--
