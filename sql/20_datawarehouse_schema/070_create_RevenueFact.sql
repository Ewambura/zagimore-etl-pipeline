/* ============================================================
   FACT TABLE: RevenueFact
   Schema: wamburej_F25_ZAGIMORE_DW

   Grain:
   - One row per product per transaction per day

   Source:
   - wamburej_F25_ZAGIMORE_DS.IFT

   Purpose:
   - Core analytical revenue fact table
   ============================================================ */

DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DW.RevenueFact;

CREATE TABLE wamburej_F25_ZAGIMORE_DW.RevenueFact AS
SELECT
    ROW_NUMBER() OVER ()                     AS RevenueFactKey,

    cd.CalendarKey                           AS CalendarKey,
    sd.StoreKey                              AS StoreKey,
    cust.CustomerKey                        AS CustomerKey,
    pd.ProductKey                           AS ProductKey,

    i.UnitsSold                              AS UnitsSold,
    i.DollarsGenerated                      AS RevenueGenerated,
    i.RevenueType                           AS RevenueType,

    CURRENT_TIMESTAMP                       AS Extraction_time_stamp,
    1                                       AS F_loaded

FROM wamburej_F25_ZAGIMORE_DS.IFT i

JOIN wamburej_F25_ZAGIMORE_DW.CalendarDimension cd
    ON i.tdate = cd.FullDate

JOIN wamburej_F25_ZAGIMORE_DW.StoreDimension sd
    ON i.storeid = sd.storeid
   AND sd.CurrentStatus = 1

JOIN wamburej_F25_ZAGIMORE_DW.CustomerDimension cust
    ON i.customerid = cust.customerid
   AND cust.CurrentStatus = 1

JOIN wamburej_F25_ZAGIMORE_DW.ProductDimension pd
    ON i.productid = pd.productid
   AND pd.CurrentStatus = 1;
