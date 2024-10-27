
--QUICK REVIEW OF THE RAW DATA
SELECT  *
FROM restaurant_data;

--1. WHAT IS THE AVERAGE SALE PRICE OF CUISINES

SELECT [Cuisine],
	   ROUND(AVG([Average Meal Price]),2)
	   AS [Avg Sale Price]
FROM restaurant_data
GROUP BY [Cuisine]
ORDER BY [Avg Sale Price] DESC;

--2. DOES LOCATION INFLUENCE THE AVERAGE SALE PRICE OF CUISINE

SELECT [location],[Cuisine],
	   ROUND(AVG([Average Meal Price]),2) 
	   AS [Avg Sale Price]
FROM restaurant_data
GROUP BY [Location],[Cuisine]
ORDER BY [Cuisine];

--3. WHICH CUISINE HAS THE HIGHEST AVERAGE REVENUE

SELECT [cuisine],
	   ROUND(AVG([revenue]),2) 
	   AS [Avg Revenue]
FROM restaurant_data
GROUP BY [Cuisine]
ORDER BY [Avg Revenue] DESC;

--4. WHICH LOCATION HAS THE HIGHEST AVERAGE REVENUE

SELECT [location],
	   ROUND(AVG([Revenue]),2) 
	   AS[Avg Revenue]
into [location]
FROM restaurant_data
GROUP BY [Location]
ORDER BY [Avg revenue] DESC;

--5. WHICH CUISINES DO PEOPLE PREFER TO BUY THE MOST

SELECT [cuisine],
	   SUM([Weekend Reservations])
	   AS [Total Weekend Reservations],
	   SUM([weekday reservations])
	   AS [Total Weekday Reservations],
	   SUM([Weekend Reservations]) +
	   SUM([weekday reservations])
	   AS [Total Reservations]
FROM restaurant_data
GROUP BY [Cuisine]
ORDER BY [total reservations] DESC;

--6. WHICH CUISINES DO PEOPLE PREFER TO BUY THE MOST BY UNIQUE LOCATION

SELECT [location],[Cuisine],
	   SUM([Weekend Reservations])
	   AS[Total Weekend Reservations],
	   SUM([weekday reservations])
	   AS [Total Weekday Reservations],
	   SUM([Weekend Reservations])+
	   SUM([weekday reservations])
	   AS [Total Reservations]
FROM restaurant_data
GROUP BY [Location],[Cuisine]
ORDER BY [total reservations] DESC, [Location];

--7. DOES PARKING AVAILABILITY INFLUENCE THE AVERAGE REVENUE

SELECT [Parking Availability],
	   ROUND(AVG([revenue]),2)
	   AS [Avg Revenue]
FROM restaurant_data
GROUP BY [Parking Availability]
ORDER BY [Avg Revenue];

--8. DOES SEATING RANGE INFLUENCE THE AVERAGE REVENUE MADE

WITH [seating capacity range] AS
(
SELECT 
	CASE
		WHEN [seating capacity] >= 30 AND [seating capacity] < 40 THEN '30-39'
		WHEN [seating capacity] >= 40 AND [Seating Capacity] < 50 THEN '40-49'
		WHEN [seating capacity] >= 50 AND [seating capacity] < 60 THEN '50-59'
		WHEN [seating capacity] >= 60 AND [Seating Capacity] < 70 THEN '60-69'
		WHEN [seating capacity] >= 70 AND [seating capacity] < 80 THEN '70-79'
		ELSE '80+' END AS [Seating Range],
		[Revenue]
FROM restaurant_data
GROUP BY [Seating Capacity],[Revenue]
)
SELECT [Seating Range],
	   ROUND(avg([Revenue]),2)
	   AS [Avg Revenue]
FROM [seating capacity range]
GROUP BY [Seating Range]
ORDER BY [Seating Range];

--9. DOES THE CHEFS YEARS OF EXPERIENCE INFLUENCE THE AVERAGE REVENUE
SELECT [Chef Experience Years],
	   ROUND(AVG([REVENUE]),2) 
	   AS [Avg Revenue]
into [chefs years]
FROM restaurant_data
GROUP BY [Chef Experience Years]
ORDER BY [Chef Experience Years]

--10. DOES THE MARKETING BUDGET ALLOCATED INFLUENCE REVENUE

WITH [range of markting budget] AS
(
SELECT
	CASE
		WHEN [Marketing Budget] >= 0000 AND [Marketing Budget] < 1000 THEN '0000-0999'
		WHEN [Marketing Budget] >= 1000 AND [Marketing Budget] < 2000 THEN '1000-1999'
		WHEN [Marketing Budget] >= 2000 AND [Marketing Budget] < 3000 THEN '2000-2999'
		WHEN [Marketing Budget] >= 3000 AND [Marketing Budget] < 4000 THEN '3000-3999'
		WHEN [Marketing Budget] >= 4000 AND [Marketing Budget] < 5000 THEN '4000-4999'
		WHEN [Marketing Budget] >= 5000 AND [Marketing Budget] < 6000 THEN '5000-5999'
		WHEN [Marketing Budget] >= 6000 AND [Marketing Budget] < 7000 THEN '6000-6999'
		WHEN [Marketing Budget] >= 7000 AND [Marketing Budget] < 8000 THEN '7000-7999'
		WHEN [Marketing Budget] >= 8000 AND [Marketing Budget] < 9000 THEN '8000-8999'
		ELSE '9000+' END AS [Budget Range],
		[revenue]
FROM restaurant_data
)
SELECT [Budget Range],
	   ROUND(AVG([revenue]),2)
	   AS [Avg Revenue]
FROM [range of markting budget]
GROUP BY [Budget Range]
ORDER BY [Budget Range]

--11. AVERAGE WEEKLY EXPECTED RESERVATIONS

SELECT [location],
	   AVG([Weekday Reservations]) +
	   AVG([Weekend Reservations]) 
	   AS [Total Reservations]
FROM restaurant_data
GROUP BY [Location]

--12. INFLUENCE OF THE AMOUNT OF FOLLOWERS ON AVERAGE REVENUE

WITH [range of social media followers] AS
(
SELECT
	CASE
		WHEN [Social Media Followers] >= 00000 AND [Social Media Followers] < 10000 THEN '00000-09999'
		WHEN [Social Media Followers] >= 10000 AND [Social Media Followers] < 20000 THEN '10000-19999'
		WHEN [Social Media Followers] >= 20000 AND [Social Media Followers] < 30000 THEN '20000-29999'
		WHEN [Social Media Followers] >= 30000 AND [Social Media Followers] < 40000 THEN '30000-39999'
		WHEN [Social Media Followers] >= 40000 AND [Social Media Followers] < 50000 THEN '40000-49999'
		WHEN [Social Media Followers] >= 50000 AND [Social Media Followers] < 60000 THEN '50000-59999'
		WHEN [Social Media Followers] >= 60000 AND [Social Media Followers] < 70000 THEN '60000-69999'
		WHEN [Social Media Followers] >= 70000 AND [Social Media Followers] < 80000 THEN '70000-79999'
		WHEN [Social Media Followers] >= 80000 AND [Social Media Followers] < 90000 THEN '80000-89999'
		WHEN [Social Media Followers] >= 90000 AND [Social Media Followers] < 100000 THEN '90000-99999'
		ELSE '100000+'
		END AS [followers range],
		[revenue]
FROM restaurant_data
)
SELECT [followers range],
	   ROUND(AVG([revenue]),2)
	   AS [Avg Revenue]
FROM [range of social media followers]
GROUP BY [followers range]
ORDER BY [followers range] desc;

