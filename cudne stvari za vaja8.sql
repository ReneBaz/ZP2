select country, region,sum(sales) from [dbo].[Sales]
group by rollup(country, region)

select country, region,sum(sales) from [dbo].[Sales]
group by cube(country, region)

select country,sum(sales) from [dbo].[Sales]
group by grouping sets(country,())

select
iif(GROUPING_ID(Country)=1 and GROUPING_ID(region)=1,'Vse skupaj',
iif(grouping_id(region)=1,'Skupaj'+Country,region)),
sum(sales)
from sales
group by rollup(country, region)