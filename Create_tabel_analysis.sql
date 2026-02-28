-- Create New Table dalam database kimia_farma
CREATE TABLE `kimia_farma.tabel_analysis` AS
-- Data yang ada di tabel-tabel sebelumnya
SELECT
    ft.transaction_id,
    ft.date,
    ft.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    ft.product_id,
    p.product_name,
    ft.price AS actual_price,
    ft.discount_percentage,
    -- Membuat kolom persentase_gross_laba
    CASE 
        WHEN ft.price <= 50000 THEN 0.1
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.2
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        ELSE 0.3
    END AS persentase_gross_laba,
    -- Membuat kolom nett_sales
    (ft.price * (1 - (ft.discount_percentage / 100))) AS nett_sales,
    -- Membuat kolom nett_sales
    (ft.price * (1 - (ft.discount_percentage / 100)) * 
    CASE 
        WHEN ft.price <= 50000 THEN 0.1
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.2
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        ELSE 0.3
    END) AS nett_profit,
    ft.rating AS rating_transaksi
    
FROM `kimia_farma. kf_final_transaction` ft
JOIN `kimia_farma.kf_kantor_cabang` kc ON ft.branch_id = kc.branch_id
JOIN `kimia_farma.kf_product` p ON ft.product_id = p.product_id;
