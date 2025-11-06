### 1. Data Type Correction

**Objective**: Ensure accurate data types, particularly for date columns.

**Actions Taken**:

- Converted `month` column from integer to datetime format
- Applied transformation: `pd.to_datetime(df['month'].astype(str) + '-01-2024', format='%m-%d-%Y')`

**Results**:

- Successfully converted month column to datetime64[ns]
- All other data types validated as appropriate

### 2. Missing Values and Invalid Input Detection

**Validation Rules Applied**:

1. **Payment Validation**: `total_debt_payment_received > total_debt`
2. **Transfer Day Validation**: `transfer_day_diff > 31`
3. **Case Closure Validation**: `total_case_closed > total_case`

**Results**:

- **Payment Anomalies**: 0 cases found
- **Invalid Transfer Days**: 0 cases found
- **Case Closure Issues**: 0 cases found
- **Missing Values**: 0 missing values detected across all columns

### 3. Duplicate ID Collector Analysis

**Issue Identified**: 43 collectors had more than 12 months of data (ranging from 24 to 36 records)

**Root Cause**: System error resulting in duplicate monthly entries for certain collectors

**Solution Implemented**:

- Applied `groupby('id_collector').tail(12)` to retain only the last 12 records per collector
- **Rationale**: Based on stakeholder consultation, this approach ensures the most recent and relevant data is preserved

**Impact**:

- **Records Removed**: 540 records (4.5% of original dataset)
- **Final Result**: All collectors now have exactly 12 monthly records
- **Data Integrity**: Maintained chronological consistency

### 4. Categorical Data Validation

**Categories Validated**:

**Communication Quality**: 5 levels

- Sangat Baik, Baik, Cukup, Kurang Memuaskan, Buruk

**Problem Solving**: 5 levels

- Sangat Baik, Baik, Cukup, Kurang Memuaskan, Buruk

**Debtor Feedback**: 5 levels

- Sangat Baik, Baik, Cukup, Kurang Memuaskan, Buruk

**Success Ratio Category**: 3 levels

- High, Medium, Low

**Collector Performance Category**: 3 levels

- High, Medium, Low

**Results**:

- No duplicate categories or inconsistent spelling found
- All categorical variables properly standardized

### 5. Duplicate Row Detection

**Methodology**: Used `df.duplicated()` to identify exact duplicate records

**Results**:

- **Duplicate Rows Found**: 0
- **Action Required**: None

### 6. Outlier Detection and Treatment

#### 6.1 Initial Outlier Assessment

**Approach**: Generated box plots for all numerical variables to identify extreme values

**Variables with Significant Outliers Identified**:

- `call_to_ptp`
- `total_contact`
- `contact_connected`
- `success_ratio`

#### 6.2 Contextual Outlier Analysis

**Methodology**: Conducted contextual outlier detection by analyzing variables within the context of `collector_performance_category`

**Rationale**: Since the project aims to identify performance differences, outliers were evaluated within their categorical context to preserve meaningful patterns while removing genuine anomalies.

![image alt](https://github.com/najeep24/debt-collector-performance-analysis/blob/7e2394fca9f54d3ee7f5a74d554476b1579be82f/data/before-contextual-outlier.png)

In the boxplot visualisation above, it can be seen that the outliers are call_to_ptp, contact connected and the most is in the total contact variable. 

#### 6.3 IQR-Based Outlier Removal

**Standard IQR Method**:

- Lower Bound = Q1 - 1.5 × IQR
- Upper Bound = Q3 + 1.5 × IQR

**Customized Approach for Extreme Cases**:

- For `total_contact`: Applied multiplier of 0.5 due to extreme outlier ranges
- For other variables: Used standard 1.5 multiplier

**Variables Processed**:

1. `call_to_ptp` - Standard IQR (1.5 multiplier)
2. `total_contact` - Modified IQR (0.5 multiplier)
3. `contact_connected` - Standard IQR (1.5 multiplier)
4. `success_ratio` - Standard IQR (1.5 multiplier)

**Results**:

![image alt](https://github.com/najeep24/debt-collector-performance-analysis/blob/7e2394fca9f54d3ee7f5a74d554476b1579be82f/data/after-contextual-outlier.png
)

- **Records Removed**: 336 records (2.9% of filtered dataset)
- **Outcome**: Eliminated extreme outliers while preserving category-specific patterns

### 7. Final Data Quality Assessment

#### Data Reduction Summary

|Stage|Records|Removed|Percentage|
|---|---|---|---|
|Original Dataset|12,000|-|100%|
|After ID Deduplication|11,460|540|95.5%|
|After Outlier Removal|11,124|336|97.1% of filtered|
|**Total Data Retained**|**11,124**|**876**|**92.7%**|

#### Final Dataset Distribution

**Collector Performance Categories**:

- Medium: 5,605 records (50.4%)
- High: 4,564 records (41.0%)
- Low: 955 records (8.6%)

#### Data Quality Metrics

- **Completeness**: 100% (no missing values)
- **Consistency**: 100% (no categorical inconsistencies)
- **Validity**: 100% (no invalid business rule violations)
- **Accuracy**: 92.7% (after outlier removal)
