--DATA CLEANING
select * from layoffs

--1. Removing Duplicates
SELECT * INTO layoffs_staging
FROM layoffs
WHERE 1 = 0

Select * 
from layoffs_staging

Insert layoffs_staging
select * 
from layoffs

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off,[date] order by [date]) as Row_Num
from layoffs_staging

WITH duplicate_CTE as
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions, 
[date] order by [date]) as Row_Num 
from layoffs_staging
)
Select *
from duplicate_CTE 
where Row_num > 1

WITH duplicate_CTE as
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions, 
[date] order by [date]) as Row_Num 
from layoffs_staging
)
Delete
from duplicate_CTE 
where Row_num > 1


--2.Standardizing Data
Select company, TRIM(company)
from layoffs_staging

UPDATE layoffs_staging
SET company=TRIM(company)

Select *
from layoffs_staging
where industry like 'Crypto%'

UPDATE layoffs_staging
SET industry='Crypto'
where industry like 'Crypto%'

Select Distinct country
from layoffs_staging
order by 1

Select *
from layoffs_staging
where country like 'United States%'

UPDATE layoffs_staging
SET country='United States'
where country like 'United States%'

Select [date],
try_Convert (DATE, [date], 101) AS Converted_Date
from layoffs_staging

UPDATE layoffs_staging
SET [date]=try_Convert (DATE, [date], 101)

alter table layoffs_staging
alter column [date] DATE


--3.Removing or repopulating nulls
select t1.company, t1.industry, t2.company, t2.industry
from layoffs_staging as t1
join layoffs_staging as t2
on t1.company=t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null

UPDATE t1
SET t1.industry = t2.industry
FROM layoffs_staging AS t1
JOIN layoffs_staging AS t2
ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL

select * from layoffs_staging
