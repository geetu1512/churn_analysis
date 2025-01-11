use bank;
select * from churn1;
# 1.Find the average balance for each country.

select avg(Balance),Geography from churn1 group by Geography;

# 2. Identify the top 3 customers with the highest estimated salary in France.

select Surname,Geography,EstimatedSalary from churn1 where Geography = 'France' order by EstimatedSalary desc limit 3;

# 3.Calculate the churn rate for customers with a credit score below 600.

SELECT 
    (COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(*) AS ChurnRate
FROM churn1
WHERE CreditScore < 600;

# 4.Find the average tenure for customers who have exited and those who have not

SELECT 
    CASE 
        WHEN Exited = 1 THEN 'Exited' 
        ELSE 'Not Exited' 
    END AS CustomerStatus, 
    AVG(Tenure) AS AvgTenure
FROM churn1
GROUP BY CustomerStatus;

# 5. Determine the percentage of customers who are active members in each country
select Geography,(count(case when IsActiveMember=1 then 1 end) *100 )/count(*) as ActiveMemberPercentage from churn1 group by Geography;


 # 6.Find the customers who have been with the bank for more than 5 years and have a balance greater than the average balance
 
 select Surname,Tenure ,Balance from churn1 where Tenure > 5 and Balance > (select avg(Balance) from churn1);

# 7.Calculate the average age of customers who have exited and those who have not.

select 
	case 
		 when Exited = 1 then 'exited'
		 else 'not exited'
    end as AvgAge ,
    avg(Age)
from churn1
group by AvgAge ;

# 8.Identify the gender with the highest average credit score
select Gender,avg(CreditScore) as highcrscore 
from churn1 
group by Gender
order by highcrscore desc 
limit 1;

# 9.Find the number of customers in each age group (e.g., 18-25, 26-35, 36-45, etc.).

select 
	case when Age between 18 and 25 then '18-25' 
		 when Age between 26 and 35 then '26-35'
         when Age between 36 and 45 then '36-45'
         else '46+'
	end as noc,
	count(*)
from churn1
group by noc ;

# 10.Calculate the churn rate for customers with a balance greater than the average balance

select 
	 (count(case when Exited=1 then 1 end)*100)/count(*) as chun
from churn1 
where Balance > (select avg(Balance) from churn1);
