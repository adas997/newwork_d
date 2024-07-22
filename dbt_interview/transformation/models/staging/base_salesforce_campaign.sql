with source as (
      select * from {{ source('salesforce', 'campaign') }}
),
renamed as (
    select
        {{ adapter.quote("id") }},
        {{ adapter.quote("isdeleted") }},
        {{ adapter.quote("name") }},
        {{ adapter.quote("parentid") }},
        {{ adapter.quote("type") }},
        {{ adapter.quote("status") }},
        {{ adapter.quote("startdate") }},
        {{ adapter.quote("enddate") }},
        {{ adapter.quote("expectedrevenue") }},
        {{ adapter.quote("budgetedcost") }},
        {{ adapter.quote("actualcost") }},
        {{ adapter.quote("expectedresponse") }},
        {{ adapter.quote("numbersent") }},
        {{ adapter.quote("isactive") }},
        {{ adapter.quote("description") }},
        {{ adapter.quote("numberofleads") }},
        {{ adapter.quote("numberofconvertedleads") }},
        {{ adapter.quote("numberofcontacts") }},
        {{ adapter.quote("numberofresponses") }},
        {{ adapter.quote("numberofopportunities") }},
        {{ adapter.quote("numberofwonopportunities") }},
        {{ adapter.quote("amountallopportunities") }},
        {{ adapter.quote("amountwonopportunities") }},
        {{ adapter.quote("hierarchynumberofleads") }},
        {{ adapter.quote("hierarchynumberofconvertedleads") }},
        {{ adapter.quote("hierarchynumberofcontacts") }},
        {{ adapter.quote("hierarchynumberofresponses") }},
        {{ adapter.quote("hierarchynumberofopportunities") }},
        {{ adapter.quote("hierarchynumberofwonopportunities") }},
        {{ adapter.quote("hierarchyamountallopportunities") }},
        {{ adapter.quote("hierarchyamountwonopportunities") }},
        {{ adapter.quote("hierarchynumbersent") }},
        {{ adapter.quote("hierarchyexpectedrevenue") }},
        {{ adapter.quote("hierarchybudgetedcost") }},
        {{ adapter.quote("hierarchyactualcost") }},
        {{ adapter.quote("ownerid") }},
        {{ adapter.quote("createddate") }},
        {{ adapter.quote("createdbyid") }},
        {{ adapter.quote("lastmodifieddate") }},
        {{ adapter.quote("lastmodifiedbyid") }},
        {{ adapter.quote("systemmodstamp") }},
        {{ adapter.quote("lastactivitydate") }},
        {{ adapter.quote("campaignmemberrecordtypeid") }}

    from source
)
select * from renamed
  