# End-to-End Customer Analysis on Azure Cloud 

This is an End-to-End customer analysis project that consists of the following steps:
- **Data Ingestion**: Ingest data into Azure Data Lake Storage Gen2 using Azure Data Factory.
- **ETL**: Extract raw data from data lake, perform transformation on Azure Databricks, and load transformed data into Databricks Delta Lake.
- **Insight Generation**: Further analysis on processed data using SQL.
- **Data Visualization**: Visualize findings using Tableau.

Data Source: Superstore Sales data from [Tableau public sample data](https://public.tableau.com/app/learn/sample-data).

- See `ETL.ipynb` file in the ETL folder for the complete ETL logic and the PySpark code.
- See `Generate_Insights.sql` file for the complete SQL code.
- Click [here](https://public.tableau.com/views/CustomerAnalysisDashboard_17061314032960/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link) for the Tableau dashboard.
