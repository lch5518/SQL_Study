desc user_constraints;

select constraint_name, constraint_type, table_name from user_constraints;

create table emp02(
    empno number(4) not null,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
);

insert into emp02
values(1234, 'ȫ�浿', '���', 30);

select * from emp02;
desc emp02;

--unique ��������
create table emp03(
    empno number(4) unique,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
);
desc emp03; --unique�� null�� �� �� �ִ�! pk�� �ٸ���.

insert into emp03
values(1000, '����', '���', 30);

insert into emp03
values(1000, '��ö��', '����', 20); --�����ڵ� 1�� unique

insert into emp03
values(null, '�̼���', '����', 20); --unique�� null ���԰���

select * from emp03;

create table emp04(
    empno number(4) constraint emp04_empno_uk unique, --�������ǿ� ��Ī �ο��ϱ�
    ename varchar2(10) constraint emp04_empno_nn not null,
    job varchar2(9),
    deptno number(2)
);
desc emp04;

select constraint_name, constraint_type, table_name
from user_constraints; --�������� ��Ī�� Ȯ���غ���

--������ �� ������
insert into emp04
values(1000, '����', '���', 30);

insert into emp04
values(1000, '��ö��', '����', 20); --�����ڵ忡�� unique�� ��Ī�� Ȯ���� �� �ִ�


--primary key -> unique + not null
create table emp05(
    empno number(4) constraint emp05_empno_pk primary key, --��Ī�ο�
    ename varchar2(10) constraint emp05_ename_nn not null,
    job varchar2(9),
    deptno number(2)
);
desc emp05;

--����������
insert into emp05
values(1000, '����', '���', 30);
insert into emp05
values(1000, '��ö��', '����', 20); --�����ڵ忡�� ��Ī�� Ȯ���� �� �ִ�
insert into emp05
values(null, '�ƹ���', '����', 20);

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

--����Ȯ��/ 50(x)
insert into emp06
values(1010, 'ȫ�浿', '���', 50);

--dept���� 10~40���� �ִ�
insert into emp06
values(1010, 'ȫ�浿', '���', 40);



--check
create table emp07(
    empno number(4) constraint emp07_empno_pk primary key,
    ename varchar2(10) constraint emp07_ename_nn not null,
    sal number(7,2) constraint emp07_sal_ck check(sal between 500 and 5000),
    gender varchar2(1) constraint emp07_gender_ck check(gender in('M','F'))
);
desc emp07;

--����Ȯ��
insert into emp07
values(1000, '����', 200, 'M');--200�� ������ ���
insert into emp07
values(1000, '����', 500, 'A');--gerder ������ ���
insert into emp07
values(1000, '����', 500, 'M');

select * from emp07;--������Ȯ��


--default : ����ڰ� �ƹ����� �Է����� �ʾ��� �� �⺻������
create table dept01(
    deptno number(2) primary key,
    dname varchar(14),
    loc varchar(13) default '����'
);
desc dept01;

insert into dept01(deptno, dname)
values(10,'�ƹ���');

select * from dept01;


--�ٸ�������� �������� �����ϱ�
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


--�������� �����ϱ�
create table emp10 as select * from emp01;
desc emp10;

alter table emp10
add constraint emp10_empno_pk primary key(empno);

alter table emp10
add constraint emp10_deptno_fk 
foreign key(deptno) references dept(deptno);

--not null�� modify�� �����ؾ���
alter table emp10
modify job constraint emp10_job_nn not null;

desc emp10;


--�������� �����ϱ�
alter table emp10
drop constraint emp10_empno_pk;--��Ī���� �⺻Ű �����
desc emp10;


--���������� ��Ȱ��ȭ�� cascade
select * from emp where deptno = 10;
select * from dept;

delete from dept where deptno =  10;--����. 

desc dept01;

alter table dept01
drop primary key cascade;--���ŵǸ鼭 ���赵 �� �������, ��� ������ �ɼ�



