## 查找入职员工时间排名倒数第三的员工
``` SQL
select * from employees where 
hire_date=(select distinct hire_date from employees oder by hire_date desc limit 2,1)
```

## 查找涨薪幅度超过15次的员工以及对应的涨薪次数t
``` SQL
select a.emp_no,count(*) t from
salaries a inner join salaries b on a.emp_no=b.emp_no
and a.to_date=b.from_date
where a.salary<b.salary
group by a.emp_no
having t>15
```

## 获取所有员工当前的经理，如果经理是自己的话不显示，当前表示 to_date='9999-01-01'
``` SQL
Select de.emp_no,dm.emp_no as manager_no
From
dept_emp de
Left join dept_manager dm on de.dept_no=dm.dept_no
Where 
de.to_date='9999-01-01'
and dm.to_date='9999-01-01'
and de.emp_no<>dm.emp_no
``` 
