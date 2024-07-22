with product_data as (
    select * from {{ ref ('stg_salesforce__product_2') }}
    where product_id is not null
)
select 
        {{ dbt_utils.generate_surrogate_key(['p.product_id']) }}	as dim_prod_key,
        p.product_id,
        p.name as product_name,
        p.productcode as product_code,
        p.description as product_description,
        p.isactive as is_product_active,
        p.createddate as product_created_date,
        p.createdbyid as product_created_by,
        p.lastmodifieddate as product_last_modified_date,
        p.lastmodifiedbyid as product_last_modified_by,
        p.externaldatasourceid,
        p.externalid,
        p.displayurl,
        --p.quantityunitofmeasure as product_quantity,
        p.stockkeepingunit,
        p.type as product_type,
        p.productclass as product_class,
        p.sourceproductid as source_product_id,
        p.sellerid as product_seller_id
    from product_data p 
    where product_id is not null