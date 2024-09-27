--EXPLORATORY DATA ANALYSIS
select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging

select * 
from layoffs_staging
where percentage_laid_off = '1'
order by funds_raised_millions desc

select company, sum(total_laid_off) as total_laid_off_sum
from layoffs_staging
group by company
order by 2 desc

select industry, sum(total_laid_off) as total_laid_off_sum
from layoffs_staging
group by industry
order by 2 desc

select country, sum(total_laid_off) as total_laid_off_sum
from layoffs_staging
group by country
order by 2 desc

select YEAR([date]), sum(total_laid_off) as total_laid_off_sum
from layoffs_staging
group by YEAR([date])
order by 1 desc

select company, year([date]), sum(total_laid_off)
from layoffs_staging
group by company, year([date])
order by 3 desc

with Company_Year (company, years, total_laid_off) as
(
select company, year([date]), sum(total_laid_off)
from layoffs_staging
group by company, year([date])
), Company_Year_Ranking as
(Select * , 
DENSE_RANK() over(partition by years order by total_laid_off desc) as Ranking
from Company_Year
where years is  not null
)
select *
from Company_Year_Ranking
where Ranking <=5
