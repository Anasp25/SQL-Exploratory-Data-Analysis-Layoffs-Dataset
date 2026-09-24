-- Exploratory Data Analysis

select *
from layoffs_staging2 ; 

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2  ;

select *
from layoffs_staging2 
where percentage_laid_off = 1
order by total_laid_off desc ;

-- for finding highest number of layoffs

select company, sum(total_laid_off)
from layoffs_staging2
group by company 
order by 2 desc ;

select min(`date`), max(`date`)
from layoffs_staging2 ;

-- For finding  industry with the highest number of layoffs

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry 
order by 2 desc ;

-- For finding country with the highest number of layoffs

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc ;

-- year and month with highest layoffs

select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2 
where `date` is not null
group by `month` 
order by 1 desc;

select substring(`date`,1,4 ) as `Year` , sum(total_laid_off)
from layoffs_staging2
where `date` is not null
group by `Year`
order by 1 desc;

with company_year(Company,Years,Total_laid_off) as(
select company,year(`date`) as year, sum(total_laid_off) as Total_layoff
from layoffs_staging2
group by company, year(`date`)
), company_rank_year as (
select *, dense_rank() over(partition by years order by total_laid_off desc) as Ranking
from company_year
where years is not null
)
select *
from company_rank_year
where ranking <= 5 ;

