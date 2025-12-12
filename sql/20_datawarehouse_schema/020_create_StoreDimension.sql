/* ============================================================
   DIMENSION: StoreDimension
   Schema: wamburej_F25_ZAGIMORE_DW
   Purpose: Store + Region denormalized dimension (Type 1)
   ============================================================ */

DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DW.StoreDimension;

CREATE TABLE wamburej_F25_ZAGIMORE_DW.StoreDimension AS
SELECT
    ROW_NUMBER() OVER (ORDER BY s.storeid)  AS StoreKey,
    s.storeid                               AS storeid,
    s.storezip                              AS storezip,
    s.regionid                              AS regionid,
    r.regionname                            AS regionname,
    CURRENT_TIMESTAMP                       AS Extraction_time_stamp,
    1                                       AS F_loaded,
    CURRENT_DATE                            AS DVF,
    DATE '2030-01-01'                       AS DVU,
    1                                       AS CurrentStatus
FROM wamburej_F25_ZAGIMORE.store s
JOIN wamburej_F25_ZAGIMORE.region r
  ON s.regionid = r.regionid;
