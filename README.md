# Exploring Walmart’s Sales Data Through SQL

## Introduction
The Walmart Sales dataset serves as the focal point for this project, aimed at unraveling insights into sales trends, customer behavior, and optimization strategies within the retail giant’s operations. Derived from the Kaggle Walmart Sales Forecasting Competition, this dataset offers a treasure trove of historical sales data from three distinct branches located in Mandalay, Yangon, and Naypyitaw. As Walmart seeks to enhance its sales strategies and adapt to evolving market dynamics, this project endeavors to dissect the underlying factors influencing sales performance across different branches and product lines. By leveraging data-driven analyses, this endeavor aspires to equip stakeholders with actionable insights for informed decision-making in the realm of retail management and strategy.

## Data Overview
The dataset obtained from the Kaggle Walmart Sales Forecasting Competition comprises comprehensive sales transactions from three Walmart branches, each situated in diverse geographical regions: Mandalay, Yangon, and Naypyitaw. With 17 columns and 1000 meticulously curated rows, the dataset offers a detailed glimpse into various facets of retail operations. Key attributes such as invoice ID, branch location, customer type, product line and sales metrics including unit price, quantity and total cost form the backbone of the dataset. Additionally, the dataset encompasses essential temporal information such as the date and time of purchase, facilitating temporal analysis and trend identification. Each column’s data type, ranging from VARCHAR to DATETIME, ensures the integrity and interpretability of the dataset, laying the groundwork for robust analysis and insights generation.

## Sample dataset
![image](https://github.com/Orie05/Walmart_analysis/assets/149834782/6638eed3-f0a2-4fc7-97b9-c6b1efc70c10)


## Objective
The objectives of this project include:

Identifying top-performing branches and products within the dataset.
Analyzing sales trends of various products over time.
Understanding customer behavior and preferences based on the sales data.
Formulating strategies to improve and optimize sales performance.
By achieving these objectives, the project aims to provide insights that can guide the enhancement and optimization of sales strategies within the Walmart retail environment.

## Data Preprocessing
In the initial data preparation phase, we performed the following tasks:
- Data loading and inspection
- Checking for NULL values and missing data
- Data type conversion
- Addition of new columns: day of the week, month name, time of the day

### Dataset after preprocessing
![image](https://github.com/Orie05/Walmart_analysis/assets/149834782/aad90b0a-b2fd-4c59-8a7e-ed9d48076227)


## Exploratory Data Analysis (EDA)
EDA involved exploring the dataset to answer key questions

To simplify the analysis, these key questions were segmented into three:

i) product analysis:

ii) sales analysis

iii) customer analysis:

### Product Analysis
- How many unique product lines does the data have?
- What is the most common payment method?
- What is the most selling product line?
- What is the total revenue by month?
- What month had the largest COGS?
- What product line had the largest revenue?
- What is the city with the largest revenue?
- What product line had the largest VAT?
- Which branch sold more products than average product sold?
- What is the most common product line by gender?
- What is the average rating of each product line?

### Sales Analysis
- Number of sales made in each time of the day per weekday
- Which of the customer types brings the most revenue?
- Which city has the largest tax percent/ VAT (**Value Added Tax**)?
- Which customer type pays the most in VAT?
  
### Customer Analysis
- How many unique customer types does the data have?
- How many unique payment methods does the data have?
- What is the most common customer type?
- What is the gender of most of the customers?
- What is the gender distribution per branch?
- Which time of the day do customers give most ratings?
- Which time of the day do customers give most ratings per branch?
- To find out the time of the day our service is usually top-notch per branch
- Which day of the week has the best average ratings?

### Revenue And Profit Calculations
- Total profit per branch

## Data Analysis
```sql
-- How many unique product lines does the data have?
SELECT COUNT(DISTINCT `Product line`)
FROM w_sales;
```

```sql
-- What is the most comman payment method?
SELECT Payment, COUNT(Payment) AS value
FROM w_sales
GROUP BY Payment
ORDER BY value desc;
```

```sql
-- What is the most selling product line
SELECT `Product line`, SUM(Quantity) AS Quantity
FROM w_sales
GROUP BY `Product line`
ORDER BY Quantity DESC;
```

```sql
-- Which customer type pays the most in VAT?
SELECT `Customer type`, AVG(`Tax 5%`) AS VAT
FROM w_sales
GROUP BY `Customer type`
ORDER BY VAT DESC;
```

```sql
-- What is the gender distribution per branch?
SELECT Branch, Gender, COUNT(*) AS COUNT
FROM w_sales
GROUP BY Gender, Branch
ORDER BY COUNT DESC;
```

```sql
-- Which time of the day do customers give most ratings per branch?
SELECT branch, time_of_day, COUNT(Rating) AS Rating_count
FROM w_sales
GROUP BY time_of_day, branch
ORDER BY Rating_count DESC;
```

```sql
-- Total profit per branch
SELECT branch, SUM(Total - COGS) AS Profit
FROM w_sales
GROUP BY branch
ORDER BY profit DESC;
```
For complete queries - [Click Here](https://github.com/Orie05/Walmart_analysis/blob/main/Walmart_sales.sql)

## Insights
- Ewallet emerges as the most prevalent payment method, likely due to its convenience and widespread adoption in digital transactions.
- Electronic accessories rank as the top-selling product line, underscoring consumer preferences for technology-related products.
- Naypyitaw showcases the highest revenue among the cities represented in the dataset. This suggests a strong economic presence and consumer demand in the Naypyitaw region, warranting potential investment and strategic focus from stakeholders.
- Fashion accessories and food and beverages emerge as the most common product lines for female consumers, while health and beauty and electronic accessories are preferred by male consumers. Understanding these gender-specific preferences can inform targeted marketing strategies and product promotions to maximize sales potential.
- Food and beverages receive the highest average rating among the product lines analyzed, suggesting high customer satisfaction levels.
- Sales are higher during the evenings.
- There are more member customers than normal
## Recommendations
- The company could focus its marketing efforts and promotions more heavily during the evening and adjust staffing levels to ensure sufficient coverage during peak evening hours to maximize sales opportunities.
- Understanding that sales are higher in the evening, the company could adjust inventory levels accordingly, ensuring popular products are adequately stocked during these times.
- The company should implement robust security measures to protect customers’ eWallet transactions, enhancing trust and confidence in using this payment method.
- Marketing efforts and loyalty programs should be tailored to further engage and retain member customers, while also considering strategies to attract and convert non-member customers into members.
- Capitalise on the popularity of electronic accessories by expanding product offerings in this category and ensuring sufficient inventory to meet customer demand.
