--#��������
select * from dept; --���̺�Ȯ��

select deptno from emp where ename = '�̹���'; --�̹��� �μ���ȣ Ȯ��

--�̹����� �μ���ȣ�� ���� �μ����� �˻�
select dname from dept
where deptno = (select deptno from emp 
                where ename = '�̹���');-- <��������>
                
--�μ���ȣ�� ���� �μ��̸� ���
select dname from dept
where deptno = 10;

select * from emp;
select ename, sal from emp;--�� ����� �޿�Ȯ��
select avg(sal) from emp;--�޿��� ���

--��� �޿����� �� ���� �޿��� ���� ���(�̸�, ����) ����ϱ�
select ename, sal from emp
where sal > ( select avg(sal) from emp);

select avg(comm) from emp;
--��� Ŀ�̼Ǻ��� �� ���� Ŀ�̼��� ���� ���(�̸�, ����) ����ϱ�
select ename, comm from emp
where comm > ( select avg(comm) from emp);

--��õ���� ����ϴ� ���(�̸�, �μ���ȣ)�� ����Ͻÿ�.
select * from dept;
select * from emp;
select deptno from dept where loc = '��õ';

select ename, deptno from emp
where deptno = (select deptno from dept where loc = '��õ');


--�ȼ���� ���� �μ� ���(�̸�, �μ���ȣ)���� ����Ͻÿ�
select * from emp;
select deptno from emp where ename = '�ȼ���';--���������� �������̾�� �ȴ�
select ename, deptno from emp
where deptno = (select deptno from emp where ename = '�ȼ���');

--������� ��հ� ���� ������ ���� �޴� ���(�̸�, ����, ����)�� ���
select * from emp;
select ename, job, sal from emp
where sal < (select avg(sal) from emp);


--���������� <������>�� ��
--�޿��� 500�� �ʰ��ϴ� ����� ���� �μ��� �ٹ��ϴ� ���(�̸�, �޿�, �μ���ȣ) ���ϱ�
select distinct deptno from emp where sal > 500;
--distinct : �ߺ�����
select ename, sal, deptno from emp
where deptno in (select distinct deptno from emp where sal > 500); 

select ename, sal, deptno from emp
where deptno in (select distinct deptno from emp where sal < (select avg(sal) from emp)); 

select ename, sal, deptno from emp
where deptno in (10, 20);

--Ŀ�̼��� ��� ���� �ʰ��ϴ� ����� ���� �μ��� �ٹ��ϴ� ���(�̸�, Ŀ�̼�, �μ���ȣ)���ϱ�
select ename, comm, deptno from emp
where deptno in
(select distinct deptno from emp where comm < (select avg(comm) from emp));

--30�� �μ��� �ִ� �޿����� ���� �޿��� �޴� ���(�̸�, ����) ����ϱ�[all]
select ename, sal from emp
where sal > (select max(sal) from emp where deptno = 30);

select ename, sal from emp
where sal > all(select sal from emp where deptno = 30);

--30�� �μ��� �ּ� �޿����� ���� �޿��� �޴� ���(�̸�, ����) ����ϱ�[any]
select ename, sal from emp
where sal > (select min(sal) from emp where deptno = 30);--mysqlȣȯ

select ename, sal from emp
where sal > any(select sal from emp where deptno = 30);--oracle

--���������� ���̺��� �����غ���
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

--���̺��� ������ �����ϱ�
create table emp06
as
select * from emp where 1=0;
desc emp06;
select * from emp06;

--���������� ������ �����ϱ�
desc dept01;
create table dept01
as
select * from dept where 1=0;
select * from dept01;

insert into dept01
select * from dept;
select * from dept01;

--���������� �̿��� ������ ����,update���� ������
select * from dept01;--�λ�ΰ� �������� �̻縦 �Ѵٸ�?
update dept01
set loc = (select loc from dept where deptno = 40)
where deptno = 20;
select loc from dept where deptno = 40;--����
--����ǰ� �μ� �������� ���� ���� ����
select * from dept01;

--���������� �̿��� ������ ���� : ������ ����� �ǰ����
select * from emp02;
delete from emp02
where deptno = (select deptno from dept
                where dname = '������');
select deptno from dept where dname = '������'; --���������ϱ� �� Ȯ��

--7������
drop table emp06;
desc emp06;

create table emp06
as
select * from emp;
select * from emp06;

--13������
select * from emp;
select ename, sal from emp
where  sal >= (select sal from emp 
              where ename = '�̹���' ) and not ename = '�̹���';
              
              
select sal from emp 
where ename = '�̹���';

--14������
select ename, deptno from emp
where deptno = (select deptno from dept where loc = '��õ');

--15������
select * from emp;

select ename, sal, mgr from emp
where ename in (select ename from emp where mgr = 
               (select empno from emp where ename = '���켺'))
               and not mgr = 1003;
            
select * from emp where ename = '�̺���';
select empno from emp where ename = '���켺';

select ename from emp where mgr = (select mgr from emp where ename = '���켺');

--16������
select empno, ename, sal, deptno from emp e
where sal = (select max(sal) from emp where deptno = e.deptno)
order by deptno, empno asc;
