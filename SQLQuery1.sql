--id naslova, prvo vrstico 12 Cankarjeva 5 --stolpec z imenom naslov 
select cast([AddressID] as nvarchar(5))+' '+[AddressLine1] as naslov from[SalesLT].[Address];

select convert( nvarchar(5), [AddressID])+' '+[AddressLine1] as naslov from[SalesLT].[Address];
--izisi ime pa datum zacetka prodaje in datum konca prodaje iz tabele produkt
select [Name],convert(nvarchar,[SellStartDate],104),isnull(convert(nvarchar,[SellEndDate], 104),'V prodaji') from [SalesLT].[Product];
select [Color] from [SalesLT].[Product]
select nullif(Color,'Black') from [SalesLT].[Product]

select CONVERT(decimal(5,3), 12.34)

select name,
		case when size='S' then 'Small'
			 when size='M' then 'Medium'
			 when size='L' then 'Large'
		else isnull(size, 'Ni podatka')
		end as Velikost,
		Color
		from [SalesLT].[Product]