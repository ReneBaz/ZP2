--1. Izdelati mora� poro�ilo o ra�unih. V prvem koraku izdelaj poizvedbo, ki vrne ime podjetja
--(CompanyName) iz tabele Customer , poleg tega pa �e ID naro�ila (salesOrderID) in skupni
--dolg (total due) iz atbele SalesOrderHeader.
select c.CompanyName,s.[SalesOrderID],s.[TotalDue] from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] s on c.CustomerID=s.CustomerID;
--2. Raz�iri poizvedbo tako, da doda� �e naslov �Main Office� za vsakega kupca (naslov ulice,
--mesto, dr�avo/provinco, po�tno �tevilko in regijo). Pri tem upo�tevaj, da ima vsaka stranka
--ve� naslovov v tabeli Address. Zato je na�rtovalec PB ustvaril �e tabelo CustomerAddress, da
--je re�il povezavo M:N. Poizvedba mora vsebovati obe tabeli in mora filtrirati priklju�eno
--tabelo CustomerAddress, tako da vzame samo naslov �Main Office�.
select c.CompanyName,s.[SalesOrderID],s.[TotalDue], a.AddressLine1,a.City,a.StateProvince,a.PostalCode,a.CountryRegion from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] s on c.CustomerID=s.CustomerID
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on ca.AddressID=a.AddressID
where ca.AddressType like 'Main Office';
--3. Izdelaj seznam vseh podjetji in kontaktov (ime in priimek), ki vsebuje tudi ID naro�ila
--in skupni dolg. Seznam mora vsebovati tudi kupce, ki niso �e ni�esar naro�ili na koncu
--seznama.
select c.FirstName,c.LastName,c.CompanyName,s.SalesOrderID,s.TotalDue from [SalesLT].[Customer] c
left outer join [SalesLT].[SalesOrderHeader] s on c.CustomerID=s.CustomerID
order by SalesOrderID desc;
--4. Izdelaj seznam vseh kupcev, ki nimajo podatkov o naslovu. V seznamu naj bo
--CustomerID, ime podjetja, ime kontakta in telefonska �tevilka vseh, ki nimajo
--podatkov o naslovu.
select c.CustomerID,c.CompanyName,c.SalesPerson,c.Phone, ca.AddressID from[SalesLT].[Customer] c
left outer join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
where AddressID is null;
--5. Radi bi ugotovili katere stranke �e nikoli niso naro�ile in kateri produkti �e nikoli niso
--bili naro�eni. V ta namen izdelaj poizvedbo, ki vra�a CustomerID za vse stranke, ki
--niso �e ni�esar naro�ile in stolpec productID za vse izdelke, ki �e niso bili naro�eni.
--Vsaka vrstica z ID-jem stranke ima pri ProductID NULL, vsak ProductID vrstica ima
--CustomerID NULL.
select c.CustomerID,c.FirstName,c.LastName, p.ProductID, p.name from [SalesLT].[Customer] c
full outer join [SalesLT].[SalesOrderHeader] sh on c.CustomerID=sh.CustomerID
full outer join [SalesLT].[SalesOrderDetail] sd on sh.SalesOrderID=sd.SalesOrderID
full outer join [SalesLT].[Product] p on sd.ProductID=p.ProductID
where c.CustomerID is null or p.ProductID is null;