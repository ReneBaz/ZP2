--1. Poi��i vse stranke iz tabele Customers
select [CustomerID],[FirstName],[LastName] from [SalesLT].[Customer]
--2. Izdelaj seznam strank, ki vsebuje ime kontakta, naziv, ime, srednje ime (�e ga kontakt ima),
--priimek in dodatek (�e ga kontakt ima) za vse stranke.
select [Title],[FirstName],[MiddleName],[LastName],[Suffix] from [SalesLT].[Customer]
--3. Iz tabele Customers izdelaj seznam, ki vsebuje:
--a. Prodajalca (SalesPerson)
--b. Stolpec z imenom �ImeStranke�, ki vsebuje priimek in naziv kontakta (na primer Mr
--Smith)
--c. Telefonsko �tevilko stranke
select [SalesPerson],[LastName]+' '+[Title] as ImeStranke,[Phone] from [SalesLT].[Customer]
--4. Izpi�i seznam vseh strank v obliki <Customer ID> : <Company Name> na primer 78: Preferred
--Bikes.
select cast([CustomerID] as nvarchar(10))+': '+[CompanyName] from [SalesLT].[Customer];
--5. Iz tabele SalesOrderHeader (vsebuje podatke o naro�ilih) izpi�i podatke
--a. �tevilka naro�ila v obliki <Order Number> (<Revision>) �na primer SO71774 (2).
--b. Datum naro�ila spremenjen v ANSI standarden format (yyy.mm.dd � na primer
--2015.01.31)
--Nekateri podatki v bazi manjkajo ali pa so vrnjeni kot NULL. Tvoja naloga je ustrezno obravnavati te
--podatke.
select cast([SalesOrderNumber] as nvarchar(10))+' ('+cast([RevisionNumber] as nvarchar(10))+')' from [SalesLT].[SalesOrderHeader]
--6. Ponovno je treba izpisati vse podatke o kontaktih, �e kontakt nima srednjega imena v obliki
--<first name> <last name>, �e ga pa ima <first name> <middle name> <last name> (na primer
--Keith Harris, Jane M. Gates)
select [FirstName]+' '+isnull([MiddleName],'')+' '+[LastName] from [SalesLT].[Customer]
--7. Stranka nam je posredovala e-mail nalov, telefon ali oboje. �e je dostopen e-mail, ga
--uporabimo za primarni kontakt, sicer uporabimo telefonsko �tevilko. Napi�i poizvedbo, ki
--vrne CustomerID in stolpec �PrimarniKontakt�, ki vsebuje e-mail ali telefonsko �tevilko. (v
--podatkovni bazi imajo vsi podatki e-mail. �e ho�e� preveriti ali poizvedba deluje pravilno
--najprej izvedi stavek
--UPDATE SalesLT.Customer
--SET EmailAddress = NULL
--WHERE CustomerID % 7 = 1;
select [CustomerID],isnull([EmailAddress], [Phone]) from [SalesLT].[Customer]
--8. Izdelaj poizvedbo, ki vra�a seznam naro�il (order ID), njihove datume in stolpec
--�StatusDobave�, ki vsebuje besedo �Dobavljeno� za vsa naro�ila, ki imajo znan datum
--dobave in ��aka� za vsa naro�ila brez datuma dobave. V bazi imajo vsa naro�ila datum
--dobave. �e �eli� preveriti, ali poizvedba deluje pravilno, predhodno izvedi stavek
--UPDATE SalesLT.SalesOrderHeader
--SET ShipDate = NULL
--WHERE SalesOrderID > 71899;
select [SalesOrderID],
				case  when [ShipDate] is not null then 'Dobavljeno'
					  else  '�aka'
					 end as tabela
				from [SalesLT].[SalesOrderHeader]