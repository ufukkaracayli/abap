@EndUserText.label: 'ExtExp - Loyalty Program Category Config'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'loyaltyProgramTierH'
  }
}
define root view entity ZEXES1_LYLPTS_I_TIER_HDRs
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZI_LOYALTYPOINTSMANAGE'
  association [0..*] to I_ABAPTransportRequestText as _I_ABAPTransportRequestText on $projection.TransportRequestID = _I_ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZI_LoyaltyPointsManage as _LoyaltyPointsManage
{
  @UI.facet: [ {
    id: 'ZI_LoyaltyPointsManage', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Loyalty Points Management - Tier Configu', 
    position: 1 , 
    targetElement: '_LoyaltyPointsManage'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _LoyaltyPointsManage,
  @UI.hidden: true
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  @ObjectModel.text.association: '_I_ABAPTransportRequestText'
  @UI.identification: [ {
    position: 2 , 
    type: #WITH_INTENT_BASED_NAVIGATION, 
    semanticObjectAction: 'manage'
  } ]
  @Consumption.semanticObject: 'CustomizingTransport'
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  _I_ABAPTransportRequestText
  
}
where I_Language.Language = $session.system_language
