@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_UK_T_001'
define root view entity ZC_UK_T_001
  provider contract transactional_query
  as projection on ZR_UK_T_001
{
  key ID,
  Firstname,
  Lastname,
  Age,
  Role,
  Salary,
  LocalLastChanged
  
}
