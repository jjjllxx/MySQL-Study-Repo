## Compound Join Conditions
```sql
USE sql_invoicing;

SELECT 
    p.payment_id,
    c.client_id,
    p.invoice_id,
    p.date,
    p.amount,
    p.payment_method
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
```
