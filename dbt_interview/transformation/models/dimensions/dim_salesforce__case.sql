with case_data as (
    select * from {{ ref ('dim_scd_salesforce__case') }}
    where case_id is not null
)
,
final as 
(
    select
        dim_case_key ,
        case_id,
        isdeleted,
        masterrecordid,
        casenumber,
        contactid,
        accountid,
        assetid,
        productid,
        entitlementid,
        sourceid,
        businesshoursid,
        parentid,
        suppliedname,
        suppliedemail,
        suppliedphone,
        suppliedcompany,
        type,
        status,
        reason,
        origin,
        subject,
        priority,
        description,
        isclosed,
        closeddate,
        isescalated,
        ownerid,
        isclosedoncreate,
        slastartdate,
        slaexitdate,
        isstopped,
        stopstartdate,
        createddate as case_created_date,
        createdbyid as case_created_by,
        lastmodifieddate as case_lastmodified_date,
        lastmodifiedbyid as case_case_lastmodified_by,
        systemmodstamp,
        servicecontractid,
        eventsprocesseddate,
        dbt_scd_id,
        dbt_updated_at,
        dbt_valid_from,
        dbt_valid_to
        from case_data 
        where 
        1=1
        --and dbt_valid_to is null
        --and case_id is not null
) 
select * from final 