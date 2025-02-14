@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Loyal Points Program Tier Details'
define view entity ZEXES1_R_LYTPGMTRDET
  as select from zexes1_lytpgmtr as mem_tier
    join         zexes1_lyltier as tier_config on mem_tier.lyttierid = tier_config.lyltierid
  association        to parent ZEXES1_R_LYTPGMHDR      as _LoyaltyPgmMembershipHeader on $projection.LoyaltyPgmMembershipID = _LoyaltyPgmMembershipHeader.LoyaltyMembershipID
  association [1..1] to zexes1_LYLPTS_TIERSTA_DOM_VAL as _TierStatusText             on $projection.LoyaltyPgmTierStatus = _TierStatusText.Id
  association [1..1] to ZEXES1_LYLPTS_C_TIER_HDR_VH   as _TierText                   on $projection.LoyaltyPgmTierID = _TierText.LoyaltyTierID
{
  key mem_tier.lytmemid                as LoyaltyPgmMembershipID,
  key mem_tier.lyttierid               as LoyaltyPgmTierID,
  key mem_tier.lyttiervalidfrom        as LoyaltyPgmTierValidFrom,
      mem_tier.lyttierstatus           as LoyaltyPgmTierStatus,
      mem_tier.lyttierstatustext       as LoyaltyPgmTierStatusText,
      tier_config.lyltiercnt           as TierCountry,
      @Semantics.user.createdBy: true
      mem_tier.lytbptiercreatby        as LoyaltyBPPgmTierCreatBy,
      @Semantics.user.createdBy: true
      mem_tier.lytbptierchngby         as LoyaltyBPPgmTierChngBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      mem_tier.local_last_changed_at   as LocalLastChangedAt,
      mem_tier.tierwfapprovaldueby     as TierWfApprovalDueBy,
      _TierText.LoyaltyTierDescription as LoyaltyTierDescription,

      /* Associations */
      _LoyaltyPgmMembershipHeader,
      _TierStatusText,
      _TierText
}
