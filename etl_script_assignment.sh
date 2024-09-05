#!/bin/bash

# Set environment variables
CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"
RAW_DIR="raw"
TRANSFORMED_DIR="Transformed"
GOLD_DIR="Gold"

# Step 1: Extract - Download the CSV file into the raw folder
echo "Starting the ETL process..."

# i Created raw directory 
mkdir -p $RAW_DIR

# Download the CSV file
echo "Downloading CSV file..."
wget -O "$RAW_DIR/data.csv" $CSV_URL

# I Verify if the file was downloaded successfully
if [ -f "$RAW_DIR/data.csv" ]; then
    echo "CSV file downloaded successfully and saved in $RAW_DIR."
else
    echo "Failed to download the CSV file."
    exit 1
fi

# Step 2: Transform - Rename column and select specific columns
echo "Transforming data..."

#  I Created transformed directory 
mkdir -p $TRANSFORMED_DIR

# Perform transformation
awk -F',' 'BEGIN {OFS=","} NR==1 {gsub(/Variable_code/, "variable_code"); print $1,$3,$4,$5} NR>1 {print $1,$3,$4,$5}' "$RAW_DIR/data.csv" > "$TRANSFORMED_DIR/2023_year_finance.csv"

# this is to Verify if the transformation was successful
if [ -f "$TRANSFORMED_DIR/2023_year_finance.csv" ]; then
    echo "Data transformed successfully and saved in $TRANSFORMED_DIR."
else
    echo "Failed to transform the data."
    exit 1
fi

# Step 3:This is to Load - Move the transformed data to the Gold directory
echo "Loading data to the Gold directory..."

# I Created gold directory 
mkdir -p $GOLD_DIR

# Move the file
mv "$TRANSFORMED_DIR/2023_year_finance.csv" "$GOLD_DIR/"

# Verify if the file was moved successfully
if [ -f "$GOLD_DIR/2023_year_finance.csv" ]; then
    echo "Data loaded successfully into the $GOLD_DIR directory."
else
    echo "Failed to load the data into the Gold directory."
    exit 1
fi

echo "ETL process completed successfully."


# Question 2
crontab -e

0 0 * * * \\wsl.localhost\Ubuntu\home\dejipaul\etl_script_assignment.sh >> \\wsl.localhost\Ubuntu\home\dejipaul\etl_log.log 2>&1

# Question 3

nano move_files.sh

#!/bin/bash

# Directories
SOURCE_DIR="source_folder"
DEST_DIR="json_and_CSV"

# Create destination directory if it doesn't exist
mkdir -p $DEST_DIR

# Move all CSV and JSON files
echo "Moving all CSV and JSON files from $SOURCE_DIR to $DEST_DIR..."
mv $SOURCE_DIR/*.csv $SOURCE_DIR/*.json $DEST_DIR/

# Verify if the files were moved successfully
if [ "$(ls -A $DEST_DIR/*.csv 2>/dev/null)" ] || [ "$(ls -A $DEST_DIR/*.json 2>/dev/null)" ]; then
    echo "CSV and JSON files moved successfully to $DEST_DIR."
else
    echo "No CSV or JSON files were found to move."
fi

# To Make the script executable

chmod +x move_files.sh

# Run the script

./move_files.sh



