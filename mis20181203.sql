--�������� ����Ŭ���� �����ϴ� �Լ�! mysql�� ����x
--maxvalue�� �ִ�� �Ѵٰ� �޸𸮸� �����ϴ°� �ƴ�
--cycle : �ݺ����� ��ȣ�� �ְ��� �� ��, �⺻Ű�� �����Ǿ� ������ �������Ƿ� ����
--cache : ��� dba���� ����ϸ� �⺻���� 20

--ȸ�翡���� ���̹��ϴ°� ��ƴ� �̰ɷ� ���� ȸ�Ǹ� �ϱ⵵��. ex)TB_emp -> ���̺� emp
--����١ڡ١�(with�� by�� ���߸��� ����Ƿ�)
create SEQUENCE dept_deptno_seq
                start with 10
                increment by 10;

select * from user_sequences;
select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;

--currval : ���� ��������(��ȸ���)
--nextval : ���� ��������(�⺻������ insert�Ҷ�, �߱�)

--nextval�� ȣ���� ������ �����ǰ� �ǵ������� �����ϰ� �ٽ� �����ߵ�
select dept_deptno_seq.nextval from dual;

--currval�� ���� �������� Ȯ���� ��
select dept_deptno_seq.currval from dual;

--�ƹ��� ���������� ������ 1���� 1�������ϴ� �������� �⺻������ �����
create SEQUENCE sample_seq;

--�߱޵� �������� ������ ó������ ������ ��
select sample_seq.currval from dual;
--1�� �߱�
select sample_seq.nextval from dual;



--�������� 99.9%�� insert ����� ���� ���Ǿ� �÷� ���� �ڵ����� �߻���Ű�� �뵵�� ���
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

--�������� Ȯ���ϱ�
select constraint_name, constraint_type, table_name
from user_constraints
where table_name in ('EMP01');

--�÷��� �������� Ȯ���ϱ�
select constraint_name, column_name, table_name
from user_cons_columns
where table_name in ('EMP01');

----insert����� ���� �������� �Ẹ��------
insert into emp01
values (emp_seq.nextval,'ȫ�浿',sysdate);

insert into emp01
values (emp_seq.nextval,'������',sysdate);
-----------------------------------------

select * from emp01;

--� �����ð� ������
select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;

--������ �����ϱ�(��� �ִ� �� �̱⿡ �δ㰡�� �ʿ����)
drop sequence dept_deptno_seq;

--������ �����ϱ�(start with���� ������ �� ���� ������ start with�� �ٲٰ������ ���� �� �ٽ� ��������)
create SEQUENCE dept_deptno_seq
                start with 10
                increment by 10
                maxvalue 30;
select dept_deptno_seq.nextval from dual;--maxvalue�� 30�̶� 4�� ������ ������ ������ ��

alter sequence dept_deptno_seq
maxvalue 1000;





--�ε���(å����..?) : ó���ӵ��� ����Ű�� ���ؼ� �÷��� ���ؼ� �����ϴ� ����Ŭ ��ü, �޸��ʿ� ex)������, ����
--������ ���� �Ͼ�� �����Ϳ��� ������ ������ ��������. 
--����Ŭ�� primary key�� unipue���� �ε����� �ڵ����� ����� �ش�.
select index_name, table_name, column_name
from user_ind_columns
where table_name in('EMP','DEPT');


drop table emp01;

create table emp01
as 
select * from emp;

select * from emp;
select * from emp01;

--������ �����Ͽ� �����͸� �÷�����
insert into emp01
select * from emp01;

--���� �۾��ӵ��� Ȯ��!
select * from emp01;
select distinct empno, ename from emp01
where ename = '����';

--�ε��� ����
create index idx_emp01_ename
on emp01(ename);

--�ε��� ����
drop index idx_emp01_ename;


--�Լ���� �ε���
create index idx_emp01_annsal
on emp01(sal*12);

select index_name, table_name, column_name
from user_ind_columns
where table_name in('EMP01');





--500p �μ����̺� �μ���ȣ�� �ڵ����� �ο�
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
values(dept_example_seq.nextval, '�λ��','����');
insert into dept_example
values(dept_example_seq.nextval, '�渮��','����');
insert into dept_example
values(dept_example_seq.nextval, '�ѹ���','����');
insert into dept_example
values(dept_example_seq.nextval, '�����','��õ');

select * from dept_example;
