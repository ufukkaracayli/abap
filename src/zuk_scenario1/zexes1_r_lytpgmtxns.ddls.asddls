@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lyt Pts Transaction Details'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    sizeCategory: #XL,
    dataClass: #TRANSACTIONAL
}
define view entity ZEXES1_R_LYTPGMTXNS
  as select from zexes1_lytpgmtxn as _LoyaltyPgmTransactions
  association to parent ZEXES1_R_LYTPGMHDR as _LoyaltyPgmMembershipHeader on $projection.LoyaltyPgmMembershipID = _LoyaltyPgmMembershipHeader.LoyaltyMembershipID
{
  key lytmemid              as LoyaltyPgmMembershipID,
  key lyttxnid              as LoyaltyPgmTransactionID,
      lyttxndt              as LoyaltyPgmTransactionDate,
      lyttxnval             as LoyaltyPgmTransactionValue,
      lyttxncur             as LoyaltyPgmTransactionCurrency,
      lytacttyp             as LoyaltyPgmActivityType,
      lytpoints             as LoyaltyPgmPoints,
      lyttxndesc            as LoyaltyPgmTransDescription,

      //  Administrative fields
      @Semantics.systemDateTime.createdAt: true
      lyttxncreaton         as LoyaltyPgmTransCreatOn,

      @Semantics.user.createdBy: true
      lyttxncreatby         as LoyaltyPgmTransCreatBy,

      @Semantics.user.lastChangedBy: true
      lyttxnchngby          as LoyaltyPgmTransChngBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      /* Associations */
      _LoyaltyPgmMembershipHeader
}
