# 📊 Subscription Analytics & Customer Churn Analysis

## 📌 Project Overview

The **Subscription Analytics & Customer Churn Analysis** project focuses on analyzing subscription-based business data to understand customer behavior, subscription performance, payment trends, and customer cancellations.

The project uses multiple CSV datasets containing customer information, subscription details, plan pricing, payment records, cancellation data, and customer usage activity. By combining and analyzing these datasets, the project aims to identify meaningful patterns and generate insights that can help businesses improve customer retention and make data-driven decisions.

## 🎯 Project Objectives

- Analyze customer subscription patterns and trends.
- Understand customer churn and cancellation behavior.
- Evaluate subscription plan performance.
- Analyze successful and unsuccessful payment transactions.
- Explore customer engagement through usage activity.
- Identify factors associated with customer cancellations.
- Generate actionable insights to support customer retention strategies.

## 📂 Dataset Description

The project consists of six CSV files:

### 1. `customers.csv`
Contains customer-related information.

**Analysis possibilities:**
- Understand the customer base.
- Explore customer demographics and signup patterns, depending on available columns.
- Compare customer characteristics with subscription behavior.

### 2. `subscriptions.csv`
Contains information about customer subscriptions.

**Analysis possibilities:**
- Analyze subscription statuses.
- Track subscription start and end dates.
- Compare active and cancelled subscriptions.
- Study subscription trends over time.

### 3. `plans.csv`
Contains subscription plan information.

**Analysis possibilities:**
- Compare different subscription plans.
- Analyze plan pricing and billing cycles.
- Identify popular plans.
- Evaluate subscription performance by plan.

### 4. `payments.csv`
Contains payment-related records.

**Analysis possibilities:**
- Analyze payment amounts and statuses.
- Evaluate successful and failed payments.
- Compare payment performance across subscription plans.
- Examine revenue trends when the required date and amount fields are available.

### 5. `cancellations.csv`
Contains information about cancelled subscriptions.

**Analysis possibilities:**
- Calculate cancellation and churn metrics.
- Identify common cancellation reasons, if recorded.
- Analyze cancellation trends over time.
- Compare cancellation patterns across subscription plans.

### 6. `usage_activity.csv`
Contains information about customer activity and product usage.

**Analysis possibilities:**
- Analyze customer engagement.
- Compare usage patterns among customers.
- Explore relationships between engagement and cancellations.
- Identify usage patterns associated with customer retention.

## 🛠️ Tools & Technologies

- **Python** – Data analysis and processing.
- **Pandas** – Data manipulation, cleaning, and aggregation.
- **NumPy** – Numerical operations.
- **Matplotlib** – Data visualization.
- **Seaborn** – Statistical data visualization.
- **Jupyter Notebook** – Interactive analysis and documentation.
- **GitHub** – Project version control and portfolio presentation.

*Note: Update this list to reflect the tools you actually used in the project.*

## 🔍 Project Workflow

### Step 1: Data Loading
- Import the required Python libraries.
- Load the six CSV files into Pandas DataFrames.
- Inspect the structure and dimensions of each dataset.

### Step 2: Data Understanding
- Review column names and data types.
- Examine sample records using `head()` and `sample()`.
- Use `info()` and `describe()` to understand the data.
- Identify numerical and categorical variables.

### Step 3: Data Cleaning
- Check for missing and duplicate values.
- Correct data types where necessary.
- Validate date, numerical, and categorical fields.
- Investigate inconsistent values and handle them appropriately.
- Check the relationships between datasets before combining them.

### Step 4: Exploratory Data Analysis (EDA)
- Analyze customer and subscription distributions.
- Examine subscription plan popularity.
- Explore payment status and amount distributions.
- Investigate cancellation patterns.
- Study customer usage and engagement trends.
- Create charts to communicate important findings.

### Step 5: Data Integration
- Connect relevant datasets using common identifiers, such as customer IDs or subscription IDs, where available.
- Validate join keys and relationships.
- Avoid double-counting payments, subscriptions, or customers when combining tables.

### Step 6: Insights and Recommendations
- Summarize key findings from the analysis.
- Identify potential churn patterns.
- Highlight subscription and payment trends.
- Suggest possible strategies to improve customer engagement and retention.

## 📈 Key Business Questions

This project can help answer questions such as:

1. How many customers are registered in the dataset?
2. How many subscriptions are active, cancelled, or expired?
3. Which subscription plans are the most popular?
4. What percentage of subscriptions are cancelled?
5. What are the most common cancellation reasons?
6. How does payment success vary across subscription plans?
7. What is the total payment amount recorded?
8. How does customer activity vary across users?
9. Are lower-engagement customers more likely to cancel?
10. Which subscription plans have higher cancellation rates?
11. How do subscription and cancellation trends change over time?
12. What actions could help improve customer retention?

The answers will depend on the actual columns, data quality, and findings discovered during analysis.

## 📊 Expected Deliverables

- Cleaned and validated datasets.
- Exploratory data analysis using Python.
- Visualizations highlighting customer and subscription trends.
- Analysis of cancellation, payment, and usage patterns.
- A summary of findings and potential business recommendations.

## 💡 Business Value

Understanding subscription behavior can help businesses identify customer retention challenges, evaluate subscription offerings, monitor payment performance, and improve customer engagement.

The insights from this analysis can support better business decisions, including identifying customers who may need additional engagement and evaluating areas where the subscription experience could be improved.

## 🚀 Future Improvements

- Develop an interactive dashboard using Power BI.
- Create customer churn indicators and retention metrics.
- Perform deeper analysis of factors associated with cancellations.
- Build a machine learning model to predict churn, if suitable data is available.
- Automate recurring reports and analytics workflows.

## 📁 Repository Structure

```text
subscription-churn-analysis/
│
├── customers.csv
├── subscriptions.csv
├── plans.csv
├── payments.csv
├── cancellations.csv
├── usage_activity.csv
├── README.md
└── subscription_analysis.ipynb
```

*The notebook filename above is an example. Replace it with your actual notebook filename.*

## 👩‍💻 Author

**Shrapti Bedre**

Aspiring Data Analyst | Python | Pandas | NumPy | Exploratory Data Analysis

This project demonstrates practical data analysis skills, including data cleaning, exploratory analysis, data visualization, and business-oriented problem-solving.

---

⭐ If you find this project useful, feel free to explore the repository and its analysis.
