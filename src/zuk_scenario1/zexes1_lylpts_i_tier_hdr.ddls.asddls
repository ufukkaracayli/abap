@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lyl Pts Mgmt-Tier Configuration Header'
define root view entity ZEXES1_LYLPTS_I_TIER_HDR
  as select from zexes1_lyltier
  composition [0..*] of ZEXES1_lylpts_i_tier_text    as _TierConfigurationText
  composition [0..*] of ZEXES1_lylpts_i_tier_details as _TierConfigurationDetails

{
  key lyltierid        as LoyaltyTierID,
      lyltiercnt       as LoyaltyTierCountry,
      lyltierdefcur    as LoyaltyTierDefaultCurrency,
      lyltierisenabled as LoyaltyTierIsEnabled,
      lyltierapprover  as LoyaltyTierApprover,
      lyltierduedays   as LoyaltyTierChangeDueDays,
      lyltiercreaton   as LoyaltyTierCreatOn,
      lyltiercreatby   as LoyaltyTierCreatBy,
      lyltierchngon    as LoyaltyTierChngOn,
      lyltierchngby    as LoyaltyTierChngBy,

      /* Associations */
      _TierConfigurationText,
      _TierConfigurationDetails
}
