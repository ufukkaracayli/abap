@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_UKT_BPMAIL
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_UKT_BPMAIL
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
