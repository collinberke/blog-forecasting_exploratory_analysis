# Setup -------------------------------------------------------------------

library(tidyverse)
library(bigrquery)
library(glue)
bq_auth()

## Replace with the correct `project ID`
project_id <- 'your-google-project-id'

# Data export -------------------------------------------------------------

# More about the data can be found here: 
# https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset

sql_page_locations <- "
select 
    event_date,
    user_pseudo_id,
    event_name,
    key,
    value.string_value
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
CROSS JOIN UNNEST(event_params)
where 
   event_name = 'page_view' and 
   _TABLE_SUFFIX between '20201101' and '20211231' and 
   key = 'page_location'
"

ga4_pageviews <- bq_project_query(project_id, sql_page_locations) %>% 
  bq_table_download(page_size = 20000)




