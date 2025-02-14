@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lyl Pts Mgmt-Tier Configuration Header'
@Metadata.allowExtensions: true
define root view entity zexes1_LYLPTS_C_TIER_HDR
  provider contract transactional_query
  as projection on ZEXES1_LYLPTS_I_TIER_HDR
{
  key LoyaltyTierID,
      LoyaltyTierCountry,
      LoyaltyTierDefaultCurrency,
      LoyaltyTierIsEnabled,
      LoyaltyTierApprover,
      LoyaltyTierChangeDueDays,

      /* Admininstrative fields */
      @UI.hidden: true
      LoyaltyTierCreatOn,
      @UI.hidden: true
      LoyaltyTierCreatBy,
      @UI.hidden: true
      LoyaltyTierChngOn,
      @UI.hidden: true
      LoyaltyTierChngBy,

      /* Associations */
      _TierConfigurationDetails : redirected to composition child zexes1_LYLPTS_C_TIER_DETAILS,
      _TierConfigurationText    : redirected to composition child zexes1_LYLPTS_C_TIER_TEXT
}

