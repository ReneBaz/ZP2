--1. Imamo �e obstoje�e poro�ilo, ki vra�a vsote prodaj po country/region (USA; Zdru�eno
--kraljestvo) in po State/Province (England, California, Colorado,�). Poizvedba je

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY a.CountryRegion, a.StateProvince
ORDER BY a.CountryRegion, a.StateProvince;
--Popravi poizvedbo tako, da bo vsebovala �e delne vsote za country/region, poleg teh, ki jih
--imamo za state/province. Primer re�itve:
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY rollup (a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;--Spremeni poizvedbo tako, da bo vsebovala nov atribut Level, ki bo opisoval tip delne vsote.
--Primer re�itve:SELECT a.CountryRegion, a.StateProvince, iif(CountryRegion is NULL,'Total', 
iif(StateProvince is null,CountryRegion+' subtotal',StateProvince+' subtotal')) as Level, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY rollup (a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

--Raz�iri poizvedbo tako, da bo vsebovala tudi mesta

SELECT a.CountryRegion, a.StateProvince, a.City, iif(CountryRegion is NULL,'Total', 
iif(StateProvince is null,CountryRegion+' subtotal',City+' subtotal')) as Level, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY rollup (a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince;