USE data_analysis;

DECLARE new_month VARCHAR(45);

SELECT t2.month FROM sales AS t1 
	INNER JOIN date AS t2 ON t1.Date_idDate = t2.idDate INTO new_month