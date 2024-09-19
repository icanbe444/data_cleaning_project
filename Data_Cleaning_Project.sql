SELECT * FROM layoffs;
-- 1. Remove Duplicate
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove unused Columns

-- First Duplicate Table 

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;

SELECT * FROM layoffs_staging;

-- 1. Remove Duplicate
-- WE need to add a column with row number
-- the filter to see which has more than one row by creating a cte and querring it

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging 
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;

-- deleting the duplicates
-- created a new table adding the row_num colum
-- moved the data filtering the ones with more than one row into the new table then deleting the row_num column later
CREATE TABLE layoffs_staging2(
  company text,
  location text,
  industry text,
  total_laid_off int DEFAULT NULL,
  percentage_laid_off text,
  date text,
  stage text,
  country text,
  funds_raised_millions int DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;


SELECT * FROM layoffs_staging2
WHERE row_num >1 ;

DELETE 
FROM layoffs_staging2
WHERE row_num >1 ;


-- 2. Standardize the Data
UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT(industry) 
FROM layoffs_staging2;

SELECT * 
FROM layoffs_staging2
WHERE industry LIKE 'crypto%';


UPDATE layoffs_staging2
SET industry = 'crypto'
WHERE industry LIKE 'crypto%';

SELECT DISTINCT(country) 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';


-- Alternatively
SELECT DISTICT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT date, 
STR_TO_DATE(date, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET date = STR_TO_DATE(date, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN date DATE;

SELECT * from layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * from layoffs_staging2
WHERE industry IS NULL
OR industry = ' ';

-- changed all empty fields to NULL so it can easily replaced
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = ' ')
AND t2.industry IS NOT NULL;

-- Here we replaced empty industry with the data from filled from the rows with company entered
UPDATE  layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = ' ')
AND t2.industry IS NOT NULL;


-- We have to remove companies with no layoffs
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- Remove the row_number column 
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
