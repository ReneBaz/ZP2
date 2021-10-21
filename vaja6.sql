--Pri reševanju si pomagajte s spletno stranjo https://technet.microsoft.com/library/ms189575.aspx
--1. Poišèi ID produkta, ime in ceno produkta (list price) za vsak produkt, kje je cena produkta
--veèja od povpreène cene na enoto (unit price) za vse produkte, ki smo jih prodali
select ProductID, Name, ListPrice from [SalesLT].[Product]
where ListPrice > (select avg(ListPrice) from [SalesLT].[Product]);
--2. Poišèi ID produkta, ime in ceno produkta (list price) za vsak produkt, kjer je cena (list) 100$ ali
--veè in je bil produkt prodan (unit price) za manj kot 100$.
select p.ProductID, p.Name, p.ListPrice from [SalesLT].[Product] p
where ListPrice >= 100 AND ProductID in (select ProductID from [SalesLT].[SalesOrderDetail] where UnitPrice<100);
--3. Poišèi ID produkta, ime in ceno produkta (list price) in proizvodno ceno (standardcost) za vsak
--produkt skupaj s povpreèno ceno, po kateri je bil produkt prodan.
select ProductID, p.Name, ListPrice, StandardCost,
(select avg(s.UnitPrice) from [SalesLT].[SalesOrderDetail] s
where s.ProductID=p.ProductID ) as PovprecnaProdajalnaCena
from [SalesLT].[Product] p
--4. Filtriraj prejšnjo poizvedbo, da bo vsebovala samo produkte, kjer je cena proizvodnje (cost
--price) veèja od povpreène prodajne cene.
--Pri reševanju si pomagaj z naslovom https://technet.microsoft.com/library/ms175156.aspx
select ProductID, p.Name, ListPrice, StandardCost,
(select avg(s.UnitPrice) from [SalesLT].[SalesOrderDetail] s
where s.ProductID=p.ProductID ) as PovprecnaProdajalnaCena
from [SalesLT].[Product] p
where p.StandardCost>(select avg(s.UnitPrice) from [SalesLT].[SalesOrderDetail] s
where s.ProductID=p.ProductID)
--5. Poišèi ID naroèila, ID stranke, Ime in priimek stranke in znesek dolga za vsa naroèila v
--SalesLT.SalesOrderHeader s pomoèjo funkcije dbo.ufnGetCustomerInformation

--6. Poišèi ID stranke, Ime in priimek stranke, naslov in mesto iz tabele SalesLT.Address in iz
--tabele SalesLT.CustomerAddress s pomoèjo funkcije dbo.ufnGetCustomerInformation