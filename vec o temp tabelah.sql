
CREATE TABLE #Temp(
	[BillOfMaterialsID] [int] IDENTITY(1,1) NOT NULL,
	[ProductAssemblyID] [int] NULL,
	[ComponentID] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[UnitMeasureCode] [nchar](3) NOT NULL,
	[BOMLevel] [smallint] NOT NULL,
	[PerAssemblyQty] [decimal](8, 2) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
	)
 set identity_insert #Temp on
 insert into #Temp ( [BillOfMaterialsID]
      ,[ProductAssemblyID]
      ,[ComponentID]
      ,[StartDate]
      ,[EndDate]
      ,[UnitMeasureCode]
      ,[BOMLevel]
      ,[PerAssemblyQty]
      ,[ModifiedDate]) select * from [Production].[BillOfMaterials];

--druge možnosti(nevem zakaj ne dela)
delete from #temp
 set identity_insert #Temp on
 insert into #Temp ( 
      [ProductAssemblyID]
      ,[ComponentID]
      ,[StartDate]
      ,[EndDate]
      ,[UnitMeasureCode]
      ,[BOMLevel]
      ,[PerAssemblyQty]
      ,[ModifiedDate]) select [ProductAssemblyID]
      ,[ComponentID]
      ,[StartDate]
      ,[EndDate]
      ,[UnitMeasureCode]
      ,[BOMLevel]
      ,[PerAssemblyQty]
      ,[ModifiedDate] from [Production].[BillOfMaterials];

--tretj moznost
CREATE TABLE #Temp1(
	[BillOfMaterialsID] [int] NOT NULL,
	[ProductAssemblyID] [int] NULL,
	[ComponentID] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[UnitMeasureCode] [nchar](3) NOT NULL,
	[BOMLevel] [smallint] NOT NULL,
	[PerAssemblyQty] [decimal](8, 2) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
	)
	insert into #Temp1 select * from [Production].[BillOfMaterials]


