SELECT *
FROM dbo.NashvilleHousing

-- Standardize Date Format (Excel convert to CSV file seems to have automatically done so)

SELECT SaleDate, CONVERT(DATE,SaleDate)
FROM dbo.NashvilleHousing

UPDATE NashvilleHousing 
SET SaleDate = CONVERT(DATE,SaleDate)

-- If it doesn't Update properly, created a new column entirely

ALTER TABLE NashvilleHousing
ADD SaleDateConverted DATE;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(DATE,SaleDate)

-- Check the new column is created

SELECT SaleDateConverted
FROM dbo.NashvilleHousing

-- Populate Property Address data

SELECT *
FROM dbo.NashvilleHousing
--Where PropertyAddress is null
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM dbo.NashvilleHousing a
JOIN dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM dbo.NashvilleHousing a
JOIN dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress IS NULL

-- Breaking out Address into Individual Columns (Address, City, State)

SELECT PropertyAddress
FROM dbo.NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID

--Split Property Address SUBSTRING example

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1 ) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1 , LEN(PropertyAddress)) as Address
FROM dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1 )

ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1 , LEN(PropertyAddress))

SELECT *
FROM dbo.NashvilleHousing

--Split Owner Address PARSENAME example

SELECT OwnerAddress
FROM dbo.NashvilleHousing

SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerAddressStreet Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerAddressStreet = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
ADD OwnerAddressCity Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerAddressCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerAddressState Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerAddressState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

SELECT *
FROM dbo.NashvilleHousing

-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
    When SoldAsVacant = 'N' THEN 'No'  
    ELSE SoldAsVacant
    END
FROM dbo.NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
    When SoldAsVacant = 'N' THEN 'No'  
    ELSE SoldAsVacant
    END

-- Remove Duplicates

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
            ) row_num

FROM dbo.NashvilleHousing
--ORDER BY ParcelID
)
DELETE FROM RowNumCTE
WHERE row_num > 1


-- Delete Unused Columns
SELECT * FROM dbo.NashvilleHousing

ALTER TABLE dbo.NashvilleHousing 
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, 

ALTER TABLE dbo.NashvilleHousing 
DROP COLUMN SaleDate