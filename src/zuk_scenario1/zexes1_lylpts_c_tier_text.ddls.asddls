@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lyl Pts Mgmt-Tier Configuration Text'
@Metadata.allowExtensions: true
define view entity zexes1_LYLPTS_C_TIER_TEXT 
 as projection on zexes1_lylpts_i_tier_text as loyaltyProgramTierText 

 {
    key LoyaltyTierID,
    
    @Consumption.valueHelpDefinition: [ {entity: {name: 'I_Language', element: 'Language' } , label: 'Language'} ]
    @EndUserText.label: 'Language'
    key LoyaltyTierDescriptionLanguage,
    LoyaltyTierPlanName,
    LoyaltyTierDescription,
    
    /* Admininstrative fields */
    @UI.hidden: true
    LoyaltyTierTxtCreatOn,
    @UI.hidden: true
    LoyaltyTierTxtCreatBy,
    @UI.hidden: true
    LoyaltyTierTxtChngOn,
    @UI.hidden: true
    LoyaltyTierTxtChngBy,
    
    /* Associations */
    _TierConfiguration : redirected to parent zexes1_lylpts_c_tier_hdr,
    _LanguageText
}
