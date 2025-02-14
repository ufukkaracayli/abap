@EndUserText.label: 'Loyalty Pts Mgmt - Tier value help'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZEXES1_LYLPTS_C_TIER_HDR_VH
  as select from zexes1_lyltier
  association [0..*] to ZEXES1_LYLPTS_I_TIER_TEXT as _TierConfigurationText
 
  on  _TierConfigurationText.LoyaltyTierID                  = $projection.LoyaltyTierID
  and _TierConfigurationText.LoyaltyTierDescriptionLanguage = 'E'
{
      @EndUserText.label: 'Category ID'
      @ObjectModel.text.element: ['LoyaltyTierDescription']
  key zexes1_lyltier.lyltierid                      as LoyaltyTierID,
      zexes1_lyltier.lyltiercnt                     as LoyaltyTierCountry,
      zexes1_lyltier.lyltierdefcur                  as LoyaltyTierDefaultCurrency,

      @EndUserText.label: 'LoyaltyTierDescription'
      @Semantics.text: true
      _TierConfigurationText.LoyaltyTierDescription as LoyaltyTierDescription,

      /* Associations */
      _TierConfigurationText
}

where
  zexes1_lyltier.lyltierisenabled = 'X'
