with user_data as (
    select * from {{ ref ('stg_salesforce__user') }}
)
select
        {{ dbt_utils.generate_surrogate_key(['user_id']) }}	as dim_user_key,
		user_id,
        username user_nick_name,
        firstname||' '||lastname as user_full_name,
        companyname,
        division,
        department,
        title,
        street,
        city,
        state,
        postalcode,
        country,
		email,
        senderemail,
        sendername,
        signature,
		phone,
        fax,
        mobilephone,
		profileid,
        usertype as user_type,
        usersubtype as user_subtype,
		u.createddate as created_date,
        u.createdbyid as created_by,
        u.lastmodifieddate as last_modified_date,
        u.lastmodifiedbyid as last_modified_by,
		contactid as contact_id,
        accountid as account_id,
        u.userroleid as user_role_id,
        isactive as is_active,
        ur.name,
        ur.parentroleid,
        ur.rollupdescription,
     from  user_data  u
     left join {{ ref ('stg_salesforce__user_role') }} ur
     on u.userroleid = ur.user_role_id