--1. Izdelati moraš poroèilo o raèunih. V prvem koraku izdelaj poizvedbo, ki vrne ime podjetja
--(CompanyName) iz tabele Customer , poleg tega pa še ID naroèila (salesOrderID) in skupni
--dolg (total due) iz atbele SalesOrderHeader.
select c.CompanyName,s.[SalesOrderID],s.[TotalDue] from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] s on c.CustomerID=s.CustomerID;
--2. Razširi poizvedbo tako, da dodaš še naslov »Main Office« za vsakega kupca (naslov ulice,
--mesto, državo/provinco, poštno številko in regijo). Pri tem upoštevaj, da ima vsaka stranka
--veè naslovov v tabeli Address. Zato je naèrtovalec PB ustvaril še tabelo CustomerAddress, da
--je rešil povezavo M:N. Poizvedba mora vsebovati obe tabeli in mora filtrirati prikljuèeno
--tabelo CustomerAddress, tako da vzame samo naslov »Main Office«.
select c.CompanyName,s.[SalesOrderID],s.[TotalDue], a.AddressLine1,a.City,a.StateProvince,a.PostalCode,a.CountryRegion from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] s on c.CustomerID=s.CustomerID
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on ca.AddressID=a.AddressID
where ca.AddressType like 'Main Office';
--3. Izdelaj seznam vseh podjetji in kontaktov (ime in priimek), ki vsebuje tudi ID naroèila
--in skupni dolg. Seznam mora vsebovati tudi kupce, ki niso še nièesar naroèili na koncu
--seznama.
select c.FirstName,c.LastName,c.CompanyName,s.SalesOrderID,s.TotalDue from [SalesLT].[Customer] c
left outer join [SalesLT].[SalesOrderHeader] s on c.CustomerID=s.CustomerID
order by SalesOrderID desc;
--4. Izdelaj seznam vseh kupcev, ki nimajo podatkov o naslovu. V seznamu naj bo
--CustomerID, ime podjetja, ime kontakta in telefonska številka vseh, ki nimajo
--podatkov o naslovu.
select c.CustomerID,c.CompanyName,c.SalesPerson,c.Phone, ca.AddressID from[SalesLT].[Customer] c
left outer join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
where AddressID is null;
--5. Radi bi ugotovili katere stranke še nikoli niso naroèile in kateri produkti še nikoli niso
--bili naroèeni. V ta namen izdelaj poizvedbo, ki vraèa CustomerID za vse stranke, ki
--niso še nièesar naroèile in stolpec productID za vse izdelke, ki še niso bili naroèeni.
--Vsaka vrstica z ID-jem stranke ima pri ProductID NULL, vsak ProductID vrstica ima
--CustomerID NULL.
select c.CustomerID,c.FirstName,c.LastName, p.ProductID, p.name from [SalesLT].[Customer] c
full outer join [SalesLT].[SalesOrderHeader] sh on c.CustomerID=sh.CustomerID
full outer join [SalesLT].[SalesOrderDetail] sd on sh.SalesOrderID=sd.SalesOrderID
full outer join [SalesLT].[Product] p on sd.ProductID=p.ProductID
where c.CustomerID is null or p.ProductID is null;