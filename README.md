# R-Youth-Substance-Use-Analysis
# Youth Substance Use Analysis: Key Findings & Actionable Insights

## 🔍 Project Overview
Statistical analysis of 10,000 youth records (2020-2024) examining smoking/drug use predictors:
- **Variables**: Age, SES, family background, parental supervision, mental health
- **Methods**: ANOVA, Chi-square, GLM, Kernel Density Estimation
- **Tools**: SAS, R, Python (Pandas/Matplotlib)

## 📊 Key Findings

### 1. Age Group Analysis
```diff
- No significant smoking prevalence difference across ages (p=0.8769)
! All groups averaged ~27.4% smoking rate (SD=12.98)
```

### 2. Socioeconomic Status

```mermaid
pie showTitle
    title Smoking Prevalence by SES
    "Low SES" : 27.49
    "Middle SES" : 27.12
    "High SES" : 27.50
```

Drug Use: No SES-based differences (p=0.7088)

Density Plots: Symmetric but leptokurtic distributions

### 3. Family Factors
Factor	F-value	p-value	Highest Risk Group
Parental Supervision	0.75	0.6641	Level 6 (27.87%)
Family Background	0.70	0.7097	Group 6 (28.22%)

### 4. Mental Health
```diff
- No significant drug use correlation (Low SES p=0.96, High SES p=0.28)
```

## 🚀 Actionable Recommendations
For Policy Makers
```gantt
    title Intervention Roadmap
    dateFormat  YYYY-Q
    section High-Risk Groups
    Family Support Programs :2025-Q1, 2025-Q4
    section Universal
    School Prevention Campaigns :2025-Q2, 2026-Q2
```

## For Future Research
Investigate peer influence (not analyzed here)

Longitudinal tracking of individual behaviors

Refine mental health measurement tools












