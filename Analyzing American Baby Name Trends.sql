SELECT * FROM nationalnames;
SELECT * FROM statenames;

-- what names have appeared in all years of our study period.
SELECT 
    Name, sum(Count) AS most_appared
FROM
    nationalnames
GROUP BY Name
ORDER BY most_appared DESC;

-- categorize each name into a popularity type (Classic, Semi-Classic, Semi-trendy and Trendy) based on how often they show up in our dataset.
SELECT 
    Name,
    sum(Count) AS most_appared,
    CASE
        WHEN COUNT(*) > 70 THEN 'Classic'
        WHEN COUNT(*) > 50 THEN 'Semi_Classic'
        WHEN COUNT(*) > 20 THEN 'Semi-trendy'
        WHEN COUNT(*) > 20 THEN 'Semi-trendy'
        ELSE 'Trendy'
    END AS 'popularity_type'
FROM
    nationalnames
GROUP BY Name;

-- filter to only the male names in our dataset and rank them based on the number of babies that have ever been given that name.
SELECT 
    nn.Name, sum(nn.Count) AS most_appared
FROM
    nationalnames nn
WHERE
    Gender = 'M'
GROUP BY nn.Name
ORDER BY most_appared DESC;

-- Top 10 popular female names of 1880 that ended in the letter A.
SELECT 
    Name, sum(Count) AS most_appared
FROM
    nationalnames
WHERE
    Gender = 'F' AND Year = 1880
        AND Name LIKE '%a'
GROUP BY Name
ORDER BY sum(Count) DESC;

-- explore the top male names in each year
SELECT 
    a.Year, a.Name, b.Count AS Count
FROM
    nationalnames AS a
        RIGHT JOIN
    (SELECT 
        Year, MAX(Count) AS Count
    FROM
        nationalnames
    WHERE
        Gender = 'M'
    GROUP BY Year) AS b ON a.Year = b.Year AND a.Count = b.Count
ORDER BY B.Year DESC;

-- which male name has been number one for the largest number of years
WITH TEMP AS (
    SELECT b.Year, a.Name, b.Max_Sum
    FROM nationalnames AS a 
    LEFT JOIN (
        SELECT Year, MAX(Count) AS Max_Sum 
        FROM nationalnames 
        WHERE Gender = 'M'
        GROUP BY Year
    ) AS b
    ON a.Year = b.Year AND a.Count = b.Max_Sum
)

SELECT Name, COUNT(*) AS Count_Top_Name 
FROM TEMP
GROUP BY Name
ORDER BY Count_Top_Name DESC;





