
#SQL Scripts

-- No 1
select id from orders
where gloss_qty >40000 or poster_qty>4000

-- No 2
select * from orders
where standard_qty = 0 
and (gloss_qty >1000 or poster_qty > 1000)

-- No 3 
SELECT name 
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')  
AND 
    (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')  
AND 
    primary_poc NOT LIKE '%eana%'; 

 -- No 4 
SELECT r.name as Region_name,sr.name as Sales_rep_name,a.name as Account_name
FROM accounts as a 
INNER JOIN sales_reps AS sr 
    ON a.sales_rep_id = sr.id 
INNER JOIN region AS r 
    ON sr.region_id = r.id
ORDER BY Account_name asc