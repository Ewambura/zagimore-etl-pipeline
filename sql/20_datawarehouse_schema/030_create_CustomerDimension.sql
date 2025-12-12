/* ============================================================
   DIMENSION: CustomerDimension (Type 2 ready)
   Schema: wamburej_F25_ZAGIMORE_DW
   Purpose: Customer analytics with SCD tracking columns
   ============================================================ */

DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DW.CustomerDimension;

CREATE TABLE wamburej_F25_ZAGIMORE_DW.CustomerDimension AS
SELECT
    ROW_NUMBER() OVER (ORDER BY c.customerid) AS CustomerKey,
    c.customerid                               AS customerid,
    c.customername                             AS customername,
    c.customerzip                              AS customerzip,
    CURRENT_TIMESTAMP                          AS Extraction_time_stamp,
    1                                          AS F_loaded,
    CURRENT_DATE                               AS DVF,
    DATE '2030-01-01'                          AS DVU,
    1                                          AS CurrentStatus
FROM wamburej_F25_ZAGIMORE.customer c;
