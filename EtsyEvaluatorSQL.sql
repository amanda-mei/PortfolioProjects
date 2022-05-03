Select * From etsysold

-- Drop Columns not needed for analysis of most popular items sold and anonymize customer data

ALTER TABLE etsysold
DROP COLUMN Buyer, Coupon_Code, Coupon_Details, 
Discount_Amount, Shipping_Discount, Order_Sales_Tax, Currency,
Transaction_ID, Listing_ID, Date_Paid, Date_Shipped, 
Ship_Name, Ship_Address1, Ship_Address2, Order_ID, Order_Type,
Listings_Type, Payment_Type,InPerson_Discount, InPerson_Location, VAT_Paid_by_Buyer, SKU

-- Streamline the item names into their categories

SELECT * FROM etsysold WHERE Item_Name LIKE '%Acrylic Charm%'

ALTER TABLE etsysold
ADD ItemNameConverted Nvarchar(255);

UPDATE etsysold 
SET 
    ItemNameConverted = 'Acrylic Charm'
WHERE
    Item_Name LIKE '%Acrylic Charm%'

UPDATE etsysold 
SET 
    ItemNameConverted = 'Microfiber Cloth'
WHERE
    Item_Name LIKE '%Microfiber%Cloth%'

UPDATE etsysold 
SET 
    ItemNameConverted = 'Sticker'
WHERE
    Item_Name LIKE '%Sticker%'

UPDATE etsysold 
SET 
    ItemNameConverted = 'Pin'
WHERE
    Item_Name LIKE '%Pin%'

UPDATE etsysold 
SET 
    ItemNameConverted = 'Button'
WHERE
    Item_Name LIKE '%Button%'

UPDATE etsysold 
SET 
    ItemNameConverted = 'Plush'
WHERE
    Item_Name LIKE '%Plush%'

UPDATE etsysold 
SET 
    ItemNameConverted = 'Print'
WHERE
    Item_Name LIKE '%Print'

UPDATE etsysold 
SET 
    ItemNameConverted = 'Microfiber Cloth Discounted'
WHERE
    Item_Name LIKE '%Discount%'


-- Clean up NULL in Variations
UPDATE etsysold
SET Variations = 'Choose: '+ Item_Name 
WHERE Variations IS NULL

-- Most popular categories
SELECT ItemNameConverted, COUNT(*) 
FROM etsysold 
GROUP BY ItemNameConverted
ORDER BY COUNT(*) DESC; 

-- Categories sales total
SELECT ItemNameConverted, SUM(Price)
FROM etsysold 
GROUP BY ItemNameConverted
ORDER BY SUM(Price) DESC; 

-- Most popular items in their categories
SELECT Variations, SUM(Quantity) 
FROM etsysold 
GROUP BY Variations
ORDER BY SUM(Quantity) DESC; 

-- Item sales total
SELECT Variations, SUM(Price)
FROM etsysold 
GROUP BY Variations
ORDER BY SUM(Price) DESC; 

-- Countries with most sales
SELECT Ship_Country, COUNT(*) 
FROM etsysold 
GROUP BY Ship_Country
ORDER BY COUNT(*) DESC; 

-- US States with most sales
SELECT Ship_State, COUNT(*) 
FROM etsysold WHERE Ship_Country = 'United States'
GROUP BY Ship_State
ORDER BY COUNT(*) DESC; 

-- Canadian Provinces with most sales
SELECT Ship_State, COUNT(*) 
FROM etsysold WHERE Ship_Country = 'Canada'
GROUP BY Ship_State
ORDER BY COUNT(*) DESC; 