--�����ð� ���� ��
select * from emp
where mod(empno, 2) = 1;

select hiredate, substr(hiredate,1,2) �⵵,
                 substr(hiredate,4,2) ��,
                 substr(hiredate,7,2) ��
                 from emp;
                 
select hiredate, to_char(hiredate,'yyyy') �⵵, 
                 to_char(hiredate,'mm') ��,
                 to_char(hiredate,'dd') ��
                 from emp;
                 
select empno, ename, nvl(to_char(mgr, '9999'), 'c e o') as ���ӻ��
        from emp
        where mgr is null;
        
select * from emp;

select * from emp where comm is null;

--�׷��Լ�
select deptno, count(*) "�μ��� �����", count(comm) "Ŀ�̼� �޴� �����"
from emp
group by deptno
order by deptno;



select job, sum(sal) as "�����հ�"
from emp
group by job;


select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 500;



select job, count(*), sum(sal)
from emp
where job not like '%���%'
group by job
having sum(sal) >= 1000
order by sum(sal) desc; -- �⺻�� asc(��������)

select ename, sal, to_char(hiredate,'yyyy-mm-dd') as �Ի��� from emp;


--���̺����� ����� create table
create table emp01(
    empno number(4),
    ename varchar2(14),
    sal number(7,3)
);

--���� ���̺�Ȯ���ϱ�
desc emp01;

--�÷��߰��ϱ�
alter table emp01
add(birth date);

--�÷� �����ϱ�
alter table emp01
modify ename varchar2(30);

--�÷� �����ϱ�
alter table emp01
drop column ename;

desc emp01;


--���̺�� ����
rename emp01 to emp02;
rename emp02 to emp01;
desc emp02;

--���̺� ����, ���ﶧ�� ���踦 ���� ���캸�� �ڽ� -> �θ� ������ ������ �Ѵ�.
drop table emp02;
desc emp02;

--�߰���� 10���� ����, 30������

--1.table 3 �������� + desc table
--���� + desc___ + ���
--2.table �÷��߰� Query + desc table ���
--3.rename ���� + desc table ���
--4. ctas������� + desc table ���
--5. drop table ����


--���̺����
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

--���̺� ����
ALTER TABLE CUSTOMER_EMPLOYEE ADD(ODR_DATE DATE);
DESC CUSTOMER_EMPLOYEE;

--���̺�� ����
RENAME CUSTOMER_EMPLOYEE TO PDCT_ORDER;
DESC PDCT_ORDER;

--���̺� ����
CREATE TABLE TEMP_EMP AS SELECT * FROM EMPLOYEE;
DESC TEMP_EMP;
DROP TABLE TEMP_EMP;