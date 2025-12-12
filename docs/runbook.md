# ETL Runbook

## Execution Order
Scripts must be executed in numeric order by folder.

## Reruns
- Staging scripts are idempotent and can be rerun safely
- Dimensions and facts should be refreshed after staging

## Validation
Always run validation checks after loading facts and snapshots.
Revenue totals must reconcile between staging and warehouse.
