/* ============================================================
   DIMENSIONS: Product_cat_dimension and ProductDimension
   Schema: wamburej_F25_ZAGIMORE_DW
   ============================================================ */

-- -------------------------
-- Product Category Dimension
-- -------------------------
DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DW.Product_cat_dimension;

CREATE TABLE wamburej_F25_ZAGIMORE_DW.Product_cat_dimension AS
SELECT
    ROW_NUMBER() OVER (ORDER BY c.categoryid) AS Product_cat_Key,
    c.categoryid                              AS categoryid,
    c.categoryname                            AS categoryname,
    CURRENT_TIMESTAMP                         AS Extraction_time_stamp,
    1                                         AS F_loaded,
    CURRENT_DATE                              AS DVF,
    DATE '2030-01-01'                         AS DVU,
    1                                         AS CurrentStatus
FROM wamburej_F25_ZAGIMORE.category c;

-- -------------------------
-- Product Dimension
-- -------------------------
DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DW.ProductDimension;

CREATE TABLE wamburej_F25_ZAGIMORE_DW.ProductDimension AS
SELECT
    ROW_NUMBER() OVER (ORDER BY p.productid)  AS ProductKey,
    p.productid                                AS productid,
    p.productname                              AS productname,
    p.productprice                             AS SalesProductPrice,
    v.vendorid                                 AS VendorID,
    v.vendorname                               AS VendorName,
    c.categoryid                               AS CategoryID,
    c.categoryname                             AS CategoryName,
    NULL                                       AS RentalProductPriceDaily,
    NULL                                       AS RentalProductPriceWeekly,
    CURRENT_TIMESTAMP                          AS Extraction_time_stamp,
    1                                          AS F_loaded,
    CURRENT_DATE                               AS DVF,
    DATE '2030-01-01'                          AS DVU,
    1                                          AS CurrentStatus
FROM wamburej_F25_ZAGIMORE.product p
JOIN wamburej_F25_ZAGIMORE.vendor v
  ON p.vendorid = v.vendorid
JOIN wamburej_F25_ZAGIMORE.category c
  ON p.categoryid = c.categoryid;
