--1. Iz tabele Address izberi vsa mesta in province, odstrani duplikate. (atributi City,
--Province)
select distinct [City],[StateProvince] from [SalesLT].[Address];

--2. Iz tabele Product izberi 10% najte�jih produktov (izpi�i atribut Name, te�a je v
--atributu Weight)
select top 10 percent [Name],[Weight] from [SalesLT].[Product]
order by Weight desc;
--3. Iz tabele Product izberi najte�jih 100 produktov, izpusti prvih 10 najte�jih.
select [Name],[Weight] from [SalesLT].[Product]
order by Weight desc
offset 10 rows
fetch next 100 rows only;
--4. Poi��i ime, barvo in velikost produkta, kjer ima model produkta ID 1. (atributi Name,
--Color, Size in ProductModelID)
select [Name],[Color],[Size] from [SalesLT].[Product]
where [ProductModelID] = 1;
--5. Poi��i �tevilko produkta in ime vseh izdelkov, ki imajo barvo 'black', 'red' ali 'white' in
--velikost 'S' ali 'M'. (Izpi�i ProductNumber, primerjaj Color in Size)
select [ProductID],[Name] from [SalesLT].[Product]
where Color in ('white','black','red') and Size in ('S','M');
--6. Poi��i �tevilko produktov, ime in ceno produktov, katerih �tevilka se za�ne na BK-.
--(atributi ProductNumber, Name, ListPrice, primerjaj ProductNumer)
select ProductNumber, Name, ListPrice from [SalesLT].[Product]
where ProductNumber like 'BK-%';
--7. Spremeni prej�njo poizvedbo tako, da bo� iskal produkte, ki se za�nejo na 'BK-' sledi
--katerikoli znak razen R in se kon�ajo na ��dve �tevki�. (atributi ProductNumber,
--Name, ListPrice, primerjaj ProductNumer, primer: BK-F1234J-11)
select ProductNumber, Name, ListPrice from [SalesLT].[Product]
where ProductNumber like 'BK-[^R]%[0-9][0-9]';