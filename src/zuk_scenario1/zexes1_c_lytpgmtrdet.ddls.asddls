@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Loyal Points Program Tier Details'
@Metadata.allowExtensions: true
define view entity ZEXES1_C_LYTPGMTRDET
  as projection on ZEXES1_R_LYTPGMTRDET
{
  key LoyaltyPgmMembershipID,
  key LoyaltyPgmTierID,
  key LoyaltyPgmTierValidFrom,
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: ['TierStatusText']
      LoyaltyPgmTierStatus,
      _TierStatusText.Text as TierStatusText,
      LoyaltyPgmTierStatusText,
      TierCountry,
      /* Admininstrative fields */
      @UI.hidden: true
      LoyaltyBPPgmTierCreatBy,
      @UI.hidden: true
      LoyaltyBPPgmTierChngBy,
      @UI.hidden: true
      LocalLastChangedAt,
      TierWfApprovalDueBy,

      /* Associations */
      _LoyaltyPgmMembershipHeader : redirected to parent ZEXES1_C_LYTPGMHDR

}
