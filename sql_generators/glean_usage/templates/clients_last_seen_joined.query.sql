WITH baseline AS (
  SELECT 
    *
  FROM 
    `{{ project_id }}.{{ app_name }}.baseline_clients_last_seen` 
  WHERE 
    submission_date = @submission_date
),
metrics AS (
  SELECT 
    * 
  FROM 
    `{{ project_id }}.{{ app_name }}.metrics_clients_last_seen`
  WHERE 
    submission_date = DATE_ADD(@submission_date, INTERVAL 1 DAY)
)
SELECT 
  baseline.client_id,
  baseline.sample_id,
  baseline.submission_date, 
  baseline.normalized_channel,
  * EXCEPT(submission_date, normalized_channel, client_id, sample_id) 
FROM
  baseline 
LEFT JOIN metrics
ON baseline.client_id = metrics.client_id AND
  baseline.sample_id = metrics.sample_id AND
  (
    baseline.normalized_channel = metrics.normalized_channel OR
    (baseline.normalized_channel IS NULL AND metrics.normalized_channel IS NULL)
  )
