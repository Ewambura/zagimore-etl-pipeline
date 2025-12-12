/* ============================================================
   STAGING TABLE: LR (Local Revenue)
   Schema: wamburej_F25_ZAGIMORE_DS

   Grain:
   - One row per store per day

   Purpose:
   - Aggregates local revenue from IFT
   - Feeds Daily_Store_Snapshot
   ============================================================ */

DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DS.LR;

CREATE TABLE wamburej_F25_ZAGIMORE_DS.LR AS
SELECT
    i.storeid                     AS storeid,
    i.tdate                       AS tdate,
    SUM(i.DollarsGenerated)       AS Local_Revenue
FROM wamburej_F25_ZAGIMORE_DS.IFT i
GROUP BY
    i.storeid,
    i.tdate;
