## Dataset Information

- **Source**: Internal dataset "One_on_One_Collector_Review.csv"
- **Size**: 12,000 rows, 17 columns
- **Period**: 1 year of range 
- **Target**: collector_performance_category (High, Medium, Low)

#### Input Features

|Variable|Type|Description|
|---|---|---|
|total_debt|Numeric|Total debts to be collected|
|total_debt_payment_received|Numeric|Total payments received|
|communication_quality|Categorical|Communication quality (1-5)|problem_solving|Categorical|Problem-solving|ability (1-5)|transfer_day_diff|Numeric|Time span since the debt collector was assigned to the case. 5)|
|problem_solving|Categorical|Problem solving ability (1-5)|
|transfer_day_diff|Numeric|Time span from the time the debt collector is assigned until the case is closed|
|debtor_feedback|Categorical|feedback from the debtor regarding the debt collector (1- 5)|
|total_contact|Numeric|Number of contacts made|
|contact_connected|Numeric|Contacts that were successfully connected|
|call_to_PTP|Numeric|Number of contacts that led to a promise to pay|
|total_case|Numeric|Number of cases handled by debt collectors| debt collectors|
|total_case_closed|Numeric|Total cases completed by debt collectors|
|success_ratio|Numeric|Success ratio based on total cases closed compared to total cases|
|success_ratio_cat|Numeric|Category of success ratio|



