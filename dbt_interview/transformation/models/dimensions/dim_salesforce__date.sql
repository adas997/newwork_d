with date_dimension as (
    select * from {{ ref('stg_salesforce_date') }}
),
full_dt as (
    {{ dbt_date.get_base_dates(start_date="2000-01-01", end_date="2050-12-31") }}
),
full_dt_tr as (
select
    d.*,
    f.date_day as fulldt,
    {{ dbt_date.convert_timezone("f.date_day", "Europe/Berlin", "EST") }} as dulldtz,
    {{ dbt_date.convert_timezone("f.date_day", "Europe/Berlin", source_tz="EST") }} as dulldtzt,
    {{ dbt_date.convert_timezone("f.date_day", "Europe/Berlin") }} as test,
    --f.date_day  AT TIME ZONE 'PST' AS "direct_pst",
    f.date_day::timestamp "direct_dts",
    f.date_day::timestamp AT TIME ZONE 'EST' AS "ts_est"
from
    date_dimension d
    left join full_dt f on d.date_day = cast(f.date_day as date)
)
select 
        {{ dbt_utils.generate_surrogate_key(['direct_dts']) }} as date_key,
    *
From full_dt_tr