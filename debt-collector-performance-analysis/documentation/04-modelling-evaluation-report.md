# Collector Performance Classification: Model Development and Evaluation Report

## Overview

This report presents the modeling phase of a collector performance classification project, beginning with data balancing techniques and continuing through model development, evaluation, and performance analysis. The analysis focuses on comparing three machine learning algorithms - LightGBM, Random Forest, and Decision Tree - across different feature configurations to predict collector performance categories (Low, Medium, High).

The dataset used contains 11,649 records with a 70/30 train-test split, featuring both original operational metrics and engineered performance indicators derived from XGBoost feature importance analysis.

## 1. Data Balancing

Applied SMOTENC (Synthetic Minority Oversampling Technique for Nominal and Continuous features) to address class imbalance:

- **Before SMOTE**: Low(700), Medium(4,118), High(3,336)
- **After SMOTE**: Low(4,118), Medium(4,118), High(4,118)

### 1.2 Feature Selection

Used XGBoost-based feature importance with multiple thresholds (0.002, 0.01, 0.045) to identify the most relevant features for model performance.

## 2. Model Development

### 2.1 Algorithms Tested

Three machine learning algorithms were evaluated across different configurations:

1. **LightGBM (Light Gradient Boosting Machine)**
    
    - Hyperparameters: `subsample=0.389`, `reg_lambda=5`, `min_child_weight=10`, `max_depth=27`
2. **Random Forest Classifier**
    
    - Hyperparameters: `n_estimators=2000`, `max_depth=100`, `min_samples_split=5`, `min_samples_leaf=1`, `max_features='sqrt'`, `bootstrap=True`
3. **Decision Tree Classifier**
    
    - Hyperparameters: `criterion='log_loss'`, `max_depth=9`, `min_samples_split=5`, `min_samples_leaf=1`, `max_features=None`, `splitter='best'`

### 2.2 Experimental Configurations

Each algorithm was tested under three different conditions:

- **Baseline**: Original features only
- **Feature Engineering**: Original + engineered features
- **Full Pipeline**: Feature Engineering + SMOTE + XGBoost feature selection

## 3. Results and Performance Analysis

### 3.1 Model Performance Comparison

|Configuration|Model|Accuracy|K-Fold CV (Avg)|
|---|---|---|---|
|**Feature Engineering + SMOTE + XGBoost**|**LightGBM**|**95.34%**|**95.42%**|
|Feature Engineering|LightGBM|95.34%|95.42%|
|Baseline|LightGBM|92.96%|93.29%|
|Feature Engineering + SMOTE + XGBoost|Random Forest|94.68%|94.45%|
|Feature Engineering|Random Forest|94.96%|94.75%|
|Baseline|Random Forest|90.13%|90.30%|
|Feature Engineering + SMOTE + XGBoost|Decision Tree|92.50%|93.04%|
|Feature Engineering|Decision Tree|92.48%|93.16%|
|Baseline|Decision Tree|88.38%|88.32%|

### 3.2 Best Performing Model: LightGBM

The LightGBM model with feature engineering achieved the highest performance:

#### Classification Report:

```
              Precision  Recall  F1-Score  Support
Low              0.96      0.97      0.97      300
Medium           0.96      0.95      0.95     1765
High             0.95      0.95      0.95     1430
Accuracy                             0.95     3495
Macro Avg        0.96      0.96      0.96     3495
Weighted Avg     0.95      0.95      0.95     3495
```

#### Confusion Matrix:

```
         Predicted
Actual   Low  Medium  High
Low      291    9      0
Medium    12   1680   73  
High       0    69   1361
```

#### AUC Scores:

- **Micro Average**: 0.996
- **Class 0 (Low)**: 1.000
- **Class 1 (Medium)**: 0.993
- **Class 2 (High)**: 0.994

## 3.3 ROC Curve Analysis

The ROC (Receiver Operating Characteristic) curves provide a graphical comparison of the classification capabilities of the three models (LightGBM, Random Forest, and Decision Tree) across all possible classification thresholds. The x-axis represents the **False Positive Rate (FPR)**, while the y-axis represents the **True Positive Rate (TPR)**. An ideal model will achieve a curve that quickly rises towards the top-left corner, indicating high sensitivity with minimal false alarms.

