/* ============================================================
   DIMENSION: CalendarDimension
   Schema: wamburej_F25_ZAGIMORE_DW
   Purpose: Date dimension for analytics and key mapping
   ============================================================ */

DROP TABLE IF EXISTS wamburej_F25_ZAGIMORE_DW.CalendarDimension;

CREATE TABLE wamburej_F25_ZAGIMORE_DW.CalendarDimension AS
SELECT
    ROW_NUMBER() OVER (ORDER BY d.FullDate) AS CalendarKey,
    d.FullDate,
    EXTRACT(YEAR  FROM d.FullDate)          AS CalendarYear,
    EXTRACT(MONTH FROM d.FullDate)          AS CalendarMonth,
    EXTRACT(DAY   FROM d.FullDate)          AS CalendarDay
FROM (
    /* Build date set from both sales + rental transactions */
    SELECT DISTINCT tdate AS FullDate
    FROM wamburej_F25_ZAGIMORE.salestransaction
    UNION
    SELECT DISTINCT tdate AS FullDate
    FROM wamburej_F25_ZAGIMORE.rentaltransaction
) d;
