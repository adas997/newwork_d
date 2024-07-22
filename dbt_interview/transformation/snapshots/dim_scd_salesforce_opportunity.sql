{% snapshot dim_scd_salesforce_opportunity %}
{{
    config(
    target_schema='marts',
    unique_key='opportunity_id',
    strategy='timestamp',
    updated_at='lastmodifieddate',
    invalidate_hard_deletes=True
    )
}}
select {{ dbt_utils.generate_surrogate_key(['opportunity_id']) }} as dim_opportunity_key,	
t.* 
FROM {{ ref ('stg_salesforce__opportunity') }} t
{% endsnapshot %}