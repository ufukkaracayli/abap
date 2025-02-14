@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_UKT_BPCHANGE
  provider contract transactional_query
  as projection on ZR_UKT_BPCHANGE
{
  key Id,
  Username,
  Partner,
  Mail,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
