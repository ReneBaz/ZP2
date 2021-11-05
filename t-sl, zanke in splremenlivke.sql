--pisanje programov v T-sql
go
declare @barva nvarchar(25)
set @barva='red'
select * from [SalesLT].[Product]
where Color = @barva;
go

go
declare @barva nvarchar(25)
set @barva='red'
print @barva
go 5

--prijanje znotraj select stavka
declare @rezultat money
select @rezultat=max(TotalDue) from [SalesLT].[SalesOrderHeader]
print @rezultat

--vejitve
declare @barva nvarchar(25)='red'
if @barva is null
begin
select * from [SalesLT].[Product]
end
else
begin
select * from [SalesLT].[Product] where Color=@barva
end

print @@rowcount

--zanke
declare @kupecid int=1,@priimek nvarchar(25)
while @kupecid<=5
begin
	select @priimek = LastName from [SalesLT].[Customer]
	where CustomerID=@kupecid
	print @priimek
	set @kupecid += 1
end

--uporabljamo [AdventureWorks2019]
create procedure M1 as
select * from [HumanResources].[Shift]
exec m1

create procedure m2
@p varchar(50)='night'
as
select * from [HumanResources].[Shift] where name =@p
exec m2 -- @p='day' ce dodamo to spremenimo parameter

create procedure m3
@p varchar(50)='night', @s time
as
select * from [HumanResources].[Shift] where name =@p and StartTime=@s
exec m3  @s='6:00'
--izbris lahko v datotekah
create procedure m4
@vrh varchar(50) output
as
set @vrh = (select top 1 name from [HumanResources].[Shift])

declare @a nvarchar(60)
exec m4 @a output
print @a

