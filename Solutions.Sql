-- Netflix Project

Drop table if exists netflix;
Create table Netflix
( 
  show_id Varchar(10),
  type	  varchar(10),
  title   Varchar(200),
  director	varchar(210),
  casts      Varchar(1000),
  country	Varchar(150),
  date_added	Varchar(50),
  release_year	Int,
  rating  Varchar(10),
  duration	Varchar(15),
  listed_in	Varchar(150),
  description Varchar(250)
);

Select * from netflix;

Select count(*) as total_count
from netflix;


select 
      distinct type
	  from netflix;


Select * from netflix;

-- 15 Business Pe]romblem

-- 1. Count the number of Movies vs TV Shows

Select 
      type,
	  count(*) as total_contrnt
from netflix
group by type;

-- 2. Find the most common rating for movies and TV 
select
      type,
	  rating
from

(
Select 
      type,
	  rating,
	  count(*),
	  rank() over (partition by type order by count(*) desc) as ranking
from netflix
group by 1,2
) as t1
where ranking =1;

-- 3. List all movies released in a specific year (e.g., 2020)

Select *
from netflix
where type ='Movie' 
and 
release_year = '2020';

-- 4. Find the top 5 countries with the most content on Netflix

select 
      UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
      count(show_id) as total_content 
from netflix
Group by 1 
order by 2 desc
limit 5 ;

-- 5. Identify the longest movie

SELECT * From Netflix
where 
      type = 'Movie'
	  AND
	  Duration =(select max(duration) from Netflix);
	  
-- 6. Find content added in the last 5 years

SELECT
     *
FROM netflix
Where
     To_date(date_added,'Month DD,YYYY') >= CURRENT_DATE - INTERVAL '5 Years';

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT 
     TYPE,
	 Title,
	 director
from netflix
where director ILIKE '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons

SELECT *
FROM netflix
where type = 'TV Show'
AND
Split_part(duration,' ',1)::numeric > 5;

-- 9. Count the number of content items in each genre

SELECT 
      unnest(STRING_TO_ARRAY(listed_in, ',')) as genre,
	  count(show_id) as total_content
FROM Netflix
Group by 1;

-- 10.Find each year and the average numbers of content release in India on netflix. 
-- return top 5 year with highest avg content release!

SELECT 
	country,
	release_year,
	COUNT(show_id) as total_release,
	ROUND(
		COUNT(show_id)::numeric/
								(SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100 
		,2
		)
		as avg_release
FROM netflix
WHERE country = 'India' 
GROUP BY country, 2
ORDER BY avg_release DESC 
LIMIT 5

-- 11. List all movies that are documentaries

Select 
      title,
	  type,
	  listed_in
from netflix
where type like 'Movie'
and
listed_in ilike '%Documentaries%';

-- 12. Find all content without a director

Select * from netflix
where director is null;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT
     *
FROM netflix
Where
	 casts like '%Salman khan%'
	 AND
	 release_year > Extract(year from current_date)-10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actors,
	COUNT(*) as total_content
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

SELECT 
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2;






