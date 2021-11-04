--Vstavi v tabelo SalesLT.Product produkt
insert into [SalesLT].[Product](Name,ProductNumber,StandardCost,ListPrice,ProductCategoryID,SellStartDate)
values('LED Lghts','LT-L246',2.56,12.99,37,GETDATE())
--Ko je produkt ustvarjen, preveri kakšna je identiteta zadnjega vstavljenega produkta.
--Pomagaj si s SELECT SCOPE_IDENTITY();
--Opomba : ProductNumber mora biti edinstven. Ker delamo vsi na isti podatkovni bazi,
--zamenjaj ime v LT-L123xxxx, kjer xxxx nadomestiš s prvimi èrkami priimka.
SELECT ProductNumber FROM [SalesLT].[Product];
SELECT SCOPE_IDENTITY() AS Zadnja_Dodana;
--2. Vstavi v SalesLT.ProductCategory kategorijo z lastnostjo ParentProductCategoryID = 4 z
--imenom (Name) 'Bells and Horns'. Kljuè v tabeli je identiteta. Nato vstavi v tabelo produktov
--(SalesLT.Product) še spodnje produkte.insert into [SalesLT].[ProductCategory]([ParentProductCategoryID],[Name])values(4,'Bells and Horns')--Novo identiteto, ki si jo ustvaril v tabeli SalesLT.ProductCategory lahko vstaviš v tabelo
--SalesLT.Product s pomoèjo IDENT_CURRENT('ime tabele'). Preveri ali so produkti pravilno
--vstavljeni tako, da zapišeš ustrezen SELECT stavek.
insert into [SalesLT].[Product](Name,ProductNumber,StandardCost,ListPrice,ProductCategoryID,SellStartDate)
values('Bicycle BellR','BB-RINGR', 2.47, 4.99 ,4,GETDATE()),
('Bicycle HornR','BB-PARPR', 1.29 ,3.75 ,4,getdate())
--3. Zvišaj ceno (ListPrice) vsem produktom iz SalesLT.Product v kategoriji »Bells and Horns« za
--10%.
		update  [SalesLT].[Product]
		set ListPrice=ListPrice*1.1
		where ProductCategoryID=4;

		select * from [SalesLT].[Product]
		where ProductCategoryID=37;
--4. Nastavi DiscountinueDate za vse produkte iz tabele SalesLT.Product v kategoriji luèi (ID
--kategorije je 37) na današnji datum, razen za luè, ki si jo dodal v toèki ena.
	update [SalesLT].[Product]
	set DiscontinuedDate=GETDATE()
	where ProductCategoryID=37 and Name!='LED Lghts'
--5. Izbriši produkte iz tabele SalesLT.Product v kategoriji »Bells and Horns«, nato pa izbriši tudi
--kategorijo »Bells and Horns« v tabeli SalesLT.ProductCategory
	select * from [SalesLT].[Product]
		where ProductCategoryID=4;

		delete from [SalesLT].[ProductCategory]
		where ProductCategoryID=4;