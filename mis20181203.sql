--시퀀스는 오라클에서 지원하는 함수! mysql은 지원x
--maxvalue를 최대로 한다고 메모리를 차지하는건 아님
--cycle : 반복적인 번호를 주고자 할 때, 기본키가 설정되어 있으면 오류나므로 조심
--cache : 대게 dba들이 사용하며 기본값은 20

--회사에서는 네이밍하는게 어렵다 이걸로 자주 회의를 하기도함. ex)TB_emp -> 테이블 emp
--시험☆★☆★(with나 by를 빠뜨리기 쉬우므로)
create SEQUENCE dept_deptno_seq
                start with 10
                increment by 10;

select * from user_sequences;
select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;

--currval : 현재 시퀀스값(조회기능)
--nextval : 다음 시퀀스값(기본값에서 insert할때, 발급)

--nextval은 호출할 때마다 증가되고 되돌리려면 삭제하고 다시 만들어야됨
select dept_deptno_seq.nextval from dual;

--currval은 현재 시퀀스를 확인할 때
select dept_deptno_seq.currval from dual;

--아무런 제약조건이 없으면 1부터 1씩증가하는 시퀀스가 기본값으로 적용됨
create SEQUENCE sample_seq;

--발급된 시퀀스가 없으니 처음에는 오류가 남
select sample_seq.currval from dual;
--1을 발급
select sample_seq.nextval from dual;



--시퀀스는 99.9%가 insert 연산과 같이 사용되어 컬럼 값을 자동으로 발생시키는 용도로 사용
create sequence emp_seq
                start with 1
                increment by 1
                maxvalue 100000;
                
create table emp01(
    empno number(4) primary key,
    ename varchar(10),
    hiredate date
    );
desc emp01;
select * from emp01;

--제약조건 확인하기
select constraint_name, constraint_type, table_name
from user_constraints
where table_name in ('EMP01');

--컬럼의 제약조건 확인하기
select constraint_name, column_name, table_name
from user_cons_columns
where table_name in ('EMP01');

----insert연산과 같이 시퀀스를 써보자------
insert into emp01
values (emp_seq.nextval,'홍길동',sysdate);

insert into emp01
values (emp_seq.nextval,'강감찬',sysdate);
-----------------------------------------

select * from emp01;

--어떤 시퀀시가 있을까
select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;

--시퀀스 제거하기(통상 있는 일 이기에 부담가질 필요없다)
drop sequence dept_deptno_seq;

--시퀀스 수정하기(start with값은 수정할 수 없기 때문에 start with를 바꾸고싶으면 삭제 후 다시 만들어야함)
create SEQUENCE dept_deptno_seq
                start with 10
                increment by 10
                maxvalue 30;
select dept_deptno_seq.nextval from dual;--maxvalue가 30이라 4번 실행할 때부터 오류가 남

alter sequence dept_deptno_seq
maxvalue 1000;





--인덱스(책깔피..?) : 처리속도를 향상시키기 위해서 컬럼에 대해서 생성하는 오라클 객체, 메모리필요 ex)도서관, 지도
--수정이 자주 일어나는 데이터에는 오히려 성능이 떨어진다. 
--오라클은 primary key나 unipue에는 인덱스를 자동으로 만들어 준다.
select index_name, table_name, column_name
from user_ind_columns
where table_name in('EMP','DEPT');


drop table emp01;

create table emp01
as 
select * from emp;

select * from emp;
select * from emp01;

--쿼리를 복제하여 데이터를 늘려보자
insert into emp01
select * from emp01;

--이제 작업속도를 확인!
select * from emp01;
select distinct empno, ename from emp01
where ename = '김사랑';

--인덱스 생성
create index idx_emp01_ename
on emp01(ename);

--인덱스 제거
drop index idx_emp01_ename;


--함수기반 인덱스
create index idx_emp01_annsal
on emp01(sal*12);

select index_name, table_name, column_name
from user_ind_columns
where table_name in('EMP01');





--500p 부서테이블에 부서번호를 자동으로 부여
create table dept_example(
    deptno number(4) primary key,
    dname varchar(15),
    loc varchar(15)
    );

select constraint_name, constraint_type, table_name
from user_constraints
where table_name in('DEPT_EXAMPLE');

select constraint_name, column_name, table_name
from user_cons_columns
where table_name in('DEPT_EXAMPLE');

create sequence dept_example_seq
    increment by 10
    start with 10
    nocycle;
    
insert into dept_example
values(dept_example_seq.nextval, '인사과','서울');
insert into dept_example
values(dept_example_seq.nextval, '경리과','서울');
insert into dept_example
values(dept_example_seq.nextval, '총무과','대전');
insert into dept_example
values(dept_example_seq.nextval, '기술팀','인천');

select * from dept_example;
