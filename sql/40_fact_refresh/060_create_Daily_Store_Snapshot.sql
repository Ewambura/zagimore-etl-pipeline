/* ============================================================
   DATA WAREHOUSE TABLE: Daily_Store_Snapshot
   Schema: wamburej_F25_ZAGIMORE_DW

   Grain:
   - One row per store per day

   Purpose:
   - Daily operational performance snapshot
   - Supports analytics and historical tracking
   ============================================================ */

DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DW.Daily_Store_Snapshot;

CREATE TABLE wamburej_F25_ZAGIMORE_DW.Daily_Store_Snapshot AS
SELECT
    ROW_NUMBER() OVER ()                     AS SnapshotKey,
    cd.CalendarKey                           AS CalendarKey,
    sd.StoreKey                              AS StoreKey,

    SUM(i.UnitsSold)                         AS TotalUnitsSold,
    SUM(i.DollarsGenerated)                  AS TotalRevenueGenerated,
    COUNT(DISTINCT i.TID)                    AS TotalNumberOfTransactions,
    AVG(i.DollarsGenerated)                  AS AverageRevenueGenerated,

    lr.Local_Revenue                         AS Local_Revenue,
    etc.high_revenue_tran_count              AS high_revenue_tran_count,

    CURRENT_TIMESTAMP                        AS Extraction_time_stamp,
    1                                        AS F_loaded,
    CURRENT_DATE                             AS DVF,
    DATE '2030-01-01'                        AS DVU,
    1                                        AS CurrentStatus

FROM wamburej_F25_ZAGIMORE_DS.IFT i

JOIN wamburej_F25_ZAGIMORE_DW.CalendarDimension cd
    ON i.tdate = cd.FullDate

JOIN wamburej_F25_ZAGIMORE_DW.StoreDimension sd
    ON i.storeid = sd.storeid
   AND sd.CurrentStatus = 1

LEFT JOIN wamburej_F25_ZAGIMORE_DS.LR lr
    ON i.storeid = lr.storeid
   AND i.tdate = lr.tdate

LEFT JOIN wamburej_F25_ZAGIMORE_DS.ETC etc
    ON i.storeid = etc.storeid
   AND i.tdate = etc.tdate

GROUP BY
    cd.CalendarKey,
    sd.StoreKey,
    lr.Local_Revenue,
    etc.high_revenue_tran_count;
