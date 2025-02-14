@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lyl Pts Mgmt-Tier Config Details'
define view entity ZEXES1_LYLPTS_I_TIER_DETAILS 
 as select from zexes1_lyltrdt 
 association to parent ZEXES1_lylpts_i_tier_hdr as _TierConfiguration 
        on  $projection.LoyaltyTierID = _TierConfiguration.LoyaltyTierID
{
    key lyltierid      as LoyaltyTierID,
    key lyltiervalfrom as LoyaltyTierValidFrom,
    key lyltranscur    as LoyaltyTierTransactionCurrency,
    lyltiervalto       as LoyaltyTierValidTo,
    lyltierisvalid     as LoyaltyTierIsValid,
    lylaccuconval      as LoyaltyTierAccrualConvValue,
    lylrdmpconval      as LoyaltyTierRedemptionConvValue,
    lyltrdtcreaton     as LoyaltyTierDetailsCreatOn,
    lyltrdtcreatby     as LoyaltyTierDetailsCreatBy,
    lyltrdtchngon      as LoyaltyTierDetailsChngOn,
    lyltrdtchngby      as LoyaltyTierDetailsChngBy,
    
    /* Associations */
    _TierConfiguration
}
