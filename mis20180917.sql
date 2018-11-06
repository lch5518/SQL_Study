select ename as "�����", sal*12+nvl(comm,0) as "����" from emp;
select * from emp;

select ename, nvl(comm,0) from emp;
select ename, nvl2(comm,comm,0) from emp;


select ename || '�� ������' || job || '�Դϴ�.' as ����
from emp;

select ename, sal*12 || '����' as ���� from emp;


--�ߺ�����
select * from emp;
select DISTINCT deptno from emp; 
select distinct job from emp;



select * from emp where sal >= 500; 

select * from emp where deptno >= 20;

select * from emp where ename = '�ȼ���';  --���ڿ��� ��������ǥ �ʼ�

select * from emp where hiredate < to_date('2005/01/01','YYYY/MM/DD');

select * from emp where deptno = 10 and job ='����';
select * from emp where deptno = 30 and job ='����';
select * from emp where deptno = 10 or job ='����';

--not�������� 3���� ��� // <> �� ��õ!
select * from emp where not deptno = 10;
select * from emp where deptno != 10;
select * from emp where deptno <> 10;

--'between and' �����ڷ� and�� �Բ� �ܿ��.
select * from emp where sal >= 400 and sal <= 500; --sal�� 400�̻� 500������ ��
select * from emp where sal between 400 and 500; --���� ����
select * from emp where sal between 500 and 600;
select * from emp where  sal not between 400 and 600;
select * from emp where  not sal between 400 and 600;

select * from emp where hiredate between 
to_date('2003/01/01','YYYY/MM/DD') and to_date('2003/12/31','YYYY/MM/DD');

--in������
select * from emp;
select * from emp where comm = 80 or comm = 100 or comm = 200;
select * from emp where comm in(80,100,200);
select * from emp where comm <> 80 and comm <> 100 and comm <> 200;
select * from emp where comm not in(80,100,200);

--like������
select * from emp where ename like '��%';
select * from emp where ename like '��__'; --Ư���ڸ� �˻�
select * from emp where ename like '��%';
select * from emp where ename like '%��';
select * from emp where ename like '%��%'; --���� �˻� //�ַ� ����
select * from emp where ename like '_��%'; --��(ù��° �ڸ�����)�� �˻�����
select * from emp where ename like '__��';

--null ������ ����, ���� ���� ����
select * from emp;
select * from emp where comm is null;
select * from emp where comm is not null; --�ǽ��ϴٺ��� ���� ����. ������ ���� ����� ����
select * from emp where not comm is null;



--order by ��
 select * from emp;
 select * from emp order by ename asc;
 select * from emp order by sal;
 select * from emp order by sal asc;
 select * from emp order by sal desc;
 select * from emp order by hiredate asc;
 select * from emp order by hiredate desc, ename asc;
 
 
 
 /*[3��] ����Ŭ �ֿ��Լ�
 Dual���̺�*/--�������̺�..?
 select 24*60 from dual;
 select sysdate from dual;
 select 34.5678,floor(34.5678),abs(-34.5678), round(34.5678,2),trunc(34.5678,2) from dual;
 select mod(11,4) from dual;--��������
 
 --���ڱ���
 select length('oracle'), length('����Ŭ') from dual;
 select lengthb('����Ŭ') from dual;--�ѱ��� 3����Ʈ
 
 --��������
 select substr('welcome to oracle',4,3) from dual;
 select substr('welcome to oracle',1,7) from dual;
 select substr('����Ŭ',1,2) from dual;
 select substrb('����Ŭ',1,6) from dual;
 
 select ename, sal, hiredate from emp;
 
 select deptno �μ���ȣ, dname as �μ��� from dept;
 
 select distinct job from emp;
 
 select empno, ename, sal from emp where sal <= 300;
 
 select empno, ename, sal from emp where ename = '����ȣ';
 
 select empno, ename, sal from emp where sal=250 or sal = 300 or sal = 500;
 select empno, ename, sal from emp where sal in(250, 300, 500);
 
 select empno, ename, sal from emp where sal <> 250 and sal <> 300 and sal <> 500;
 select empno, ename, sal from emp where sal not in(250, 300, 500);
 
 select empno, ename from emp where ename like '��%' or ename like '%��%';
 
 select * from emp where mgr is null;
 
 select empno, ename, job, to_char(hiredate, 'YYYY/MM/DD') from emp order by hiredate desc;
 
 select deptno, empno, ename, job, to_char(hiredate, 'YYYY/MM/DD') from emp order by deptno asc, hiredate asc;

select empno, ename, sal from emp where ename = '����ȣ';

select empno, ename, sal from emp where sal = 250 or sal = 300 or sal = 500;
select empno, ename, sal from emp where sal in(250,300,500);

select empno, ename, sal from emp where sal != 250 and sal != 300 and sal != 500;
select empno, ename, sal from emp where sal not in(250,300,500);

select deptno, empno, ename, job, to_char(hiredate,'YYYY/MM/DD') from emp order by deptno , hiredate;
select sal*12 + nvl(comm,0) as ���� from emp;

select * from emp;
select to_char(hiredate,'YYYY/MM/DD') from emp;
select * from emp where substr(hiredate,4,2) = 09;

select empno, ename, job, sal,
    decode(job, '����', sal+sal*0.05, 
                '����', sal+sal*0.1,
                '�븮', sal+sal*0.15,
                '���', sal+sal*0.2,
                '����', sal,
                '����', sal) as upsal
from emp;

select empno, ename, job, sal, 
    case when job='����' then sal+sal*0.05
    else sal
    end as upsal
    from emp;

select hiredate, to_char(hiredate,'YY/MON/DD DY') from emp;


select round(sysdate-hiredate,0) �ٹ��ϼ� from emp;

select max(sal) Maximum, min(sal) Minimum, sum(sal) sum, trunc(avg(sal)) average from emp; 

select job, max(sal) Maximum, min(sal) Minimum, sum(sal) sum, trunc(avg(sal)) average from emp group by job;

select job, count(*) from emp group by job;

select * from emp;

select count(mgr) from emp where job = '����';\

select decode(deptno, 10, '������',
                      20, '�λ��', 
                      30, '�渮��') as dname, 
       decode(deptno, 10, '����',
                      20, '��õ', 
                      30, '����') as location, count(*) as "number of people", round(avg(sal)) as sal
from emp group by deptno order by deptno;

