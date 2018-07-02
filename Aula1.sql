USE data_analysis;

DELIMITER $$

CREATE TRIGGER insert_trigger 
AFTER INSERT ON data_analysis.sales 
FOR EACH ROW 
BEGIN
	DECLARE new_district VARCHAR(45);
    DECLARE new_brand_name VARCHAR(45);
    DECLARE new_sales DOUBLE;
    DECLARE new_month INT unsigned DEFAULT 1;
    DECLARE new_year INT unsigned DEFAULT 1;
    DECLARE new_quantity INT unsigned DEFAULT 1;
    DECLARE new_unitary_cost INT unsigned DEFAULT 1;
    
    SELECT quantity FROM sales INTO new_quantity;
    
    SELECT unitary_cost FROM sales INTO new_unitary_cost;
    
    SET new_sales = new_quantity * new_unitary_cost;
    
    SELECT t2.month
		FROM sales AS t1 INNER JOIN date AS t2 ON t1.Date_idDate = t2.idDate INTO new_month;
        
	SELECT t2.year
		FROM sales AS t1 INNER JOIN date AS t2 ON t1.Date_idDate = t2.idDate INTO new_year;
        
	SELECT t2.District
		FROM sales AS t1 INNER JOIN postalcode AS t2 ON t1.PostalCode_idPostalCode = t2.idPostalCode INTO new_district;
    
	INSERT INTO sales_activity (idSales_Activity, district, brand_name, sales, month, year) 
    VALUES (NEW.idSales_Activity, new_district, new_brand_name, new_sales, new_month, new_year);
END;

DELIMITER $$