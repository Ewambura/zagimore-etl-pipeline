# Schema Design Decisions

## Dimensional Modeling
The warehouse follows a star-schema design with:
- RevenueFact at the transaction-product grain
- Conformed dimensions (Calendar, Store, Product, Customer)

## Slowly Changing Dimensions
Type-2 tracking columns (DVF, DVU, CurrentStatus) are included
in dimensions and snapshots to preserve historical context.

## Why Dimensions Are Not Staged
Dimensions are built directly in the warehouse because:
- Source data is clean and normalized
- No multi-source conflicts exist
- This keeps dimensions stable and persistent
