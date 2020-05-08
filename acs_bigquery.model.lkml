connection: "bigquery-public"
include: "*.view"
include: "/geography/*"

#OLD DYNAMIC EXPLORE
# explore: acs_census {
#   view_name: acs_census
#   always_filter: {
#     filters: [
#       geography: "blockgroup",
#       year:   "2017",
#       period: "5yr"
#     ]
#   }
# }


explore: acs_census_data {
  view_name: state
  label: "ACS Census Data"
  join: county {
    sql_on:  ${state.county_key} = ${county.state_key};;
    relationship: one_to_many
  }
  join: blockgroup  {
    sql_on: ${county.blockgroup_key} = ${blockgroup.county_key} ;;
    relationship: one_to_many
  }
}


explore: congressional_district {
  label: "Congressional Districts"
  join: state {
    sql_on: ${congressional_district.state_key} = ${state.county_key} ;;
    relationship: many_to_one
  }
}
