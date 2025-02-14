@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Loyal Points Transaction Details'
@Metadata.allowExtensions: true

define view entity ZEXES1_C_LYTPGMTXNS
  as projection on ZEXES1_R_LYTPGMTXNS as LoyaltyPgmTransactions
{
  key LoyaltyPgmMembershipID,
  key LoyaltyPgmTransactionID,
      LoyaltyPgmTransactionDate,
      LoyaltyPgmTransactionValue,
      LoyaltyPgmTransactionCurrency,
      LoyaltyPgmActivityType,
      LoyaltyPgmPoints,
      LoyaltyPgmTransDescription,

      /* Admininstrative fields */
      @UI.hidden: true
      LoyaltyPgmTransCreatOn,
      @UI.hidden: true
      LoyaltyPgmTransCreatBy,
      @UI.hidden: true
      LoyaltyPgmTransChngBy,
      @UI.hidden: true
      LocalLastChangedAt,

      /* Associations */
      _LoyaltyPgmMembershipHeader : redirected to parent ZEXES1_C_LYTPGMHDR
}
