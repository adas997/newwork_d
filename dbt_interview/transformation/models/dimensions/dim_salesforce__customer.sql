with lead as (
		select
        lead_id as id ,
        isdeleted,
        masterrecordid,
		null as accountid,
        salutation,
        firstname||' '||lastname as name,
        title,
        company,
        street,
        city,
        state,
        postalcode,
        country,
		phone,
        mobilephone,
        fax,
        email,
		description,
		status,
		--annualrevenue,
		createddate,
        createdbyid,
        lastmodifieddate,
        lastmodifiedbyid,
		'Lead' as contact_or_lead
	from 	{{ ref ('stg_salesforce__lead') }}
	where lead_id is not null
	),
	contact as (
		select
        contact_id as id,
        isdeleted,
        masterrecordid,
        accountid,
        salutation,
        firstname||' '||lastname as name,
        title,
		null as company,
		mailingstreet as street ,
		mailingcity as city,
        mailingstate as state,
        mailingpostalcode as postalcode,
		mailingcountry as country,
		phone,
		mobilephone,
		fax,
		email,
		description,
		cleanstatus as status,
		--null as annualrevenue,
		createddate ,
        createdbyid  ,
		lastmodifieddate ,
        lastmodifiedbyid ,
		'Contact' as contact_or_lead
	from 	{{ ref ('stg_salesforce__contact') }}
	where contact_id is not null
	)
	select {{ dbt_utils.generate_surrogate_key(['id']) }}	as dim_customer_key,
	id as customer_id,
	isdeleted as is_deleted,
    masterrecordid as master_record_id,
    accountid as account_id,
    salutation,
	name as customer_name,
	title as customer_title,
	company,
	street,
	city,
	state,
	postalcode,
	country,
	phone,
	mobilephone,
	fax,
	email,
	description,
	status,
	--annualrevenue as annual_revenue,
	createddate as created_date,
    createdbyid as created_by,
	lastmodifieddate as lastmodified_date,
    lastmodifiedbyid as lastmodified_by,
	contact_or_lead
	from
	(
	select l.*
	from lead  l
	union all
	select c.* 
	from contact c 
	)