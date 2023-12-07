---DATA CLEANING IN NASHVILLE HOUSING TABLE

--(1) Standardize Date Format
UPDATE NashvilleHousing
SET SaleDate = CONVERT(Date,Saledate)
			
ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date,Saledate)

SELECT SaleDateConverted
FROM NashvilleHousing

--(2) Populate Property Address Data
SELECT PropertyAddress
FROM NashvilleHousing
WHERE PropertyAddress is null

-- Join the columns Parcel ID and Property Address to check for NULL values. 
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is null

-- Update the columns with NULL values using ISNULL function.
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is null

--(3) Spliting Property Address into Individual columns (Address and City)
SELECT PropertyAddress 
FROM NashvilleHousing

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)) AS Address
FROM NashvilleHousing

--The delimiter (,) is still there, To get rid of the comma at the end of the address
SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address
FROM NashvilleHousing

-- To split the Property Address into Address and City, SUBSTRING AND CHARINDEX was used.
SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address
,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1,LEN(PropertyAddress)) AS Address
FROM NashvilleHousing

--To create new columns for the splited address
ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(250);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(250);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1,LEN(PropertyAddress))

--(4) Spliting Owner Address into Individual columns (Address, City and State), PARSENAME was used.
SELECT *
FROM NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
FROM NashvilleHousing

--To create new columns for the separated address
ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(250);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(250);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(250);

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

--(5) The 'SoldAsVacant' field was standardized using a CASE statement, replacing 'Y' with 'Yes' and 'N' with 'No' for uniformity.
SELECT DISTINCT (SoldAsVacant), COUNT(SoldAsVacant)
FROM NashvilleHousing
Group by SoldAsVacant
Order by 2

-- To change Y to Yes and N to No.
SELECT SoldAsVacant
,CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
      WHEN SoldAsVacant = 'N' THEN 'No'
      ELSE SoldAsVacant
      END
FROM NashvilleHousing

--To update the changes on the Nashville Housing table
UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
      WHEN SoldAsVacant = 'N' THEN 'No'
      ELSE SoldAsVacant
      END

--(6) Duplicates were removed using the ROW_NUMBER() function and a Common Table Expression (CTE)
SELECT *
FROM NashvilleHousing

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
	             PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
				 UniqueID
				 )row_num
FROM NashvilleHousing
)
DELETE
FROM RowNumCTE
WHERE row_num > 1

SELECT *
FROM NashvilleHousing

-- To confirm duplicates are all deleted
WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
	             PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
				 UniqueID
				 )row_num
FROM NashvilleHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1

--(7) New columns were added for Property Address, Sale Date, Owner Address, and unnecessary columns were subsequently removed using the DROP function
SELECT *
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate
