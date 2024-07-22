with campaign_data as (
    select * from {{ ref ('stg_salesforce__campaign') }}
    where campaign_id is not null
)
select 
        {{ dbt_utils.generate_surrogate_key(['campaign_id']) }}	as dim_campaign_key,
        campaign_id,
        isdeleted as is_deleted,
        name as campaign_name,
        parentid,
        type as campaign_type,
        status as campaign_status,
        startdate as campaign_start_date,
        enddate as campaign_end_date,
        expectedresponse as expected_response,
        numbersent as number_sent,
        isactive as is_active,
        description as campaign_description,               
        ownerid,
        createddate as campaign_created_date,
        createdbyid as campaign_createdby_id,
        lastmodifieddate as campaign_lastmodified_date,
        lastmodifiedbyid as campaign_lastmodifiedby_id,       
        campaignmemberrecordtypeid as campaign_member_recordtype_id
    from campaign_data
