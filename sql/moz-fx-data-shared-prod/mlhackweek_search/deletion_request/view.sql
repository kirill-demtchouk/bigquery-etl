-- Generated by bigquery_etl.view.generate_stable_views
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mlhackweek_search.deletion_request`
AS
SELECT
  * REPLACE (
    mozfun.norm.metadata(metadata) AS metadata,
    mozfun.norm.glean_ping_info(ping_info) AS ping_info
  )
FROM
  `moz-fx-data-shared-prod.mlhackweek_search_stable.deletion_request_v1`