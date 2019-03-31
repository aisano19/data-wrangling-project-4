library(tidyverse)
setwd("/Users/aisano/Desktop/Springboard/3.1_DataWrangling")

# 0: Load the data in RStudio
df_ro <- read.csv(file = "refine_original.csv", stringsAsFactors = FALSE)
df_ro <- df_ro[, -7]

# Learn about the dataset
str(df_ro)
summary(df_ro)
head(df_ro)


# 1: Clean up brand names (philips, akzo, van houten, unilever)
# Correct brand names
df_ro$company <- sub(pattern = "^ph.*|^f.*", "philips", df_ro$company, ignore.case = TRUE)
df_ro$company <- sub(pattern = "^ak.*", "akzo", df_ro$company, ignore.case = TRUE)
df_ro$company <- sub(pattern = "^va.*", "van houten", df_ro$company, ignore.case = TRUE)
df_ro$company <- sub(pattern = "^uni.*", "unilever", df_ro$company, ignore.case = TRUE)


# 2: Separate product code and number
df_ro <- separate(df_ro, Product.code...number, c("product_code", "product_number"))


# 3: Add product categories
df_ro$product_category <- df_ro$product_code
df_ro$product_category <- sub(pattern = "p", "smart phone", df_ro$product_category)
df_ro$product_category <- sub(pattern = "v", "tv", df_ro$product_category)
df_ro$product_category <- sub(pattern = "x", "laptop", df_ro$product_category)
df_ro$product_category <- sub(pattern = "q", "tablet", df_ro$product_category)


# 4: Add full address for geocoding
df_ro$full_address <- paste(df_ro$address, df_ro$city, df_ro$country, sep = ",")


# 5: Create dummy variables for company and product category
# Add binary (1 or 0) columns for company 
df_ro$company_philips <- ifelse(df_ro$company == "philips", 1, 0)
df_ro$company_akzo <- ifelse(df_ro$company == "akzo", 1, 0)
df_ro$company_van_houten <- ifelse(df_ro$company == "van_houten", 1, 0)
df_ro$company_unilever <- ifelse(df_ro$company == "unilever", 1, 0)

# Add binary (1 or 0) columns for product category 
df_ro$product_smartphone <- ifelse(df_ro$product_category == "smart phone", 1, 0)
df_ro$product_tv <- ifelse(df_ro$product_category == "tv", 1, 0)
df_ro$product_laptop <- ifelse(df_ro$product_category == "laptop", 1, 0)
df_ro$product_tablet <- ifelse(df_ro$product_category == "tablet", 1, 0)


# Save the dataframe as a .csv file
write.csv(df_ro, "refine_clean.csv")