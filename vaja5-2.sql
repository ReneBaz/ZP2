--5. Napi�ite poizvedbo, ki vrne seznam imen podjetji in njihovo mesto v rangu, �e jih rangirate
--glede na najvi�jo vrednost atributa TotalDue iz tabele SalesOrderHeader.
--Pri re�evanju si pomagajte s https://docs.microsoft.com/en-us/sql/t-sql/queries/select-groupby-transact-sql
select [CompanyName],TotalDue,
rank() over	(order by [TotalDue])
from[SalesLT].[Customer]
join [SalesLT].[SalesOrderHeader] on [SalesLT].[Customer].CustomerID=[SalesLT].[SalesOrderHeader].CustomerID;
--6. Napi�ite poizvedbo, ki izpi�e imena produktov in skupno vsoto izra�unano kot vsoto atributa
--LineTotal iz SalesOrderDetail tabele. Rezultat naj bo urejen po padajo�i vrednosti skupne
--vsote.
select [Name],sum(sl.LineTotal) as vsota from [SalesLT].[SalesOrderDetail] sl
join [SalesLT].[Product] p on sl.ProductID=p.ProductID
group by Name
order by vsota desc;
--7. Spremenite prej�njo poizvedbo tako, da vklju�uje samo tiste produkte, ki imajo atribut
--ListPrice ve� kot 1000$.
select [Name],sum(sl.LineTotal) as vsota from [SalesLT].[SalesOrderDetail] sl
join [SalesLT].[Product] p on sl.ProductID=p.ProductID
where ListPrice>1000
group by Name
order by vsota desc;
--8. Spremenite prej�njo poizvedbo, da bo vsebovala samo skupine, ki imajo skupno vrednost
--prodaje ve�jo kot 20.000$.
select [Name],sum(sl.LineTotal) as vsota from [SalesLT].[SalesOrderDetail] sl
join [SalesLT].[Product] p on sl.ProductID=p.ProductID
group by Name
having sum(sl.LineTotal)>20000
order by vsota desc;
