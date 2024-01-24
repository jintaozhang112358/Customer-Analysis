-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Table of Contents
-- MAGIC   
-- MAGIC * Understand Clusters 
-- MAGIC * Loss Diagnostics

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # Understand Clusters

-- COMMAND ----------

-- inspect cluster
select
  cluster,
  avg(days_since_last_order) as recency,
  avg(avg_num_orders_per_year) as frequency,
  avg(total_profit) as monetary,
  count(cust_id) as num_customers
from
  customers
group by
  1
order by
  monetary desc,
  frequency desc,
  recency

-- COMMAND ----------

-- give each cluster a name
select
  case
    when cluster = 3 then 'Profit Driver'
    when cluster = 0 then 'High Potential'
    when cluster = 1 then 'Medium Potential'
    when cluster = 4 then 'Low Potential'
    else 'Loss Maker'
  end as cluster_name,
  avg(days_since_last_order) as recency,
  avg(avg_num_orders_per_year) as frequency,
  avg(total_profit) as monetary,
  count(cust_id) as num_customers
from
  customers
group by
  1
order by
  monetary desc,
  frequency desc,
  recency

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - Profit Drivers
-- MAGIC   - highest profit 
-- MAGIC   - second highest purchasing frequency
-- MAGIC   - retention targets
-- MAGIC - High Potential
-- MAGIC   - highest purchasing frequency, 
-- MAGIC   - best recency
-- MAGIC   - second highest profit
-- MAGIC   - great potential to become profit drivers
-- MAGIC - Loss Makers
-- MAGIC   - customers to get rid of

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # Loss Diagnostics

-- COMMAND ----------

-- does return lead to loss
select
  ifnull(r.returned, 0) as returned,
  avg(o.profit) as average_profit
from
  orders o
  left join returns r on o.order_id = r.order_id
group by
  1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Returned orders don't appear to be loss-making.

-- COMMAND ----------

-- correlation between discount and profits
select
  round(corr(discount, profit), 2) as corr_discount_profit
from
  orders

-- COMMAND ----------

-- who used discounts
with temp as (
  select
    cust_id,
    case
      when cluster = 3 then 'Profit Driver'
      when cluster = 0 then 'High Potential'
      when cluster = 1 then 'Medium Potential'
      when cluster = 4 then 'Low Potential'
      else 'Loss Maker'
    end as cluster_name
  from
    customers
)
select
  t.cluster_name,
  avg(o.discount) as average_discount_applied
from
  orders o
  join temp t on o.customer_id = t.cust_id
group by
  1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC The amount of discounts applied have a negative correlation with profit, and Loss Makers tend to use more discounts, which implies ineffective promotion efforts.
