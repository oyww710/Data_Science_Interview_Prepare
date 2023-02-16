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

select * from purchase_info as a where purchase_quantity > (select avg(purchase_quantity) 
from purchase_info as b where a.category=b.catetgory group by category)

``` 

### Exists 妙用
``` SQL
Select * from house_price as P1
where exists
(select * from info P2
where P2.bedroom=2 and 
P1.bedroom=P2.bedroom)
``` 

### Union and Union All 区别

Union会去重 while Union All不去重
关于 Union 之后的排序，Order by要写到最后，因为是对最终结果排序

### Window functions 算平均值
``` SQL
--- 按照user_id分区，然后根据order_date排序，current_avg字段代表当前分区中起始位置到当前位置的order_price平均值。
SELECT
	*,
	ag(order_price) OVER (PARTITION BY user_id
ORDER BY
	order_date) AS current_age
FROM
	order_content
  
 --- 将当前行和它前面的两行划分为一个窗口 
  SELECT
	*,
	ag(order_price) OVER (
ORDER BY
	order_date ROWS 2 PRECEDING) AS current_avg
FROM
	order_content
 
 --- 将当前行和它前面一行至后面一行一共三行划为一个窗口
	SELECT
	*,
	avg(order_price) OVER (
ORDER BY
	order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS current_avg
FROM
	order_content 
  
```
