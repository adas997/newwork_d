{% snapshot dim_scd_salesforce__case %}
{{
    config(
    target_schema='marts',
    unique_key='case_id',
    strategy='timestamp',
    updated_at='lastmodifieddate',
    invalidate_hard_deletes=True
    )
}}
select  {{ dbt_utils.generate_surrogate_key(['case_id']) }} as dim_case_key,	
t.*
 FROM {{ ref ('stg_salesforce__case') }} t 
{% endsnapshot %}