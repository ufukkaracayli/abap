@EndUserText.label: 'Loyalty Points Management - Tier Configu'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_LoyaltyPointsManage
  as select from ZEXES1_LYLTIER
  association to parent ZEXES1_LYLPTS_I_TIER_HDRs as _loyaltyProgramTierH on $projection.SingletonID = _loyaltyProgramTierH.SingletonID
{
  key LYLTIERID as Lyltierid,
  LYLTIERCNT as Lyltiercnt,
  LYLTIERDEFCUR as Lyltierdefcur,
  LYLTIERISENABLED as Lyltierisenabled,
  LYLTIERAPPROVER as Lyltierapprover,
  LYLTIERDUEDAYS as Lyltierduedays,
  LYLTIERCREATON as Lyltiercreaton,
  LYLTIERCREATBY as Lyltiercreatby,
  LYLTIERCHNGON as Lyltierchngon,
  LYLTIERCHNGBY as Lyltierchngby,
  @Consumption.hidden: true
  1 as SingletonID,
  _loyaltyProgramTierH
  
}
