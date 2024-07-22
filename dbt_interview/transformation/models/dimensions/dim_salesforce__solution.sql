with solution as (
    select * from {{ ref ('stg_salesforce__solution') }}
    where solution_id is not null
)
select {{ dbt_utils.generate_surrogate_key(['solution_id']) }}	as dim_solution_key,
        solution_id,
        isdeleted is_solution_deleted,
        solutionnumber,
        solutionname,
        ispublished,
        ispublishedinpublickb,
        status,
        isreviewed,
        createddate,
        createdbyid,
        lastmodifieddate,
        lastmodifiedbyid,
        caseid as case_id
        from solution 
        