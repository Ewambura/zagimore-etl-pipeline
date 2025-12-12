/* ============================================================
   STAGING TABLE: ETC (High Revenue Transaction Count)
   Schema: wamburej_F25_ZAGIMORE_DS

   Grain:
   - One row per store per day

   Business Rule:
   - A transaction is considered "high revenue" if
     total DollarsGenerated per TID > 100

   Purpose:
   - Feeds Daily_Store_Snapshot
   ============================================================ */

DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DS.ETC;

CREATE TABLE wamburej_F25_ZAGIMORE_DS.ETC AS
SELECT
    storeid,
    tdate,
    COUNT(*) AS high_revenue_tran_count
FROM (
    SELECT
        storeid,
        tdate,
        TID,
        SUM(DollarsGenerated) AS tran_revenue
    FROM wamburej_F25_ZAGIMORE_DS.IFT
    GROUP BY
        storeid,
        tdate,
        TID
) t
WHERE tran_revenue > 100
GROUP BY
    storeid,
    tdate;
