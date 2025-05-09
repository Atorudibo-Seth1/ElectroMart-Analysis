CREATE TABLE retail_sales AS
(SELECT 
    c.CustomerKey, c.Gender, c.Name, c.City, c.State, c.Country, c.Continent, 
    s.OrderNumber, s.OrderDate, s.DeliveryDate, s.Quantity,
    st.StoreKey, st.Country AS StoreCountry, st.State AS StoreState,
    p.ProductName, p.Brand, p.Color, p.UnitCostUSD, p.UnitPriceUSD, p.Subcategory, p.Category,
    ROUND((s.Quantity * p.UnitPriceUSD), 2) AS Revenue,
    ROUND((s.Quantity * p.UnitCostUSD), 2) AS TotalCost,
    ROUND(ROUND((s.Quantity * p.UnitPriceUSD), 2) - ROUND((s.Quantity * p.UnitCostUSD), 2), 2) AS TotalProfits,
    CASE 
		WHEN st.StoreKey = 0 THEN "Online"
        ELSE "In-Store"
	END AS Means_of_Purchase
FROM
    customers c
        JOIN
    sales s ON c.CustomerKey = s.CustomerKey
        JOIN
    stores st ON s.StoreKey = st.StoreKey
        JOIN
    products p ON s.ProductKey = p.ProductKey
)