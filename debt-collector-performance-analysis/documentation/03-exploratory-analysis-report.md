In this section, we detail the steps taken to explore the dataset with the aim of identifying distinct behavioral and performance patterns among debt collectors. To ensure the analysis was both accurate and meaningful, necessary preprocessing was applied to selected variables to align them with the analytical objectives. 


## Data Preprocessing

### Variable Selection and Cleaning

Unnecessary identifier variables (`id_collector`, `collector_name`) were removed to focus on predictive features relevant to performance modeling.

### Categorical Encoding Strategy

Rather than using standard label encoding (which showed sorting errors with nested ordinal categories), a custom mapping approach was implemented:

**Quality Metrics Mapping:**

python

```python
mapping = {'Buruk': 1, 'Cukup': 2, 'Kurang Memuaskan': 3, 'Baik': 4, 'Sangat Baik': 5}
```

**Performance Categories:**

python

```python
mapping = {'Low': 0, 'Medium': 1, 'High': 2}
```

This approach preserved the ordinal relationships while maintaining correlation integrity for downstream modeling.

## Exploratory Data Analysis

### Key Statistical Insights

- **Dataset Size**: 11,124 collector performance records
- **Average Recovery Rate**: 67.4% success ratio across all collectors
- **Contact Efficiency**: Average 27 successful connections from 53 total contact attempts
- **Case Processing**: Mean 13.5 cases closed per collector per period

### Performance Category Distribution

|Category|Count|Percentage|
|---|---|---|
|Medium|5,605|50.4%|
|High|4,630|41.6%|
|Low|1,225|11.0%|

### Critical Performance Patterns

#### 1. Debt Recovery Analysis

![total debt vs recieved](https://github.com/najeep24/debt-collector-performance-analysis/blob/858b0f799c8c9c73db6216f4e53b896ecde0188f/data/total-debt.png)

- **High performers** demonstrate superior debt collection capabilities despite similar debt assignment levels
- All categories receive comparable total debt amounts, suggesting unbiased task distribution
- Recovery effectiveness clearly differentiates performance tiers

#### 2. Skill Assessment Patterns
![categorical pattern variabel](https://github.com/najeep24/debt-collector-performance-analysis/blob/47a81fd00d46eb140f56d28da71e338c6c46513b/data/problem-solve.png)

- **Low performers**: Consistently score at minimum levels across all evaluated dimensions
- **Medium vs High performers**: Similar overall patterns but high performers show:
    - Greater consistency with fewer poor scores
    - Superior problem-solving reliability
    - More stable success ratios

#### 3. Operational Efficiency Metrics
![violin plot](https://github.com/najeep24/debt-collector-performance-analysis/blob/47a81fd00d46eb140f56d28da71e338c6c46513b/data/violin.png)
- **Transfer processing times**: Low performers average >25 days vs. <16 days for others
- **Contact conversion**: High performers achieve better contact-to-promise ratios
- **Case closure**: Strong correlation between promise conversion and final resolution success

### Correlation Analysis

**Strongest Performance Predictors:**
![heatmap](https://github.com/najeep24/debt-collector-performance-analysis/blob/47a81fd00d46eb140f56d28da71e338c6c46513b/data/corr.png)
- Success Ratio: 0.65 correlation with performance category
- Call-to-Payment Promise Rate: 0.65 correlation
- Contact Connection Rate: 0.56 correlation
- Problem-Solving Assessment: 0.49 correlation

## Feature Engineering

### Engineered Performance Metrics

Three new features were created based on domain knowledge and correlation analysis:

#### 1. Right Party Contact Rate (RPC_rate)

python

```python
RPC_rate = (contact_connected / total_contact) × 100
```

**Correlation with target**: 0.73

- Measures effectiveness in reaching decision-makers
- Higher correlation than individual contact metrics

#### 2. Payment Promise Rate (PTP_rate)

python

```python
PTP_rate = (call_to_ptp / contact_connected) × 100
```

**Correlation with target**: 0.52

- Evaluates persuasion and negotiation effectiveness
- Aggregates multiple correlated variables

#### 3. Recovery Rate (recovery_rate)

python

```python
recovery_rate = (total_debt_payment_received / total_debt) × 100
```

**Correlation with target**: 0.69

- Direct measure of financial recovery effectiveness
- Strongest predictor of overall performance

### Feature Standardization

Applied Z-score standardization to key numerical features to ensure equal weighting in model training:

- `total_contact`, `contact_connected`, `call_to_ptp`
- `RPC_rate`, `PTP_rate`, `recovery_rate`, `success_ratio`

## Business Insights

### Performance Differentiation Factors

1. **Consistency Over Peak Performance**: High performers minimize poor scores rather than just achieving maximum scores
2. **Efficiency Metrics**: Superior contact conversion rates distinguish top performers
3. **Recovery Capability**: Direct correlation between collection amounts and performance categories
4. **Problem-Solving Impact**: Moderate but significant influence on overall performanc
