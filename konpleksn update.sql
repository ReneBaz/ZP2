select * from [Production].[BillOfMaterials]
where ProductAssemblyID=800;

with Parts(zbirID,KompID,NaDel,Level)as
(
select [ProductAssemblyID],[ComponentID],[PerAssemblyQty],0
from [Production].[BillOfMaterials]
where [ProductAssemblyID]=800 and EndDate is null
union all
select bom.ProductAssemblyID,bom.ComponentID,bom.PerAssemblyQty,Level+1
from [Production].[BillOfMaterials] as bom
join Parts p on bom.ProductAssemblyID=p.KompID
where EndDate is null
)

update [Production].[BillOfMaterials]
set [PerAssemblyQty]=2*[PerAssemblyQty]
where [ProductAssemblyID] in (select zbirID from Parts)