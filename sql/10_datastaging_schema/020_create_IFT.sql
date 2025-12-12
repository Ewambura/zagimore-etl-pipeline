
/* ============================================================
   STAGING TABLE: IFT (Intermediate Fact Table)
   Schema: wamburej_F25_ZAGIMORE_DS

   Grain:
   - One row per product per transaction per day

   Purpose:
   - Unifies sales and rental transactions
   - Serves as the base for RevenueFact and snapshots
   ============================================================ */

DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DS.IFT;

CREATE TABLE wamburej_F25_ZAGIMORE_DS.IFT AS

/* ======================
   SALES TRANSACTIONS
   ====================== */,

SELECT
    sv.noofitems                          AS UnitsSold,
    sv.noofitems * p.productprice         AS DollarsGenerated,
    st.tid                                AS TID,
    'Sales'                               AS RevenueType,
    sv.productid                          AS productid,
    st.customerid                         AS customerid,
    st.storeid                            AS storeid,
    st.tdate                              AS tdate
FROM wamburej_F25_ZAGIMORE.soldvia sv
JOIN wamburej_F25_ZAGIMORE.salestransaction st
    ON sv.tid = st.tid
JOIN wamburej_F25_ZAGIMORE.product p
    ON sv.productid = p.productid

UNION ALL

/* ======================
   RENTAL TRANSACTIONS
   ====================== */
SELECT
    rv.duration                                           AS UnitsSold,
    CASE
        WHEN rv.rentaltype = 'D'
            THEN rv.duration * rp.productpricedaily
        WHEN rv.rentaltype = 'W'
            THEN rv.duration * rp.productpriceweekly
    END                                                    AS DollarsGenerated,
    rt.tid                                                 AS TID,
    CASE
        WHEN rv.rentaltype = 'D' THEN 'Rental_daily'
        WHEN rv.rentaltype = 'W' THEN 'Rental_weekly'
    END                                                    AS RevenueType,
    rv.productid                                           AS productid,
    rt.customerid                                          AS customerid,
    rt.storeid                                             AS storeid,
    rt.tdate                                               AS tdate
FROM wamburej_F25_ZAGIMORE.rentvia rv
JOIN wamburej_F25_ZAGIMORE.rentaltransaction rt
    ON rv.tid = rt.tid
JOIN wamburej_F25_ZAGIMORE.rentalProducts rp
    ON rv.productid = rp.productid;
