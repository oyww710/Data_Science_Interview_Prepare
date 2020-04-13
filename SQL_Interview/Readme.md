# SQL Interviews

### Order和limit一起用可以做比如找第二第三高工资的题

order by 排序不稳定，如果有相同值出现会有问题

``` SQL
limit x,y
``` 
x是开始的位置（从0开始，y是从x起走几个）

``` SQL
Select * from house_price order by price Desc
Limit 2,1
``` 
实际上是找第三row的位置

### 正则表达式匹配

``` SQL
Select * from Dta where X Regexp '^/$/.'
``` 

### 关联子查询

``` SQL
Select neighbor,bedroom from house_price as P1 
where price>(select avg(price) from house_price as P2 
where P1.bedroom=P2.bedroom group by bedroom)

``` 

### Exists 妙用
``` SQL
Select * from house_price as P1
where exists
(select * from info P2
where P2.bedroom=2 and 
P1.bedroom=P2.bedroom)
``` 
