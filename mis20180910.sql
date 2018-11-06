show user;

-- �μ� ���̺� �����ϱ�
DROP TABLE EMP;
-- ��� ���̺� �����ϱ�
DROP TABLE DEPT;
-- �޿� ���̺� �����ϱ�
DROP TABLE SALGRADE;
-- �μ� ���̺� �����ϱ�
DROP TABLE EMPLOYEE;
-- ��� ���̺� �����ϱ�
DROP TABLE DEPARTMENT;
-- �޿� ���̺� �����ϱ�
DROP TABLE SALGRADE;

-- �μ� ���̺� �����ϱ�
CREATE TABLE DEPT(
	 DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	 DNAME VARCHAR2(14),
	 LOC   VARCHAR2(13) ) ;

-- ��� ���̺� �����ϱ�
CREATE TABLE EMP( 
  	 EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	 ENAME VARCHAR2(10),
 	 JOB   VARCHAR2(9),
	 MGR  NUMBER(4),
	 HIREDATE DATE,
	 SAL NUMBER(7,2),
	 COMM NUMBER(7,2),
	 DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
select * from emp;

 -- �޿� ���̺� �����ϱ�
CREATE TABLE SALGRADE(
	 GRADE NUMBER,
	 LOSAL NUMBER,
	 HISAL NUMBER );

-- ��� ���̺� ���� ������ �߰��ϱ�
INSERT INTO DEPT VALUES(10, '�渮��', '����');
INSERT INTO DEPT VALUES(20, '�λ��', '��õ');
INSERT INTO DEPT VALUES(30, '������', '����'); 
INSERT INTO DEPT VALUES(40, '�����', '����');

-- �μ� ���̺� ���� ������ �߰��ϱ�
INSERT INTO EMP VALUES(1001, '����', '���', 1013, to_date('2007-03-01','yyyy-mm-dd'), 300, NULL, 20);
INSERT INTO EMP VALUES(1002, '�ѿ���', '�븮', 1005, to_date('2007-04-02','yyyy-mm-dd'), 250,   80, 30);
INSERT INTO EMP VALUES(1003, '����ȣ', '����', 1005, to_date('2005-02-10','yyyy-mm-dd'), 500,  100, 30);
INSERT INTO EMP VALUES(1004, '�̺���', '����', 1008, to_date('2003-09-02','yyyy-mm-dd'), 600, NULL, 20);
INSERT INTO EMP VALUES(1005, '�ŵ���', '����', 1005, to_date('2005-04-07','yyyy-mm-dd'), 450,  200, 30);
INSERT INTO EMP VALUES(1006, '�嵿��', '����', 1008, to_date('2003-10-09','yyyy-mm-dd'), 480, NULL, 30);
INSERT INTO EMP VALUES(1007, '�̹���', '����', 1008, to_date('2004-01-08','yyyy-mm-dd'), 520, NULL, 10);
INSERT INTO EMP VALUES(1008, '���켺', '����', 1003, to_date('2004-03-08','yyyy-mm-dd'), 500,    0, 30);
INSERT INTO EMP VALUES(1009, '�ȼ���', '����', NULL, to_date('1996-10-04','yyyy-mm-dd'),1000, NULL, 20);
INSERT INTO EMP VALUES(1010, '�̺���', '����', 1003, to_date('2005-04-07','yyyy-mm-dd'), 500, NULL, 10);
INSERT INTO EMP VALUES(1011, '�����', '���', 1007, to_date('2007-03-01','yyyy-mm-dd'), 280, NULL, 30);
INSERT INTO EMP VALUES(1012, '������', '���', 1006, to_date('2007-08-09','yyyy-mm-dd'), 300, NULL, 20);
INSERT INTO EMP VALUES(1013, '������', '����', 1003, to_date('2002-10-09','yyyy-mm-dd'), 560, NULL, 20);
INSERT INTO EMP VALUES(1014, '���μ�', '���', 1006, to_date('2007-11-09','yyyy-mm-dd'), 250, NULL, 10);

-- �޿� ���̺� ���� ������ �߰��ϱ�
INSERT INTO SALGRADE VALUES (1, 901,1000);
INSERT INTO SALGRADE VALUES (2, 501,900);
INSERT INTO SALGRADE VALUES (3, 401,500);
INSERT INTO SALGRADE VALUES (4, 301,400);
INSERT INTO SALGRADE VALUES (5, 201,300);
COMMIT;

--2018.09.10�ǽ�
select * from emp;

select * from dept;

select * from salgrade;


select empno, ename from emp;
select ename, empno from emp;
select deptno, dname from dept;
select losal, hisal from SALGRADE;

select ename, sal from emp;

select * from emp;
select sal, sal * 12 as ���� from emp;
 

select ename, sal, sal + (sal * 0.1), sal*12 from emp;

--null�� ������ ����
select ename, sal*12, comm+1 from emp;
--nulló���� ���� nvl�Լ�! -> nvl(comm,0) null���� 0����
select ename, sal*12+comm, nvl(comm,0)+10 from emp;

--�÷��� ��Ī���� //as�� ���� �Ƚᵵ ��Ī�� ���������� ���������� ����ã�Ⱑ ����
--ex)ename as �����, ename "�����", ename �����, ename as "�����"
select ename "�����" , sal*12 as ����, sal*12+nvl(comm,0) as "�Ǳ޿�" from emp;

