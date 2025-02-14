@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lyl Pts Mgmt-Tier Configuration Text'
@ObjectModel.dataCategory: #TEXT
define view entity ZEXES1_LYLPTS_I_TIER_TEXT 
 as select from zexes1_lyltiert 
 association to parent ZEXES1_lylpts_i_tier_hdr as _TierConfiguration 
        on  $projection.LoyaltyTierID = _TierConfiguration.LoyaltyTierID
 association [0..*] to I_LanguageText        as _LanguageText   
        on $projection.LoyaltyTierDescriptionLanguage  = _LanguageText.LanguageCode

{
    key lyltierid       as LoyaltyTierID,
    key lyltierdesclang as LoyaltyTierDescriptionLanguage,   
    lyltierplanname     as LoyaltyTierPlanName,
    lyltierdesc         as LoyaltyTierDescription,
    lyltiercreaton      as LoyaltyTierTxtCreatOn,
    lyltiercreatby      as LoyaltyTierTxtCreatBy,
    lyltierchngon       as LoyaltyTierTxtChngOn,
    lyltierchngby       as LoyaltyTierTxtChngBy,
    
    /* Associations */
    _TierConfiguration,
    _LanguageText
}
