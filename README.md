DIMENSIONS :


DIM_SALESFORCE__ACCOUNT:
Dimension on STG_SALESFORCE__ACCOUNT. 
Surrogate Key for this table is generated on account_id

DIM_SALESFORCE__CAMPAIGN:
Dimension on STG_SALESFORCE__CAMPAIGN. 
Surrogate Key for this table is generated on campaign_id



DIM_SALESFORCE__ACCOUNT.
This dimension is created on  STG_SALESFORCE__ACCOUNT 
Surrogate Key for this table is generated  on ACCOUNT_ID

DIM_SALESFORCE__CAMPAIGN.
This dimension is created on  STG_SALESFORCE__CAMPAIGN
Surrogate Key for this table is generated  on CAMPAIGN_ID


DIM_SALESFORCE__CUSTOMER:
Lead and Contact both are related to customers.
Lead - is a potential Customer, someone who can give you business
Contact- is a person who belongs to the Customer.
Both the entities has many common attributes, instead of having two seperate dimensions, I have merged them into a single dimension
dim_salesforce__customer.In order to identify which record belongs to what, I have introduced a column "contact_or_lead",
which will have values as "Contact" or "Lead" for their respective records.
Surrogate Key for this table is generated on respective ID 
Denormalising into a single table will help to remove additional join and hence we can have performance gain. If required 
we can partition on the contact_or_lead column if required for performance gain.

Note:DIM_SALESFORCE__CONTACT was additionally created in DB, This table needs to be dropped

DIM_SALESFORCE__PRODUCT:
This dimension is created on  STG_SALESFORCE__PRODUCT_2 
Surrogate Key for this table is generated  on   PRODUCT_ID 

DIM_SALESFORCE__OPPORTUNITY AND DIM_SALESFORCE__CASE are created on 
DIM_SCD_SALESFORCE__OPPORTUNITY and DIM_SCD_SALESFORCE__CASE are the 2 SCD type 2 (snapshots) created on STG_SALESFORCE__CASE
and STG_SALESFORCE__OPPORTUNITY,  

DIM_SALESFORCE__USER . contains the user dimensions

DIM_SALESFORCE__DATE  : this is the custom date dimension




FACTS:

FCT_SALESFORCE_REV.

contains the keys of all the dimensions , ids and the measures. This fact is incremenally matrialized and would append new records 
update any changed records based on unique keys (ids of the dimensions)


schema.yml 

generated the schema and relationships between the dimension tables and staging tables.







