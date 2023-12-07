# Introduction
I have successfully concluded a comprehensive data cleaning project centered around Nashville Housing data. This project served as a significant assessment of my ability to utilize SQL for the purpose of cleaning raw data, ultimately transforming it into a refined format.

# Tool Used
MS SQL - SQL Server Management Studio

# Dataset
The Nashville Housing dataset contains 19 columns and 56.477 rows. [Download here](https://github.com/OluwatobiAkintokun/NASHVILLE-HOUSING-DATA-CLEANING-WITH-SQL/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx)

# Data cleaning and transformation
The data cleaning and transformation were carried out using MSSQL. The following actions were taken to enhance the quality and structure of the data.

(1) Standardize Date Format using CONVERT function.
  
![image](https://github.com/OluwatobiAkintokun/NASHVILLE-HOUSING-DATA-CLEANING-WITH-SQL/assets/137109080/a0ca583a-d9f2-4d93-9f74-31fcdfd96fce)

(2) I populated the NULL values in the Property Address column using the ISNULL function.
  
![image](https://github.com/OluwatobiAkintokun/NASHVILLE-HOUSING-DATA-CLEANING-WITH-SQL/assets/137109080/0e451243-0f7a-4464-9778-854522891e92)

(3) I used the SUBSTRING and CHARINDEX functions to split the Property Address into individual columns, specifically Address and City.

![image](https://github.com/OluwatobiAkintokun/NASHVILLE-HOUSING-DATA-CLEANING-WITH-SQL/assets/137109080/310a1478-6649-47a7-b24d-8af27aec3175)

(4) I used PARSENAME function to split Owner Address into individual columns, specifically Address, City and State.

![image](https://github.com/OluwatobiAkintokun/NASHVILLE-HOUSING-DATA-CLEANING-WITH-SQL/assets/137109080/f6f778cc-e857-4a39-8cd8-ff2407d394a2)

(5) The 'SoldAsVacant' field was standardized using a CASE statement, replacing 'Y' with 'Yes' and 'N' with 'No' for uniformity.

![image](https://github.com/OluwatobiAkintokun/NASHVILLE-HOUSING-DATA-CLEANING-WITH-SQL/assets/137109080/e915763c-b5b5-4d18-b33b-448280163718)

(6) Duplicates were removed using the ROW_NUMBER() function and a Common Table Expression (CTE).

![image](https://github.com/OluwatobiAkintokun/NASHVILLE-HOUSING-DATA-CLEANING-WITH-SQL/assets/137109080/ce6ca7ca-ad6f-48e4-a4d7-30f8950078a4)

![image](https://github.com/OluwatobiAkintokun/NASHVILLE-HOUSING-DATA-CLEANING-WITH-SQL/assets/137109080/d802a68c-6771-4377-b524-f31333c28b83)

(7) New columns were added for Property Address, Sale Date, Owner Address, and unnecessary columns were subsequently removed using the DROP function.

![Uploading image.png…]()




