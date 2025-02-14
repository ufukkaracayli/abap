@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZUK_T_001'
define root view entity ZR_UK_T_001
  as select from zuk_t_001
{
  key id as ID,
  firstname as Firstname,
  lastname as Lastname,
  age as Age,
  role as Role,
  salary as Salary,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed as LastChanged,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed as LocalLastChanged
  
}
