{{
config(
materialized = 'incremental',
on_schema_change='ignore',
unique_key = ['account_id','opportunity_id','campaign_id','product_id','case_id','customer_id','user_id']
)
}}
with fct_revenue as(
select  
{{ dbt_utils.generate_surrogate_key(['a.account_id']) }}	as dim_account_key,
o.dim_opportunity_key,
{{ dbt_utils.generate_surrogate_key(['c.campaign_id']) }}	as dim_campaign_key,
{{ dbt_utils.generate_surrogate_key(['p.product_id']) }}	as dim_product_key,
cs.dim_case_key,
cu.dim_customer_key,
u.dim_user_key,
a.account_id,
o.opportunity_id,
c.campaign_id,
p.product_id,
cs.case_id,
cu.customer_id,
u.user_id,
a.annualrevenue as annual_revenue,
o.amount as opportunity_amount,
o.probability,
o.expectedrevenue as opportunity_expected_revenue,
o.totalopportunityquantity total_opportunity_quantity,
c.budgetedcost campaign_budgeted_cost,
c.actualcost campaign_actual_coset,
c.expectedrevenue as campaign_expected_revenue,
c.numberofleads as campaign_numberofleads,
c.numberofconvertedleads as campaign_numberofconvertedleads,
c.numberofcontacts as campaign_numberofcontacts,
c.numberofresponses as campaign_numberofresponses,
c.numberofopportunities as campaign_numberofopportunities ,
c.hierarchynumberofleads as  campaign_hierarchynumberofleads,
c.hierarchynumberofconvertedleads as campaign_hierarchynumberofconvertedleads,
c.hierarchynumberofcontacts as  campaign_hierarchynumberofcontacts,
c.hierarchynumberofresponses  as campaign_hierarchynumberofresponses,
c.hierarchynumberofopportunities as campaign_hierarchynumberofopportunities ,
c.hierarchynumbersent as campaign_hierarchynumbersent,
c.hierarchyexpectedrevenue as campaign_hierarchyexpectedrevenue ,
c.hierarchybudgetedcost as campaign_hierarchybudgetedcost ,
c.hierarchyactualcost as campaign_hierarchyactualcost ,
p.stockkeepingunit as prod_stockkeepingunit,
p.quantityunitofmeasure as prod_quantityunitofmeasure,
a.lastmodifieddate as account_last_modified_date,
o.lastmodifieddate as opportunity_last_modified_date,
c.lastmodifieddate as campaign_last_modified_date,
pr.lastmodifieddate as price_last_modified_date,
p.lastmodifieddate as product_last_modified_date,
cs.case_lastmodified_date,
cu.lastmodified_date as customer_last_modified_date,
u.last_modified_date as user_last_modified_date
from {{ ref ('stg_salesforce__account') }} a
left join {{ ref ('dim_salesforce__opportunity') }}  o on (o.accountid = a.account_id)
left join {{ ref ('stg_salesforce__campaign') }}  c on (o.campaignid = c.campaign_id)
left join {{ ref ('stg_salesforce__pricebook_entry') }}  pr on (pr.pricebook2id = o.pricebook2id)
left join {{ ref ('stg_salesforce__product_2') }}  p on (p.product_id = pr.product2id)
left join {{ ref ('dim_salesforce__case') }}  cs on (cs.productid = p.product_id and cs.accountid = a.account_id )
left join {{ ref ('dim_salesforce__customer') }}  cu on (cu.customer_id = cs.contactid)
left join {{ ref ('dim_salesforce__user') }} u on (u.account_id = a.account_id and u.contact_id = cu.customer_id )
where cs.dbt_valid_to is null 
and cu.contact_or_lead = 'Contact'
and o.dbt_valid_to is null  
)
select * from fct_revenue

{% if is_incremental() %}
where (
    account_last_modified_date > (select max(account_last_modified_date) from {{ this }})
    or 
    opportunity_last_modified_date > (select max(opportunity_last_modified_date) from {{ this }})
    or
        campaign_last_modified_date > (select max(campaign_last_modified_date) from {{ this }})
        or
        price_last_modified_date > (select max(price_last_modified_date) from {{ this }})
        or
        product_last_modified_date > (select max(product_last_modified_date) from {{ this }})
        or
        case_lastmodified_date > (select max(case_lastmodified_date) from {{ this }})
        or
        customer_last_modified_date > (select max(customer_last_modified_date) from {{ this }})
        or
       user_last_modified_date > (select max(user_last_modified_date) from {{ this }})
)
{% endif %}
