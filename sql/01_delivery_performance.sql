-- =====================================================
-- 01_delivery_performance.sql
-- Business question:
-- What percentage of delivered orders were delivered late?
-- =====================================================

SELECT
    COUNT(*) AS total_delivered_orders,

    SUM(
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS late_orders,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_rate

FROM orders

WHERE order_delivered_customer_date IS NOT NULL;