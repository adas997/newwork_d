with date_dim as (
    {{ dbt_date.get_date_dimension ("2000-01-01","2050-12-31") }}
)
select * from date_dim