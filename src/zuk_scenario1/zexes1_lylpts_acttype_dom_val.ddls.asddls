@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Domain values for activity type'
define view entity zexes1_LYLPTS_ACTTYPE_DOM_VAL
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name : 'ZUKDO_ACTTYP' )
{
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @UI.hidden: true
  key language,
      @EndUserText.label: 'Activity Type'
      value_low,
      @EndUserText.label: 'Description'
      text
}
where
      language  =  'E'
  and value_low <> 'REDM'
