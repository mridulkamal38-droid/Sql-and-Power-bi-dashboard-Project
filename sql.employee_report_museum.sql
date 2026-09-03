create view employee_report as 
with employee_detail as (select 
employee_id,
first_name,
last_name,
concat(first_name,' ',last_name) as full_name,
email,
hire_date,
datediff(year,hire_date,getdate()) as total_year_work,
case when Gender = 'M' then 'Male'
     when Gender = 'F' then 'Female'
     else 'n/a'
end as Gender,
salary,
coffeeshop_id
from dbo.employees)


, employee_detail_2 as (
select
employee_id,
full_name,
coalesce(email,'Not Available') as email,
hire_date,
total_year_work,
Gender,
sum(salary) as Total_salary,
coffeeshop_id
from employee_detail
group  by employee_id,
full_name,
email,
total_year_work,
Gender,
coffeeshop_id,
hire_date)

,employee_detail_3 as (
select 
employee_id,
full_name,
email,
hire_date,
total_year_work,
case when total_year_work < 3 then 'New'
     when total_year_work between 3 and 6 then 'Established'
     when total_year_work between 7 and 12 then 'Experienced'
     when total_year_work between 13 and 18 then 'Long-term'
     else 'Legacy'
end employee_classification,
Gender,
total_salary,
case when total_salary < 20000 then 'low'
     when total_salary between 20000 and 34999 then 'below Average'
     when total_salary between 35000 and 49999 then 'Average'
     when total_salary between 50000 and 69999 then 'Above Average'
     else 'High'
end employee_salary_classification,
coffeeshop_id
from employee_detail_2)

select 
e.employee_id,
e.full_name,
e.coffeeshop_id,
s.coffeeshop_name,
l.city_id,
l.country,
l.city,
e.email,
e.total_year_work,
e.employee_classification,
e.Gender,
e.total_salary,
e.employee_salary_classification
from employee_detail_3 as e
left join dbo.shops as s
on e.coffeeshop_id = s.coffeeshop_id
left join dbo.locations as l
on s.city_id = l.city_id

