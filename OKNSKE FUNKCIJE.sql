--okenske funkcije
--rank() razvrsti produkte po rankih veno uporabljaj z order by
select ProductID ,Name ,ListPrice,
rank() over (order by ListPrice desc)  
from [SalesLT].[Product]

select ProductID ,Name ,ListPrice,
dense_rank() over (order by ListPrice desc)  
from [SalesLT].[Product]
