--substr  ���ڸ� �߶� ����(���, ����, ����)
select substr('welcome to oracle', 4,3) from dual;
select substr('welcome to oracle', 9,2) from dual;

select substr('1234 6789 11',11,2) from dual;
select * from dual;

--instr ������ ��ġ ����(���, ã�� ����, ����, ���°�߰�)
select instr('welcome to oracle','o',1,3) from dual;

--Ư�� ��ȣ�� ä���
select lpad('welcome',10,'#') from dual;
select rpad('welcome',20,'#') from dual;

select lpad('abc',5,'1') from dual;
select rpad('12345',6,'*') from dual;


--�⺻ ��¥ ����Ȯ���ϱ�
select sysdate from dual;

--����ȯ�Լ�(TO_CHAR, TO_DATE, TO_NUMBER)
select sysdate, to_char(sysdate,'yyyy-mm-dd') from dual;
select sysdate, to_char(sysdate,'yyyy-mm-dd(day)') from dual;
select sysdate, to_char(sysdate,'yyyy-mm-dd-day') from dual;
select sysdate, to_char(sysdate,'yyyy-mon-dd-day') from dual;
select hiredate, to_char (hiredate, 'YYYY/MM/DD day') from emp;
select sysdate, to_char(sysdate, 'yyyy-mm-dd, pm hh:mi:ss') from dual;


select to_char(1230000), to_char(1230000,'L999,999,999') from dual;

select hiredate from emp;

--to_date(��ȯ�� ��, ����) //where�� �˻��� �� ���� ����
select ename, hiredate from emp where hiredate=to_date('20070301','yyyy-mm-dd');

--�ٹ���
select trunc(sysdate-to_date('2018-01-01','yyyy-mm-dd')) from dual;

select to_number('20,000','99,999') - to_number('10,000','99,999') from dual;

select * from emp;
--�ٹ��޼� ���ϱ�
select ename, to_char(sysdate,'yyyy/mm/dd') ����, to_char(hiredate, 'yyyy/mm/dd') �Ի���, 
       trunc(months_between (sysdate, hiredate)) �ٹ����� from emp;
        
        
--���� �� ���ϱ�
select ename, to_char(hiredate, 'yyyy/mm/dd') �Ի���, 
       to_char(add_months(hiredate,6),'yyyy/mm/dd') "�Ի� 6���� ��" ,
       to_char(last_day(hiredate),'YYYY/mm/dd') "�Ի���� ��������"
from emp;

select ename, to_char(hiredate, 'yyyy/mm/dd') as �Ի���,
        to_char(add_months(hiredate,7),'yyyy/mm/dd, dy') as test
from emp;

select * from emp;

--null�� �ٸ� ������ ��ȯ�ϴ� nvl(�÷�, ��ġ��) //�ڷ����� ��ġ�Ͽ�����
--nvl2(�÷�, null�� �ƴѰ�� ��ġ��, null�� ��� ��ġ��)
select ename, sal, comm,
       nvl2(comm, sal*10+comm, sal*10) ����
from emp
order by ���� desc;

select * from emp;

--decoode �������� ����(����, ����1,���1,...) <- case���� ����, ��Ģ���� ������ ���� ���
select ename, deptno,
       decode (deptno, 10, '�渮��',
                       20, '�λ��',
                       30, '������',
                       40, '�����') as dname
from emp;

select ename, job, decode(job, '����','����1', 
                               '����','����2',
                               '����','����3',
                               '����','����4',
                               '�븮','����5',
                               '���','����6') as gift 
from emp;
                               


--case when ����1 then ���1 ...  <- ifelse���� ����, Ư�������� ���� ���
select ename, deptno,
    case when deptno = 10 then '�渮��'
         when deptno = 20 then '�λ��'
         when deptno = 30 then '������'
         when deptno = 40 then '�����'
    end as dname
from emp;

select * from emp;

select ename, deptno,
    case when deptno = 10 then '�渮��'
         when deptno = 20 then '�λ��'
end from emp;


select * from emp
where to_char(hiredate,'mm')='09';
select * from emp
where to_char(hiredate,'yyyy')='2003';


--�׷��Լ������� null�� �ڵ����� ó�����ش�

--count
select count(*) from emp;
select count(comm) from emp; --null�� �����ϰ� ������ ����

--grounp by
select deptno �μ���ȣ, sum(sal) "���� �հ�", max(sal),min(sal), trunc(avg(sal)) 
from emp group by deptno;



select * from emp;

--Quiz p156~8
--1. �����ȣ�� Ȧ�� �� ������� �˻��� ���ÿ�
select * from emp
where mod(empno,2)=1;

--2. ������� �Ի��Ͽ� ���ؼ� �⵵, ��, ���� ���������� ����Ͻÿ�.
select hiredate, to_char(hiredate,'YYYY') �⵵,
                 to_char(hiredate,'mm') ��,
                 to_char(hiredate,'dd') ��
from emp;

--3. ����ڰ� ���� ����� ����ϵ�, ����� ���� CEO�� ��� �Ͻÿ�.
select empno, ename, nvl(to_char(mgr,'9999'),'C E O') as "���� ���"
from emp
where mgr is null;














      


