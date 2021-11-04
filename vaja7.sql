--1. Izdelaj poizvedbo, ki bo vsebovala Id produkta, ime produkta in povzetek produkta (Summary) iz
--SalesLT.Product tabele in SalesLT.vProductModelCatalogDescription pogleda.
select p.ProductID,p.Name,
(select Summary from SalesLT.vProductModelCatalogDescription pw where pw.ProductModelID=p.ProductModelID ) from [SalesLT].[Product] p

--2. Izdelaj tabelarično spremenljivko in jo napolni s seznamom različnih barv iz tabele SalesLT.Product.
--Nato uporabi spremenljivko kot filter poizvedbe, ki vrača ID produkta, ime, barvo iz tabele
--SalesLT.Product in samo tiste izdelke, ki imajo barvo v zgoraj definirani začasni tabeli (rezultat
--vsebuje 245 vrstic)
create table #tmpBarve
(Color nvarchar(15))
insert into #tmpBarve select distinct Color from SalesLT.Product
select * from #tmpBarve;

select ProductID,Name,color from SalesLT.Product p where color in (select Color from #tmpBarve)
--pravilno
--nastavitev stre�nika
SELECT SERVERPROPERTY ('Collation') 
--nastavitev stolpcev v tabeli produktov
SELECT
    col.name, col.collation_name
FROM 
    sys.columns col
WHERE
    object_id = OBJECT_ID('Saleslt.product')
--obi�ajna temp tabela
create table #Barva3  (barva nvarchar(15))
Select * From tempdb.sys.columns Where object_id=OBJECT_ID('tempdb.dbo.#Barva3');
insert into #Barva3 select distinct color from [SalesLT].[Product]
select * from [SalesLT].[Product]
where color in (select barva from #barva3) --napaka
--ustvarimo tabelo tako, da ohranimo samo definicijo stolpca
select color as barva
into #Barva2
from Saleslt.product 
where 1=2; --pomeni, da se ne bo kopirala vsebina, ampak samo stolpec
Select * From tempdb.sys.columns Where object_id=OBJECT_ID('tempdb.dbo.#Barva2');
--test, da je prazna
select * from #Barva2
--napolnimo tabelo
insert into #Barva2 select distinct color from [SalesLT].[Product]
--deluje
select * from [SalesLT].[Product]
where color in (select barva from #barva2)



--3. Podatkovna baza AdventureWorksLT vsebuje funkcijo dbo.ufnGetAllCategories, ki vrača tabelo
--kategorij produktov (na primer 'Road Bikes') in roditeljske kategorije (na primer 'Bikes'). Napiši
--poizvedbo, ki uporablja to funkcijo in vrača seznam izdelkov, skupaj s kategorijo in roditeljsko
--kategorijo.
select * from [dbo].[ufnGetAllCategories]()

--4. Poišči seznam strank v obliki Company (Contact Name), skupni prihodki za vsako stranko. Uporabi
--izpeljano tabelo, da poiščeš naročila, nato pa naredi poizvedbo po izpeljani tabeli, da agregiraš in
--sumiraš podatke.

--5. Ista naloga kot prej, le da namesto izpeljane tabele uporabiš CTE
