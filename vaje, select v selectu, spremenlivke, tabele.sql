--3. Poi��i ID produkta, ime in ceno produkta (list price) in proizvodno ceno (standardcost) za vsak
--produkt skupaj s povpre�no ceno, po kateri je bil produkt prodan.
select [ProductID],[Name],[ListPrice],[StandardCost],(select avg([UnitPrice])from [SalesLT].[SalesOrderDetail] sod where sod.ProductID=p.ProductID) as [Povpre�na cena] from [SalesLT].[Product] p;
--4. Filtriraj prej�njo poizvedbo, da bo vsebovala samo produkte, kjer je cena proizvodnje (cost
--price) ve�ja od povpre�ne prodajne cene.
select [ProductID],[Name],[ListPrice],[StandardCost],
(select avg([UnitPrice])from [SalesLT].[SalesOrderDetail] sod where sod.ProductID=p.ProductID) as [Povpre�na cena] 
from [SalesLT].[Product] p
where StandardCost>(select avg([UnitPrice])from [SalesLT].[SalesOrderDetail] sod where sod.ProductID=p.ProductID);


--5. Poi��i ID naro�ila, ID stranke, Ime in priimek stranke in znesek dolga za vsa naro�ila v
--SalesLT.SalesOrderHeader s pomo�jo funkcije dbo.ufnGetCustomerInformation
select soh.SalesOrderID,soh.CustomerID,soh.TotalDue, ci.FirstName, ci.LastName from [SalesLT].[SalesOrderHeader] soh
cross apply [dbo].[ufnGetCustomerInformation](soh.CustomerID) ci
--6. Poi��i ID stranke, Ime in priimek stranke, naslov in mesto iz tabele SalesLT.Address in iz
--tabele SalesLT.CustomerAddress s pomo�jo funkcije dbo.ufnGetCustomerInformation
select sa.CustomerID,ci.FirstName,ci.LastName,a.AddressLine1, a.City from [SalesLT].[Address] a
join [SalesLT].[CustomerAddress] sa on sa.AddressID=a.AddressID
cross apply [dbo].[ufnGetCustomerInformation](sa.CustomerID) ci
order by LastName;

--view
create view Nov as
select sa.CustomerID,ci.FirstName,ci.LastName,a.AddressLine1, a.City from [SalesLT].[Address] a
join [SalesLT].[CustomerAddress] sa on sa.AddressID=a.AddressID
cross apply [dbo].[ufnGetCustomerInformation](sa.CustomerID) ci;

select FirstName from [dbo].[Nov]

--Spremenljivke
--go
declare @moj�tevec int;
declare @Priimek nvarchar(30), @ime nvarchar(30);
set @moj�tevec = 1;
set @Priimek = N'BlaBla';
print @moj�tevec;
print @Priimek;
--go(ni potreben, je samo da prevajalnik ve kje se bach za�ne in kon�a)


--Tabela kot spremenljivka
declare @varProdukti as table
(Id int,Ime nvarchar(50))
insert into @varProdukti select ProductID, Name from [SalesLT].[Product]
select * from @varProdukti;

--za�asna tabela(velja v okviru 1 seje, se zbrise ce naredis nov query dokument) in globalna tabela(ziva za vse seje)
create table #tmpProdukti
(Id int,Ime nvarchar(50))
insert into #tmpProdukti select ProductID, Name from [SalesLT].[Product]
select * from #tmpProdukti;
--globalna(dokr se ne zpre pogram)
create table ##tmpProdukti
(Id int,Ime nvarchar(50))
insert into ##tmpProdukti select ProductID, Name from [SalesLT].[Product]
select * from ##tmpProdukti;

--izpeljana tabela
select  leto,COUNT(distinct id) from
(select YEAR(orderdate) as leto, customerID from [SalesLT].[SalesOrderHeader]) as izpeljana(leto,id) 
group by leto;


--nimam pojma kaj je to samo vem da ne dela
with DirectReport (ManagerID,EmployeeID,Title,EmployeeLevel) as
(
select ManagerID,EmployeeID,Title,0 from [dbo].[MyEmployees]
where ManagerID is null
union all
select e.ManagerID,e.EmployeeID,e.Title,EmployeeLevel+1 from [dbo].[MyEmployees] e
join DirectReport as d on e.ManagerID =d.ManagerID
)
select * from DirectReport order by ManagerID;