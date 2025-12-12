/* ============================================================
   SOURCE SCHEMA: wamburej_F25_ZAGIMORE
   Purpose: Raw operational (OLTP) tables for Zagimore
   No transformations or business logic applied
   ============================================================ */

-- =========================
-- Reference Tables
-- =========================

CREATE TABLE wamburej_F25_ZAGIMORE.vendor (
    vendorid CHAR(2) NOT NULL,
    vendorname VARCHAR(25) NOT NULL,
    PRIMARY KEY (vendorid)
);

CREATE TABLE wamburej_F25_ZAGIMORE.category (
    categoryid CHAR(2) NOT NULL,
    categoryname VARCHAR(25) NOT NULL,
    PRIMARY KEY (categoryid)
);

CREATE TABLE wamburej_F25_ZAGIMORE.region (
    regionid CHAR(1) NOT NULL,
    regionname VARCHAR(25) NOT NULL,
    PRIMARY KEY (regionid)
);

-- =========================
-- Core Entity Tables
-- =========================

CREATE TABLE wamburej_F25_ZAGIMORE.product (
    productid CHAR(3) NOT NULL,
    productname VARCHAR(25) NOT NULL,
    productprice NUMERIC(7,2) NOT NULL,
    vendorid CHAR(2) NOT NULL,
    categoryid CHAR(2) NOT NULL,
    PRIMARY KEY (productid),
    FOREIGN KEY (vendorid) REFERENCES wamburej_F25_ZAGIMORE.vendor(vendorid),
    FOREIGN KEY (categoryid) REFERENCES wamburej_F25_ZAGIMORE.category(categoryid)
);

CREATE TABLE wamburej_F25_ZAGIMORE.store (
    storeid VARCHAR(3) NOT NULL,
    storezip CHAR(5) NOT NULL,
    regionid CHAR(1) NOT NULL,
    PRIMARY KEY (storeid),
    FOREIGN KEY (regionid) REFERENCES wamburej_F25_ZAGIMORE.region(regionid)
);

CREATE TABLE wamburej_F25_ZAGIMORE.customer (
    customerid CHAR(7) NOT NULL,
    customername VARCHAR(15) NOT NULL,
    customerzip CHAR(5) NOT NULL,
    PRIMARY KEY (customerid)
);

-- =========================
-- Sales Transactions
-- =========================

CREATE TABLE wamburej_F25_ZAGIMORE.salestransaction (
    tid VARCHAR(8) NOT NULL,
    customerid CHAR(7) NOT NULL,
    storeid VARCHAR(3) NOT NULL,
    tdate DATE NOT NULL,
    PRIMARY KEY (tid),
    FOREIGN KEY (customerid) REFERENCES wamburej_F25_ZAGIMORE.customer(customerid),
    FOREIGN KEY (storeid) REFERENCES wamburej_F25_ZAGIMORE.store(storeid)
);

CREATE TABLE wamburej_F25_ZAGIMORE.soldvia (
    productid CHAR(3) NOT NULL,
    tid VARCHAR(8) NOT NULL,
    noofitems INT NOT NULL,
    PRIMARY KEY (productid, tid),
    FOREIGN KEY (productid) REFERENCES wamburej_F25_ZAGIMORE.product(productid),
    FOREIGN KEY (tid) REFERENCES wamburej_F25_ZAGIMORE.salestransaction(tid)
);

-- =========================
-- Rental Products & Transactions
-- =========================

CREATE TABLE wamburej_F25_ZAGIMORE.rentalProducts (
    productid CHAR(3) NOT NULL,
    productname VARCHAR(25) NOT NULL,
    vendorid CHAR(2) NOT NULL,
    categoryid CHAR(2) NOT NULL,
    productpricedaily NUMERIC(7,2) NOT NULL,
    productpriceweekly NUMERIC(7,2) NOT NULL,
    PRIMARY KEY (productid),
    FOREIGN KEY (vendorid) REFERENCES wamburej_F25_ZAGIMORE.vendor(vendorid),
    FOREIGN KEY (categoryid) REFERENCES wamburej_F25_ZAGIMORE.category(categoryid)
);

CREATE TABLE wamburej_F25_ZAGIMORE.rentaltransaction (
    tid VARCHAR(8) NOT NULL,
    customerid CHAR(7) NOT NULL,
    storeid VARCHAR(3) NOT NULL,
    tdate DATE NOT NULL,
    PRIMARY KEY (tid),
    FOREIGN KEY (customerid) REFERENCES wamburej_F25_ZAGIMORE.customer(customerid),
    FOREIGN KEY (storeid) REFERENCES wamburej_F25_ZAGIMORE.store(storeid)
);

CREATE TABLE wamburej_F25_ZAGIMORE.rentvia (
    productid CHAR(3) NOT NULL,
    tid VARCHAR(8) NOT NULL,
    rentaltype CHAR(1) NOT NULL,
    duration INT NOT NULL,
    PRIMARY KEY (productid, tid),
    FOREIGN KEY (productid) REFERENCES wamburej_F25_ZAGIMORE.rentalProducts(productid),
    FOREIGN KEY (tid) REFERENCES wamburej_F25_ZAGIMORE.rentaltransaction(tid)
);

