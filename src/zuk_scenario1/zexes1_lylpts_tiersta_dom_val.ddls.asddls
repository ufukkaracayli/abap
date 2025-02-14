@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Get the tier domain values'
define view entity zexes1_LYLPTS_TIERSTA_DOM_VAL  
as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZUKDO_STATUS' )
association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
 @UI.hidden: true
  key domain_name,
 @UI.hidden: true 
  key value_position,  
  @UI.hidden: true
  @Semantics.language
  key language as Language,
  @EndUserText.label: 'Tier Status'
  @ObjectModel.text.element: ['Text']
  key value_low as Id, 
  @EndUserText.label: 'Description'
  @Semantics.text: true
  text as Text,
  _Language

}