![roc-curve](https://github.com/najeep24/debt-collector-performance-analysis/blob/c914e92aa5549d5b378f6afcadcceaba7749aaf4/data/ROC-curve-comparison.png)
### Observations:

1. **LightGBM (AUC = 0.99)**
    
    - The curve for LightGBM consistently dominates across the entire threshold range.
        
    - Its AUC value of 0.99 indicates **exceptional discriminative ability**, meaning the model can reliably distinguish between collector performance categories.
        
    - The curve almost hugs the top border, reflecting near-optimal classification performance.
        
2. **Random Forest (AUC = 0.99)**
    
    - Random Forest shows performance very close to LightGBM, with the ROC curve almost overlapping.
        
    - AUC of 0.99 confirms that the ensemble method is also highly effective in capturing decision boundaries.
        
    - Slightly less smooth than LightGBM, which suggests marginally higher variability across thresholds, but practically equivalent in predictive power.
        
3. **Decision Tree (AUC = 0.98)**
    
    - The Decision Tree, while slightly lower in performance, still achieves a very strong AUC of 0.98.
        
    - The curve diverges more noticeably from LightGBM and Random Forest in the low-FPR region (early stage of curve), implying higher susceptibility to false positives when sensitivity is prioritized.
        
    - This highlights the trade-off of a single-tree model: easier interpretability but slightly less robust classification power compared to ensemble approaches.
        
### Key Insights:

1. **Ensemble Superiority**: Both LightGBM and Random Forest outperform the Decision Tree, confirming that ensemble methods (boosting and bagging) provide more stable and generalizable performance.
    
2. **Practical Equivalence**: LightGBM and Random Forest have nearly identical AUC values (0.99). However, LightGBM shows smoother performance across thresholds, making it preferable for production when consistency matters.
    
3. **Decision Tree Trade-off**: While the Decision Tree lags slightly, it still demonstrates high classification ability (AUC 0.98). Its simplicity and interpretability may be advantageous in contexts where explainability is more critical than marginal gains in accuracy.
    
4. **Threshold Robustness**: All three models maintain strong performance across varying decision thresholds, which indicates flexibility in setting operational cut-offs (e.g., choosing stricter or more lenient classifications depending on business objectives).
    
### ROC analysis conclusion:

The ROC curve analysis reinforces the earlier performance metrics: **LightGBM is the optimal model**, combining high accuracy, stability, and robustness across thresholds. Random Forest is a strong alternative with nearly equal discriminative power, while Decision Tree—though slightly less effective—remains a valid option when transparency and ease of explanation are prioritized.

## 4. Feature Importance Analysis

### 4.1 Top Features (LightGBM - Full Pipeline)

1. **RPC_rate** (18.2%): Right Party Contact effectiveness
2. **recovery_rate** (17.3%): Debt recovery efficiency
3. **PTP_rate** (16.3%): Promise-to-Pay conversion success
4. **total_contact** (9.9%): Contact frequency
5. **call_to_ptp** (8.8%): Call conversion effectiveness

### 4.2 Feature Engineering Impact

The addition of engineered features significantly improved model performance:

- **Baseline LightGBM**: 92.96% accuracy
- **With Feature Engineering**: 95.34% accuracy
- **Improvement**: +2.38 percentage points

## 5. Model Validation

### 5.1 Cross-Validation Strategy

Implemented 10-fold stratified cross-validation to ensure robust performance evaluation:

- **LightGBM**: 95.42% ± 0.5% (low variance indicates stable performance)
- **Random Forest**: 94.45% ± 0.8%
- **Decision Tree**: 93.04% ± 1.2%

### 5.2 Generalization Assessment

The small gap between training performance and cross-validation scores indicates good generalization capability without significant overfitting.

## 6. Business Impact and Insights

### 6.1 Key Performance Drivers

The analysis reveals that collector performance is primarily driven by:

1. **Contact Quality**: Right Party Contact (RPC) rates are the strongest predictor
2. **Conversion Efficiency**: Recovery rates and Promise-to-Pay rates are critical
3. **Engagement Volume**: Total contacts made significantly impact performance
4. **Process Efficiency**: Call-to-PTP conversion demonstrates operational excellence

### 6.2 Actionable Insights

- **Training Focus**: Prioritize training on contact quality and conversion techniques
- **Performance Monitoring**: Implement real-time tracking of RPC and recovery rates
- **Resource Allocation**: Assign high-performing collectors to complex cases
- **Process Optimization**: Focus on improving call-to-promise conversion processes

## 7. Technical Implementation

### 7.1 Model Pipeline

The final production model follows this pipeline:

1. **Data Preprocessing**: Handle missing values and normalize features
2. **Feature Engineering**: Apply XGBoost-selected feature transformations
3. **Class Balancing**: Apply SMOTENC for training data
4. **Model Training**: Train LightGBM with optimized hyperparameters
5. **Prediction**: Generate performance category predictions with probability scores

### 7.2 Model Monitoring

Recommended monitoring metrics:

- **Accuracy**: Overall classification accuracy
- **Class-specific Performance**: Monitor precision/recall for each performance category
- **Feature Drift**: Track changes in feature distributions over time
- **Business Metrics**: Correlation between predictions and actual collection outcomes

## 8. Limitations and Future Work

### 8.1 Current Limitations

- **Data Imbalance**: Original dataset heavily skewed toward medium/high performers
- **Temporal Factors**: Limited exploration of seasonal or temporal performance patterns
- **External Factors**: Economic conditions and market factors not considered
- **Interpretability**: Complex ensemble model may be difficult to explain to stakeholders

### 8.2 Future Enhancements

- **Deep Learning**: Explore neural network architectures for pattern recognition
- **Time Series**: Incorporate temporal modeling for performance trend analysis
- **External Data**: Integrate economic indicators and market conditions
- **Real-time Updates**: Implement online learning for continuous model improvement
- **Explainable AI**: Add SHAP or LIME analysis for better interpretability

## 9. Conclusion

This project successfully developed a high-performance collector classification system achieving 95.34% accuracy using LightGBM with engineered features. The model demonstrates strong predictive capability across all performance categories and provides valuable insights into the key drivers of collector effectiveness.

The implementation of comprehensive feature engineering, particularly the addition of rate-based metrics (RPC_rate, recovery_rate, PTP_rate), proved crucial for achieving optimal performance. The model is ready for production deployment and can significantly enhance collector performance management and operational decision-making.

### Key Success Factors:

- **Comprehensive Feature Engineering**: Strategic creation of performance-relevant metrics
- **Proper Class Balancing**: SMOTENC effectively addressed data imbalance
- **Algorithm Selection**: LightGBM proved optimal for this classification task
- **Robust Validation**: 10-fold cross-validation ensured reliable performance estimates

The model provides a solid foundation for data-driven collector performance management and offers clear pathways for continuous improvement and expansion.
