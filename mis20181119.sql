--#서브쿼리
select * from dept; --테이블확인

select deptno from emp where ename = '이문세'; --이문세 부서번호 확인

--이문세의 부서번호를 통해 부서명을 검색
select dname from dept
where deptno = (select deptno from emp 
                where ename = '이문세');-- <서브쿼리>
                
--부서번호를 통해 부서이름 출력
select dname from dept
where deptno = 10;

select * from emp;
select ename, sal from emp;--전 사원의 급여확인
select avg(sal) from emp;--급여의 평균

--평균 급여보다 더 많은 급여를 받은 사원(이름, 월급) 출력하기
select ename, sal from emp
where sal > ( select avg(sal) from emp);

select avg(comm) from emp;
--평균 커미션보다 더 많은 커미션을 받은 사원(이름, 월급) 출력하기
select ename, comm from emp
where comm > ( select avg(comm) from emp);

--인천에서 출근하는 사원(이름, 부서번호)을 출력하시오.
select * from dept;
select * from emp;
select deptno from dept where loc = '인천';

select ename, deptno from emp
where deptno = (select deptno from dept where loc = '인천');


--안성기와 같은 부서 사원(이름, 부서번호)들을 출력하시오
select * from emp;
select deptno from emp where ename = '안성기';--서브쿼리는 단일행이어야 된다
select ename, deptno from emp
where deptno = (select deptno from emp where ename = '안성기');

--사원들의 평균값 보다 월급을 낮게 받는 사원(이름, 직급, 월급)을 출력
select * from emp;
select ename, job, sal from emp
where sal < (select avg(sal) from emp);


--서브쿼리가 <다중행>일 때
--급여가 500을 초과하는 사원과 같은 부서에 근무하는 사원(이름, 급여, 부서번호) 구하기
select distinct deptno from emp where sal > 500;
--distinct : 중복제거
select ename, sal, deptno from emp
where deptno in (select distinct deptno from emp where sal > 500); 

select ename, sal, deptno from emp
where deptno in (select distinct deptno from emp where sal < (select avg(sal) from emp)); 

select ename, sal, deptno from emp
where deptno in (10, 20);

--커미션이 평균 값을 초과하는 사원과 같은 부서에 근무하는 사원(이름, 커미션, 부서번호)구하기
select ename, comm, deptno from emp
where deptno in
(select distinct deptno from emp where comm < (select avg(comm) from emp));

--30번 부서의 최대 급여보다 많은 급여를 받는 사원(이름, 월급) 출력하기[all]
select ename, sal from emp
where sal > (select max(sal) from emp where deptno = 30);

select ename, sal from emp
where sal > all(select sal from emp where deptno = 30);

--30번 부서의 최소 급여보다 많은 급여를 받는 사원(이름, 월급) 출력하기[any]
select ename, sal from emp
where sal > (select min(sal) from emp where deptno = 30);--mysql호환

select ename, sal from emp
where sal > any(select sal from emp where deptno = 30);--oracle

--서브쿼리로 테이블을 생성해보자
desc emp02;

create table emp02
as
select * from emp;
select * from emp02;

desc emp03;
create table emp03
as
select empno, ename from emp;
select * from emp03;

create table emp05
as
select * from emp where deptno = 30;
select * from emp05;

--테이블의 구조만 복사하기
create table emp06
as
select * from emp where 1=0;
desc emp06;
select * from emp06;

--서브쿼리로 데이터 삽입하기
desc dept01;
create table dept01
as
select * from dept where 1=0;
select * from dept01;

insert into dept01
select * from dept;
select * from dept01;

--서브쿼리를 이용한 데이터 변경,update문은 조심히
select * from dept01;--인사부가 수원으로 이사를 한다면?
update dept01
set loc = (select loc from dept where deptno = 40)
where deptno = 20;
select loc from dept where deptno = 40;--수원
--전산실과 부서 통합으로 인해 지역 변경
select * from dept01;

--서브쿼리를 이용한 데이터 삭제 : 영업부 사원들 권고사직
select * from emp02;
delete from emp02
where deptno = (select deptno from dept
                where dname = '영업부');
select deptno from dept where dname = '영업부'; --서브쿼리하기 전 확인

--7번문제
drop table emp06;
desc emp06;

create table emp06
as
select * from emp;
select * from emp06;

--13번문제
select * from emp;
select ename, sal from emp
where  sal >= (select sal from emp 
              where ename = '이문세' ) and not ename = '이문세';
              
              
select sal from emp 
where ename = '이문세';

--14번문제
select ename, deptno from emp
where deptno = (select deptno from dept where loc = '인천');

--15번문제
select * from emp;

select ename, sal, mgr from emp
where ename in (select ename from emp where mgr = 
               (select empno from emp where ename = '감우성'))
               and not mgr = 1003;
            
select * from emp where ename = '이병헌';
select empno from emp where ename = '감우성';

select ename from emp where mgr = (select mgr from emp where ename = '감우성');

--16번문제
select empno, ename, sal, deptno from emp e
where sal = (select max(sal) from emp where deptno = e.deptno)
order by deptno, empno asc;
