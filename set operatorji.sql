--1. Napiši poizvedbo, ki vraèa ime, prvo vrstico naslova, mesto in nov stolpec z imenom
--»TipNaslova« in vrednostjo »Za raèune« podjetja za vse stranke, ki imajo tip naslova v
--CustomerAddress tabeli enak 'Main Office'.
select c.CompanyName, a.AddressLine1,a.City,'Za raèune' as TipNaslova from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on ca.AddressID=a.AddressID
where ca.AddressType like 'Main Office';
--2. Napiši podobno poizvedbo (ime, prva vrstica naslova, mesto in stolpec »Tip naslova« z
--vrednostjo »Za dobavo«) za vse stranke, ki imajo tip naslova v CustomerAddress enak
--'Shipping'
select c.CompanyName, a.AddressLine1,a.City,'Za dobavo' as TipNaslova from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on ca.AddressID=a.AddressID
where ca.AddressType like 'Shipping';
--3. Kombiniraj oba rezultata v seznam, ki vrne vse naslove stranke urejene po strankah, nato po
--TipNalsova.
select c.CompanyName, a.AddressLine1,a.City,'Za raèune' as TipNaslova from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on ca.AddressID=a.AddressID
where ca.AddressType like 'Main Office'
union
select c.CompanyName, a.AddressLine1,a.City,'Za dobavo' as TipNaslova from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on ca.AddressID=a.AddressID
where ca.AddressType like 'Shipping'
order by c.CompanyName;
--4. Napiši poizvedbo, ki vrne imena podjetji, ki so med podjetji z 'Main office' naslovom, a
--nimajo 'Shipping' naslova.
select c.CompanyName, a.AddressLine1,a.City,'Za raèune' as TipNaslova from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on ca.AddressID=a.AddressID
where ca.AddressType like 'Main Office'
except
select c.CompanyName, a.AddressLine1,a.City,'Za dobavo' as TipNaslova from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on ca.AddressID=a.AddressID
where ca.AddressType like 'Shipping'
order by c.CompanyName;
--5. Napiši poizvedbo, ki vrne imena podjetji, ki so med podjetji z 'Main office' naslovomin hkrati
--med podjetji s 'Shipping' naslovom.
