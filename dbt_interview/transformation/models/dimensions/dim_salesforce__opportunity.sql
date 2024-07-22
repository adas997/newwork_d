with opportunity_data as (
    select * from {{ ref ('dim_scd_salesforce_opportunity') }}
    where opportunity_id is not null
)
select 
        *
    from opportunity_data    