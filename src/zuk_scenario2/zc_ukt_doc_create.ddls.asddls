@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_UKT_DOC_CREATE
  provider contract transactional_query
  as projection on ZR_UKT_DOC_CREATE
{
  key Id,
  Username,
  Company,
  Role,
  Docdate,
  Invoiced,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
