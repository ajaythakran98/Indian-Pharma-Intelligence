CREATE DATABASE A_Z_DRUG_DATASET;
CREATE TABLE `AZD` (
    `id` INT,
    `name` VARCHAR(100),
    `price`	DOUBLE,
    `Is_discontinued` VARCHAR(10),
    `manufacturer_name`	VARCHAR(200),
    `type`	VARCHAR(100),
    `pack_size_label` VARCHAR(200),
    `short_composition1` VARCHAR(200),
    `short_composition2` VARCHAR(200)
);

LOAD DATA LOCAL INFILE 'C:\A_Z_medicines_dataset_of_India.csv'
INTO TABLE AZD
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SHOW VARIABLES LIKE 'local_infile';
SELECT * FROM AZD;

-- BELOW TOP 10 HIGHEST PRICED MEDICINES IN INDIA
SELECT * 
FROM AZD 
ORDER BY PRICE DESC 
LIMIT 10;

-- BELOW TOP 3 HIGHEST PRICED MEDICINE | DRUG COMPOSITION | MANUFACTURERS | THIER PERCENTAGE
SELECT * 
FROM AZD 
ORDER BY PRICE DESC 
LIMIT 3;

SELECT 
  ROUND(
    (SELECT SUM(price) FROM (
        SELECT price 
        FROM AZD 
        ORDER BY price DESC 
        LIMIT 3
    ) AS top3) 
    / 
    (SELECT SUM(price) FROM (
        SELECT price 
        FROM AZD 
        ORDER BY price DESC 
        LIMIT 10
    ) AS top10) 
    * 100, 
    2
  ) AS top3_percent_of_top10;
-- The top 3 have 36.77% among top 10 drugs.
-- The top 3 most expensive medicines in the dataset are based on Ibrutinib, Atezolizumab, and Enzalutamide, which are all targeted therapies used in advanced cancer treatments. 
-- Ibrutinib (140mg) is a Bruton's tyrosine kinase (BTK) inhibitor used in treating blood cancers like chronic lymphocytic leukemia (CLL) and mantle cell lymphoma. Its dominance at the top of the price chart highlights the high value of precision oncology treatments.
-- Atezolizumab (60mg/ml) is an immunotherapy drug (PD-L1 inhibitor) used for non-small cell lung cancer and urothelial carcinoma. Its placement among the most expensive medicines reflects the rising adoption of checkpoint inhibitors in Indian oncology practice.
-- Enzalutamide (40mg) is an androgen receptor inhibitor used to treat metastatic castration-resistant prostate cancer. It represents the growing cost burden of hormonal therapies in prostate cancer care.

-- Together, these drugs do not belong to the commonly prescribed antibiotic or painkiller categories (like paracetamol or aceclofenac) but rather to the super-specialized cancer treatment segment, indicating a concentration of pharmaceutical value in rare, life-saving therapies.



