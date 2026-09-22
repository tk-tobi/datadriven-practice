SELECT 
    provider,
    (AVG(amount) FILTER (WHERE EXTRACT(MONTH FROM bill_date) = 7)) - 
    (AVG(amount) FILTER (WHERE EXTRACT(MONTH FROM bill_date) = 1)) AS amount_changed
FROM cloud_costs
GROUP BY provider
ORDER BY provider;
