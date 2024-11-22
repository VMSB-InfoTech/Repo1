create table Bank (
ID INT primary key,
Bankname varchar(30) not null)
sp_help Bank;


 insert into Bank(ID,Bankname)
 values (01,'SBI')
  insert into Bank(ID,Bankname)
 values (02,'HDFC')
  insert into Bank(ID,Bankname)
 values (03,'AXIS')
  insert into Bank(ID,Bankname)
 values (04,'SBI')
  insert into Bank(ID,Bankname)
 values (05,'HDFC')
 insert into Bank(ID,Bankname)
 values (06,'AXIS')
 
 insert into Bank(ID,Bankname)
 values (07,'AXIS')
 
 select * from Bank

 create table Bankemp (
empID INT primary key,
Branchid int constraint Fk_Bankemp foreign key references Bank(id) not null,
empname varchar (50),
address varchar (50),
Designation varchar(30))

Sp_help 'Bankemp'


insert into Bankemp(empID,Branchid,empname,address,Designation)
values (01,03,'A','Neredmet','chasher')
insert into Bankemp(empID,Branchid,empname,address,Designation)
values (02,02,'B','Malkaj','Auditor')
insert into Bankemp(empID,Branchid,empname,address,Designation)
values (03,01,'C','Kukat','Finace')
insert into Bankemp(empID,Branchid,empname,address,Designation)
values (04,03,'D','Neredmet','Manager')
insert into Bankemp(empID,Branchid,empname,address,Designation)
values (05,02,'E','Kukat','Assmang')
insert into Bankemp(empID,Branchid,empname,address,Designation)
values (06,03,'F','Neredmet','Jnfina')

select * from Bankemp

create table Account(
Coustname varchar(50),
AccID bigint primary key,
Address varchar(30),
Isactive bit,
BranchID int constraint Fk_Account foreign key references Bank(id) not null )

sp_help 'Account'

select * from Account

insert into Account(Coustname,Accid,Address,Isactive,Branchid)
values ('A',1235008975,'Asrao',1,03)
insert into Account(Coustname,Accid,Address,Isactive,Branchid)
values ('B',1265019985,'Anand',0,02)
insert into Account(Coustname,Accid,Address,Isactive,Branchid)
values ('C',1324109999,'Kphb',1,01)
insert into Account(Coustname,Accid,Address,Isactive,Branchid)
values ('D',1234601975,'Rk',0,03)
insert into Account(Coustname,Accid,Address,Isactive,Branchid)
values ('E',132600987,'Baln',1,02)
insert into Account(Coustname,Accid,Address,Isactive,Branchid)
values ('F',123400789,'Vinayak',1,01)

select * from Account

Create table Transation(
TAccid bigint constraint Fk_Transation foreign key references Account(Accid) not null ,
TranDateTime datetime,
Frombank varchar(50),
Tobank varchar(50),
TranID int not null ,
Amount money)

Sp_help 'Transation'

select * from Transation

insert into Transation(TAccid,TranDateTime,Frombank,Tobank,TranID,Amount)
values (1235008975,'2020/08/25','Kukat','Neredmet',3,10000)

insert into Transation(TAccid,TranDateTime,Frombank,Tobank,TranID,Amount)
values (1265019985,'2023/03/22 04:00','Neredmet','Malkaj',1,30000)

insert into Transation(TAccid,TranDateTime,Frombank,Tobank,TranID,Amount)
values (1324109999,'2020/10/20 01:45pm','Malkaj','Kukat',5,50000)

insert into Transation(TAccid,TranDateTime,Frombank,Tobank,TranID,Amount)
values (1234601975,'2021/12/30 03:45pm','Neredmet','Malkaj',4,70000)

insert into Transation(TAccid,TranDateTime,Frombank,Tobank,TranID,Amount)
values (132600987,'2022/08/25 06:00pm','Kukat','Neredmet', 2,10658)

insert into Transation(TAccid,TranDateTime,Frombank,Tobank,TranID,Amount)
values (123400789,'2023/07/15 11:00am','Neredmet','Kukat',6,65435)


--1) Add default constraint for modifieddate for bank::
Alter table Bank 
add constraint DF_Bank_ModifiedDate default Getdate() for ModifiedDate

Alter table Bank
Add ModifiedDate datetime CONSTRAINT Def_ModifiedDate DEFAULT getdate() 

select * from Transation

--2) How many transations from single account::
select A.Accid,count(T.TranID) cnt from Account A
inner join Transation T on A.Accid=T.Accid
group by A.Accid

select B.ID,count(BE.empID) cnt from Bank B
inner join Bankemp BE on B.ID=BE.empID
group by B.ID


--3) How many emp are working in a bank::

--4)Add prefix to the account number::
Select left ('000000000000'+ISNULL(Accid,''),15) from Account
SELECT CONCAT('0', AccID) FROM Account;
-- 


select Bankname,Amount from Bank B
inner join  Account A on B.ID=A.BranchID
inner join Transation T on A.AccID=T.Accid

select Bankname,sum(Amount) as sum_Amt from Bank B
inner join  Account A on B.ID=A.BranchID
inner join Transation T on A.AccID=T.Accid
group by Bankname

select count(Bankname),Bankname from Bank
group by Bankname 
having count(Bankname)>1

select * from(
SELECT ROW_NUMBER() OVER(PARTITION BY  Bankname order by Bankname) Rno,Bankname from Bank)xx where Rno>1

select * from(
SELECT ROW_NUMBER() OVER(PARTITION BY  Bankname order by Bankname) Rno,Bankname from Bank)xx 

select * from(
SELECT ROW_NUMBER() OVER(PARTITION BY  Bankname order by Bankname) Rno,Bankname from Bank)xx where Rno=1


SELECT Bankname,row_number() OVER(PARTITION BY  id order by id) Rno,
rank() OVER(PARTITION BY  Bankname order by id) RN,
dense_rank() OVER(PARTITION BY  Bankname order by id) DR from Bank order by Rno



select * from Bank

select * from(
select  rank() OVER(order by Amount desc) Rno,* from Transation)xx
where rno=1

SELECT * FROM(
SELECT  Ntile(2) OVER(order by Amount desc) Rno,* from Transation)xx


Sp_help 'Bank'

select * from Bank 
select * from Bankemp
select * from Account
select * from Transation

select Accid from  Account 
select TranID from Transation

select count (ID) as numberofid from Bank

select count (Branchid) as numberofid from Account

select count (Accid) as numberofid from Transa

SELECT COUNT(FromBank) AS NumberOfProducts FROM Transa;






sp_help 'Transa'

Alter table Bankemp add constraint DF_Bankemp_ModifiedDate default Getdate() for ModifiedDate

Alter table <Table-name> add constraint <DF_Table-name> default 'Value1' for <column>


ALTER TABLE Bank
ADD CONSTRAINT Def_ModifiedDate DEFAULT getdate() 
		


