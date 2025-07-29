-- Find Athletes from Summer or Winter Games
-- Write a query to list all athlete names who participated in the Summer or Winter Olympics. 
-- Ensure no duplicates appear in the final table using a set theory clause.

(SELECT 
	athlete_id,
	name
FROM 
	summer_games
LEFT JOIN
	athletes
ON
	summer_games.athlete_id = athletes.id)
UNION
(SELECT 
	athlete_id,
	name
FROM 
	winter_games
LEFT JOIN 
	athletes
ON 
	winter_games.athlete_id = athletes.id);

-- Find Countries Participating in Both Games

-- Write a query to retrieve country_id and country_name for countries in the Summer Olympics.
-- Add a JOIN to include the country’s 2016 population and exclude the country_id from the SELECT statement.
-- Repeat the process for the Winter Olympics.
-- Use a set theory clause to combine the results.

--Summer Olympics
SELECT
	country_id,
	country
FROM 
	summer_games
LEFT JOIN
	countries
	ON 
	summer_games.country_id = countries.id;

--Summer Olympics with population data
SELECT
	DISTINCT country,
	country_stats.pop_in_millions AS population_2016
FROM 
	summer_games
INNER JOIN
	countries
	ON 
	summer_games.country_id = countries.id
LEFT JOIN
	country_stats
	ON 
	countries.id = country_stats.country_id 
	AND 
	country_stats.year = '2016-01-01';

--Winter Olympics with population data
SELECT
	DISTINCT country,
	country_stats.pop_in_millions AS population_2016
FROM 
	winter_games
INNER JOIN
	countries
	ON 
	winter_games.country_id = countries.id
LEFT JOIN
	country_stats
	ON 
	countries.id = country_stats.country_id 
	AND 
	country_stats.year = '2016-01-01';

--Combined Summer and Winter Olympics 
SELECT
	DISTINCT country,
	country_stats.pop_in_millions AS population_2016
FROM 
	summer_games
INNER JOIN
	countries
	ON 
	summer_games.country_id = countries.id
LEFT JOIN
	country_stats
	ON 
	countries.id = country_stats.country_id 
	AND 
	country_stats.year = '2016-01-01'
UNION
SELECT
	DISTINCT country,
	country_stats.pop_in_millions AS population_2016
FROM 
	winter_games
INNER JOIN
	countries
	ON 
	winter_games.country_id = countries.id
LEFT JOIN
	country_stats
	ON 
	countries.id = country_stats.country_id 
	AND 
	country_stats.year = '2016-01-01';

--Testing validity of the results above. Result is zero mean all the Winter countries are also in Summer countries
SELECT DISTINCT
  c.country
FROM winter_games wg
JOIN countries c ON wg.country_id = c.id
EXCEPT
SELECT DISTINCT
  c.country
FROM summer_games sg
JOIN countries c ON sg.country_id = c.id;


-- Identify Countries Exclusive to the Summer Olympics
-- Return the country_name and region for countries present in the countries table but not in the winter_games table.
-- (Hint: Use a set theory clause where the top query doesn’t involve a JOIN, but the bottom query does.)

SELECT
	country,
	region
FROM 
	countries
EXCEPT
SELECT
	country,
	region
FROM
	countries
JOIN
	winter_games
	ON countries.id = winter_games.country_id;