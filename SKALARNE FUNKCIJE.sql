--skalarne funkcije
--datumske year(datum), month(datum), day(datum)
select [orderDate], MONTH(OrderDate) from [SalesLT].[SalesOrderHeader]
where YEAR(OrderDate)=2008;
--datename(mm, datum) -mesec
select [orderDate], datename(dw,OrderDate) from [SalesLT].[SalesOrderHeader];
--datediff(yy,datum1,datum2)
select datediff(dd,[ShipDate],[DueDate])from[SalesLT].[SalesOrderHeader];
--funkcije za nize
--cocnad(niz1,niz2) isto ku +
--upper(niz), len(niz), left(niz,2) prva dva znaka, reverse(niz), substring(niz,zaèetek,dolžina)

--logicne funkcije
--isnumeric('101.99')=1  true
--iif(listprice>50,'visoko','nizko')
--choose(productCategorYID,'kolesa','component','ostalo')ena ali dva ali use drugo