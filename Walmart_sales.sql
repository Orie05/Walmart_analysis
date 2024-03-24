SELECT * FROM walmart.`walmartsalesdata.csv`;

Rename table walmart.`walmartsalesdata.csv` TO w_sales;

-- Data cleaning
SELECT *
FROM w_sales;

   
-- Due to the type of business questions we want to achieve, we'll need to add new columns
-- Add the time_of_day column

SELECT time, (CASE
				WHEN `time` BETWEEN "00:00:00" AND "11:59:00" THEN "Morning"
				WHEN `time` BETWEEN "12:01:00" AND "15:59:00" THEN "Afternoon"
				ELSE "Evening"
			END) AS time_of_day
FROM w_sales;

-- Since We'll be using the time of the day for subsequent query and analysis, it would be better to have it as one of the columns. To achieve this, we use:
ALTER TABLE w_sales 
ADD COLUMN time_of_day VARCHAR(9);

-- To populate this new column
UPDATE w_sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "11:59:00" THEN "Morning"
		WHEN `time` BETWEEN "12:01:00" AND "15:59:00" THEN "Afternoon"
		ELSE "Evening"
		END
);


-- To add the day of week column
SELECT date, DAYNAME(date) AS day_of_week
FROM w_sales;

ALTER TABLE w_sales 
ADD COLUMN day_of_week VARCHAR(9);

UPDATE w_sales
SET day_of_week = DAYNAME(date);


-- We follow the same process to add the month_name column
SELECT date, MONTHNAME(date) AS Month
FROM w_sales;

ALTER TABLE w_sales 
ADD COLUMN Month VARCHAR(9);

UPDATE w_sales
SET Month = MONTHNAME(date);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------- Exploratory Data Analysis ----------------------------------------------------------------------------

-- How many unique cities does the data have?
SELECT DISTINCT city
FROM w_sales;

-- In which city is each branch?
SELECT DISTINCT city, branch
FROM w_sales;


-- How many unique product lines does the data have?
SELECT DISTINCT `Product line`
FROM w_sales;

-- What is the most comman payment method?
SELECT Payment, COUNT(Payment) AS value
FROM w_sales
GROUP BY Payment
ORDER BY value desc;


-- What is the most selling product line
SELECT `Product line`, SUM(Quantity) AS Quantity
FROM w_sales
GROUP BY `Product line`
ORDER BY Quantity DESC; 


-- What is the total revenue by month
SELECT Month, SUM(Total) as Revenue
FROM w_sales
GROUP BY Month
ORDER BY Revenue DESC;


-- What month had the largest COGS?
SELECT Month, SUM(cogs) as total_cogs
FROM w_sales
GROUP BY Month
ORDER BY total_cogs DESC;


-- What product line had the largest revenue?
SELECT `Product line`, SUM(total) as revenue
FROM w_sales
GROUP BY `Product line`
ORDER BY revenue DESC;

-- What is the city with the largest revenue?
SELECT City, SUM(Total) AS Revenue
FROM w_sales
GROUP BY City
ORDER BY Revenue DESC;


-- What product line had the largest VAT?
SELECT `Product line`, AVG(`Tax 5%`) AS VAT
FROM w_sales
GROUP BY `Product line`
ORDER BY VAT DESC;


-- Which branch sold more products than average product sold?
SELECT branch, SUM(Quantity) AS qty
FROM w_sales
GROUP BY branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM w_sales);


-- What is the most common product line by gender
SELECT Gender, `Product line`, COUNT(Gender) AS total
FROM w_sales
GROUP BY Gender, `Product line`
ORDER BY total DESC;

-- What is the average rating of each product line
SELECT `Product line`, ROUND(AVG(Rating), 3) AS avg_rating
FROM w_sales
GROUP BY `Product line`
ORDER BY avg_rating DESC;


-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT DISTINCT `Customer type`
FROM w_sales;

-- How many unique payment methods does the data have?
SELECT DISTINCT Payment
FROM w_sales;

-- What is the most common customer type?
SELECT `Customer type`, COUNT(`Customer type`) AS count
FROM w_sales 
GROUP BY `Customer type`
ORDER BY count;


-- Which customer type buys the most?
SELECT `Customer type`, COUNT(*) AS FREQ
FROM w_sales 
GROUP BY `Customer type`
ORDER BY FREQ DESC;


-- What is the gender of most of the customers?
SELECT Gender, COUNT(*) AS COUNT
FROM w_sales
GROUP BY Gender
ORDER BY COUNT DESC;

-- What is the gender distribution per branch?
SELECT Branch, Gender, COUNT(*) AS COUNT
FROM w_sales
GROUP BY Gender, Branch
ORDER BY COUNT DESC;
-- The males lead two branches, branches A and B. Leaving branch C to the females.

-- Which time of the day do customers give most ratings?
SELECT time_of_day, COUNT(Rating) AS Rating_count
FROM w_sales
GROUP BY time_of_day
ORDER BY Rating_count DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT branch, time_of_day, COUNT(Rating) AS Rating_count
FROM w_sales
GROUP BY time_of_day, branch
ORDER BY Rating_count DESC;

-- To find out the time of the day our services are usually top-notch per branch
SELECT branch, time_of_day, ROUND(AVG(Rating), 2) AS Rating_count
FROM w_sales
GROUP BY time_of_day, branch
ORDER BY Rating_count DESC;

-- Which day of the week has the best avg ratings?
SELECT day_of_week, ROUND(AVG(Rating), 2) AS Rating_count
FROM w_sales
GROUP BY day_of_week
ORDER BY Rating_count DESC;



-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 
SELECT time_of_day, COUNT(Quantity) AS COUNT
FROM w_sales
WHERE day_of_week = "Monday"
GROUP BY time_of_day
ORDER BY COUNT DESC;


-- Which of the customer types brings the most revenue?
SELECT `Customer type`, SUM(Total) as Revenue
FROM w_sales
GROUP BY `Customer type`
ORDER BY Revenue DESC;


-- Which city has the largest tax/VAT percent?
SELECT `City`, avg(`Tax 5%`) as TAX
FROM w_sales
GROUP BY `City`
ORDER BY TAX DESC;

-- Which customer type pays the most in VAT?
SELECT `Customer type`, AVG(`Tax 5%`) AS VAT
FROM w_sales
GROUP BY `Customer type`
ORDER BY VAT DESC;
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

SELECT branch, SUM(Total - COGS) AS Profit
FROM w_sales
GROUP BY branch
ORDER BY profit DESC; 