@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Loyalty Program Header'
@ObjectModel.usageType:{
    sizeCategory: #XL,
    dataClass: #TRANSACTIONAL
}
define root view entity ZEXES1_R_LYTPGMHDR
  as select from zexes1_lytpgmhdr as LoyaltyProgramHeader
  composition [0..*] of ZEXES1_R_LYTPGMTRDET as _LoyaltyPgmTierDets
  composition [0..*] of ZEXES1_R_LYTPGMTXNS  as _LoyaltyPgmTransactions
{
  key LoyaltyProgramHeader.lytmemid         as LoyaltyMembershipID,
      LoyaltyProgramHeader.bpid             as BusinessPartnerID,
      LoyaltyProgramHeader.bpname           as BusinessPartnerName,
      LoyaltyProgramHeader.memsince         as loyaltypgmmembersince,
      LoyaltyProgramHeader.lytpoints_avl    as loyaltypgmPointsAvailable,
      LoyaltyProgramHeader.lytpoints_red    as loyaltypgmPointsRedeemed,

      //  Administrative fields
      @Semantics.systemDateTime.createdAt: true
      LoyaltyProgramHeader.lytmemcreation   as LoyaltyPgmMembershipCreatOn,
      @Semantics.user.createdBy: true
      LoyaltyProgramHeader.lytmemcreatby    as LoyaltyPgmMembershipCreatBy,
      @Semantics.systemDateTime.lastChangedAt: true
      LoyaltyProgramHeader.lytmemchngon     as LoyaltyPgmMembershipChngOn,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LoyaltyProgramHeader.lytmemlastchngat as LoyaltyPgmMembershipLclChngAt,
      @Semantics.user.localInstanceLastChangedBy: true
      LoyaltyProgramHeader.lytmemchngby     as LoyaltyPgmMembershipChngBy,

  
      _LoyaltyPgmTierDets, // Make association public
      _LoyaltyPgmTransactions // Make association public
}
