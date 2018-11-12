desc user_constraints;

select constraint_name, constraint_type, table_name from user_constraints;

create table emp02(
    empno number(4) not null,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
);

insert into emp02
values(1234, '홍길동', '사원', 30);

select * from emp02;
desc emp02;

--unique 제약조건
create table emp03(
    empno number(4) unique,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
);
desc emp03; --unique는 null도 들어갈 수 있다! pk와 다른점.

insert into emp03
values(1000, '허준', '사원', 30);

insert into emp03
values(1000, '김철수', '과장', 20); --에러코드 1번 unique

insert into emp03
values(null, '이순신', '과장', 20); --unique는 null 삽입가능

select * from emp03;

create table emp04(
    empno number(4) constraint emp04_empno_uk unique, --제약조건에 별칭 부여하기
    ename varchar2(10) constraint emp04_empno_nn not null,
    job varchar2(9),
    deptno number(2)
);
desc emp04;

select constraint_name, constraint_type, table_name
from user_constraints; --제약조건 별칭을 확인해보자

--오류를 좀 내볼까
insert into emp04
values(1000, '허준', '사원', 30);

insert into emp04
values(1000, '김철수', '과장', 20); --에러코드에서 unique의 별칭을 확인할 수 있다


--primary key -> unique + not null
create table emp05(
    empno number(4) constraint emp05_empno_pk primary key, --별칭부여
    ename varchar2(10) constraint emp05_ename_nn not null,
    job varchar2(9),
    deptno number(2)
);
desc emp05;

--에러내보자
insert into emp05
values(1000, '허준', '사원', 30);
insert into emp05
values(1000, '김철수', '과장', 20); --에러코드에서 별칭을 확인할 수 있다
insert into emp05
values(null, '아무개', '과장', 20);

--foreign key
create table emp06(
    empno number(4) constraint emp06_empno_pk primary key,
    ename varchar2(10) constraint emp06_ename_nn not null,
    job varchar2(9),
    deptno number(2) constraint emp06_deptno_fk references dept(deptno)
);
desc emp06;
select * from emp06;
select * from dept;

--오류확인/ 50(x)
insert into emp06
values(1010, '홍길동', '사원', 50);

--dept에는 10~40까지 있다
insert into emp06
values(1010, '홍길동', '사원', 40);



--check
create table emp07(
    empno number(4) constraint emp07_empno_pk primary key,
    ename varchar2(10) constraint emp07_ename_nn not null,
    sal number(7,2) constraint emp07_sal_ck check(sal between 500 and 5000),
    gender varchar2(1) constraint emp07_gender_ck check(gender in('M','F'))
);
desc emp07;

--오류확인
insert into emp07
values(1000, '허준', 200, 'M');--200이 범위를 벗어남
insert into emp07
values(1000, '허준', 500, 'A');--gerder 범위를 벗어남
insert into emp07
values(1000, '허준', 500, 'M');

select * from emp07;--데이터확인


--default : 사용자가 아무값도 입력하지 않았을 때 기본값설정
create table dept01(
    deptno number(2) primary key,
    dname varchar(14),
    loc varchar(13) default '서울'
);
desc dept01;

insert into dept01(deptno, dname)
values(10,'아무개');

select * from dept01;


--다른방식으로 제약조건 지정하기
create table emp01(
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9) unique,
    deptno number(2) references dept(deptno)
);
--emp01 == emp002
create table emp002(
    empno number(4),
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2),
    
    primary key(empno),
    unique(job),
    foreign key(deptno) references dept(deptno)
);


--제약조건 변경하기
create table emp10 as select * from emp01;
desc emp10;

alter table emp10
add constraint emp10_empno_pk primary key(empno);

alter table emp10
add constraint emp10_deptno_fk 
foreign key(deptno) references dept(deptno);

--not null은 modify로 설정해야함
alter table emp10
modify job constraint emp10_job_nn not null;

desc emp10;


--제약조건 제거하기
alter table emp10
drop constraint emp10_empno_pk;--별칭으로 기본키 지우기
desc emp10;


--제약조건의 비활성화와 cascade
select * from emp where deptno = 10;
select * from dept;

delete from dept where deptno =  10;--오류. 

desc dept01;

alter table dept01
drop primary key cascade;--제거되면서 관계도 다 끊어버림, 사실 위험한 옵션



