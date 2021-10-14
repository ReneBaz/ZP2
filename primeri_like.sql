--where order by
select distinct Color from [SalesLT].[Product]

select productNumber, name, listprice from [SalesLT].[Product]
order by ProductNumber offset 100 rows
fetch next 10 rows only;

--operatorji primerjave <,>,<=,>=,=,!=,in,between,like,and,or,not
--like išèemo neke vzorce, beseda je, beseda se zaène na, beseda usebuje
--izpiši produkte katerih productnumber se zaène na fr
select ProductNumber, name, listprice from [SalesLT].[Product]
where ProductNumber like'FR%';--na tem mestu hocemo dolocene znake[0-9][A-Z]
--izpisi produkte kjer je product FR-_ dve stevki,_,-, še dve števki
select ProductNumber, name, listprice from [SalesLT].[Product]
where ProductNumber like'FR-_[0-9][0-9]_-[0-9][0-9]';
--nasledni znak nesme bit R [^R]
select ProductNumber, name, listprice from [SalesLT].[Product]
where ProductNumber like'BK-[^R]%';

--izberi produkte ki so v kategoriji 5, 6 ali 7;
select ProductCategoryID, ProductNumber, name, listprice from [SalesLT].[Product]
where ProductCategoryID in (5,6,7)
order by ProductCategoryID;