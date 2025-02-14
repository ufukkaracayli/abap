@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Loyalty Points Mgmt-Tier Config Details'
@Metadata.allowExtensions: true
define view entity zexes1_LYLPTS_C_TIER_DETAILS 
 as projection on zexes1_lylpts_i_tier_details {
    key LoyaltyTierID,
    key LoyaltyTierValidFrom,
    key LoyaltyTierTransactionCurrency,
    LoyaltyTierValidTo,
    LoyaltyTierIsValid,
    LoyaltyTierAccrualConvValue,
    LoyaltyTierRedemptionConvValue,
    
    /* Admininstrative fields */
    @UI.hidden: true
    LoyaltyTierDetailsCreatOn,
    @UI.hidden: true
    LoyaltyTierDetailsCreatBy,
    @UI.hidden: true
    LoyaltyTierDetailsChngOn,
    @UI.hidden: true
    LoyaltyTierDetailsChngBy,
    
    /* Associations */
    _TierConfiguration : redirected to parent zexes1_lylpts_c_tier_hdr
}
