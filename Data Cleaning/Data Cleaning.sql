

---------------------------------------------------------------------------------------------------------------------------------
--Standardizing Date Format in SaleDate Column
UPDATE PortfolioProject2..NationalHousing
SET SaleDate=CONVERT(date,SaleDate)



---------------------------------------------------------------------------------------------------------------------------------
--Populate the null values in the Property Address based on Parcel ID
SELECT ParcelId, propertyAddress, MAX(PropertyAddress) OVER (PARTITION BY ParcelId) AS C
FROM PortfolioProject2..NationalHousing





---------------------------------------------------------------------------------------------------------------------------------
--Seperating Propery Address into Address and City
SELECT PropertyAddress, 
	   SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as PropertyAddress,
	   --Substring(PropertyAddress, CHARINDEX(' ', PropertyAddress)+1,LEN(PropertyAddress)-CHARINDEX(',', REVERSE(PropertyAddress))-CHARINDEX(' ',PropertyAddress)) as PropertyStreet,
	   Substring(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, CHARINDEX(',',PropertyAddress)+1) as PropertyCity
FROM PortfolioProject2..NationalHousing AS NationalHousing
WHERE CHARINDEX(' ', PropertyAddress) > 0 AND CHARINDEX(',', PropertyAddress) > CHARINDEX(' ', PropertyAddress);






---------------------------------------------------------------------------------------------------------------------------------
--Seperating Owner Address into Address, City and State
SELECT 
	OwnerAddress, 
	SUBSTRING(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1) as OwnerAddress,
	Substring(
		OwnerAddress, 
		CHARINDEX(',', OwnerAddress)+1,
		LEN(OwnerAddress)-CHARINDEX(',', REVERSE(OwnerAddress))-CHARINDEX(',',OwnerAddress)
				) AS OwnerCity,
    SUBSTRING(
	Substring(
		OwnerAddress,
		CHARINDEX(',',OwnerAddress)+1,
		LEN(OwnerAddress)
				),
	   CHARINDEX(',',Substring(OwnerAddress,CHARINDEX(',',OwnerAddress)+1,LEN(OwnerAddress)))+1,
	   LEN(Substring(OwnerAddress,CHARINDEX(',',OwnerAddress)+1,LEN(OwnerAddress)))
			) AS OwnerState
FROM PortfolioProject2..NationalHousing AS NationalHousing
WHERE CHARINDEX(' ', OwnerAddress) > 0 AND CHARINDEX(',', OwnerAddress) > CHARINDEX(' ', OwnerAddress);


--Another way of splitting columns is using parsename
SELECT OwnerAddress,
	   PARSENAME(REPLACE(OwnerAddress,',','.'),3),
	   PARSENAME(REPLACE(OwnerAddress,',','.'),2),
	   PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM PortfolioProject2..NationalHousing AS NationalHousing;





---------------------------------------------------------------------------------------------------------------------------------
--Managing inaccuracies in the SoldAsvacant Column
SELECT SoldAsVacant
FROM PortfolioProject2..NationalHousing
WHERE SoldAsVacant='N'
OR SoldAsVacant='Y'

-- Change Y and N to Yes and No in "Sold as Vacant" field
SELECT 
	CASE 
		WHEN SoldAsVacant='Y' THEN 'YES'
		WHEN SoldAsVacant='N' THEN 'No'
		ELSE SoldAsVacant
END AS SoldAsVacant
FROM PortfolioProject2..NationalHousing




---------------------------------------------------------------------------------------------------------------------------------
--Remove Duplicates
WITH RealState AS(
SELECT *,
	ROW_NUMBER() OVER(	
		Partition by 
			ParcelID,
			PropertyAddress,
			LegalReference,
			SaleDate,
			SalePrice
			ORDER BY
				UniqueID
				) row_count
FROM PortfolioProject2..NationalHousing
)
DELETE 
FROM RealState
WHERE row_count>1
--Order by ParcelId






---------------------------------------------------------------------------------------------------------------------------------
--Putting all the above changes and creating a VIEW of the table
CREATE VIEW RealEstate As
SELECT  
	[UniqueID ],
	ParcelID,
	LandUse,
	SUBSTRING(
		MAX(PropertyAddress) OVER (PARTITION BY ParcelId),
		1,
		CHARINDEX(',',MAX(PropertyAddress) OVER (PARTITION BY ParcelId))-1) AS PropertyAddress,
	SUBSTRING(
		MAX(PropertyAddress) OVER (PARTITION BY ParcelId), 
		CHARINDEX(',', MAX(PropertyAddress) OVER (PARTITION BY ParcelId))+1, 
		CHARINDEX(',',PropertyAddress)+1) as PropertyCity,
	SaleDate,
	SalePrice,
	LegalReference,
	CASE 
		WHEN SoldAsVacant='Y' THEN 'YES'
		WHEN SoldAsVacant='N' THEN 'No'
		ELSE SoldAsVacant
	END AS SoldAsVacant,
	OwnerName,
	PARSENAME(REPLACE(OwnerAddress,',','.'),3) AS OwnerAddress,
	PARSENAME(REPLACE(OwnerAddress,',','.'),2) AS OwnerCity, 
	PARSENAME(REPLACE(OwnerAddress,',','.'),1) AS OwnerState,
		Acreage,
		TaxDistrict,
		LandValue,
		BuildingValue,
		TotalValue,
		YearBuilt,
		Bedrooms,
		FullBath,
		HalfBath

FROM PortfolioProject2..NationalHousing


SELECT * 
FROM RealEstate
