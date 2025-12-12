/* ============================================================
   VALIDATION & RECONCILIATION CHECKS
   Purpose: Verify ETL correctness across layers
   ============================================================ */

-- ============================================================
-- 1) ROW COUNT CHECKS
-- ============================================================

SELECT 'IFT rows' AS check_name, COUNT(*) AS row_count
FROM wamburej_F25_ZAGIMORE_DS.IFT

UNION ALL
SELECT 'RevenueFact rows', COUNT(*)
FROM wamburej_F25_ZAGIMORE_DW.RevenueFact

UNION ALL
SELECT 'Daily_Store_Snapshot rows', COUNT(*)
FROM wamburej_F25_ZAGIMORE_DW.Daily_Store_Snapshot;


-- ============================================================
-- 2) REVENUE RECONCILIATION (IFT vs RevenueFact)
-- ============================================================

SELECT
    'IFT Revenue' AS source,
    ROUND(SUM(DollarsGenerated), 2) AS total_revenue
FROM wamburej_F25_ZAGIMORE_DS.IFT

UNION ALL
SELECT
    'RevenueFact Revenue' AS source,
    ROUND(SUM(RevenueGenerated), 2) AS total_revenue
FROM wamburej_F25_ZAGIMORE_DW.RevenueFact;


-- ============================================================
-- 3) ORPHAN CHECKS (FACT ↔ DIMENSIONS)
-- ============================================================

-- Any RevenueFact rows without a valid Store?
SELECT COUNT(*) AS orphan_store_keys
FROM wamburej_F25_ZAGIMORE_DW.RevenueFact rf
LEFT JOIN wamburej_F25_ZAGIMORE_DW.StoreDimension sd
  ON rf.StoreKey = sd.StoreKey
WHERE sd.StoreKey IS NULL;

-- Any RevenueFact rows without a valid Product?
SELECT COUNT(*) AS orphan_product_keys
FROM wamburej_F25_ZAGIMORE_DW.RevenueFact rf
LEFT JOIN wamburej_F25_ZAGIMORE_DW.ProductDimension pd
  ON rf.ProductKey = pd.ProductKey
WHERE pd.ProductKey IS NULL;


-- ============================================================
-- 4) SNAPSHOT SANITY CHECKS
-- ============================================================

SELECT
    COUNT(*) AS rows_with_null_metrics
FROM wamburej_F25_ZAGIMORE_DW.Daily_Store_Snapshot
WHERE
    TotalUnitsSold IS NULL
    OR TotalRevenueGenerated IS NULL
    OR TotalNumberOfTransactions IS NULL;
