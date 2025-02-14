CLASS zcl_exes1_pgmhdr_vfields DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EXES1_PGMHDR_VFIELDS IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA: bo_context_data TYPE STANDARD TABLE OF zexes1_c_lytpgmhdr WITH DEFAULT KEY.
    TYPES: BEGIN OF t_pgm_tier,
             LoyaltyPgmMembershipID    TYPE zukd_membershipid,
             LoyaltyPgmTierID          TYPE zukd_tierid,
             loyaltypgmPointsAvailable TYPE i,
           END OF t_pgm_tier.

    DATA: pgm_tier TYPE TABLE OF t_pgm_tier.
    DATA: valid_points TYPE i.

    bo_context_data = CORRESPONDING #(  it_original_data   ).
    " Update the context data
    SELECT LoyaltyPgmMembershipID, LoyaltyPgmTierID
             FROM zexes1_r_lytpgmtrdet
             FOR ALL ENTRIES IN @bo_context_data
             WHERE LoyaltyPgmMembershipID = @bo_context_data-LoyaltyMembershipID
             INTO TABLE @pgm_tier.
    IF sy-subrc EQ 0.

      SELECT LoyaltyPgmMembershipID, LoyaltyPgmTransactionID, LoyaltyPgmTransactionValue
            FROM zexes1_r_lytpgmtxns
            FOR ALL ENTRIES IN @bo_context_data
            WHERE LoyaltyPgmMembershipID = @bo_context_data-LoyaltyMembershipID
            INTO TABLE @DATA(pgm_txns).

      SORT bo_context_data BY LoyaltyMembershipID ASCENDING.
      SORT pgm_tier BY LoyaltyPgmMembershipID ASCENDING.
      SORT pgm_txns BY LoyaltyPgmMembershipID LoyaltyPgmTransactionID .
      LOOP AT bo_context_data ASSIGNING FIELD-SYMBOL(<context>) WHERE LoyaltyMembershipID IS NOT INITIAL.
        CLEAR valid_points.
        ASSIGN pgm_tier[ LoyaltyPgmMembershipID = <context>-LoyaltyMembershipID ] TO FIELD-SYMBOL(<fs_pgm_tier>).
        IF sy-subrc EQ 0.
        ENDIF.
        <context>-loyaltypgmPointsAvailable = valid_points.
      ENDLOOP.
      ct_calculated_data = CORRESPONDING #( bo_context_data ).
    ENDIF.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.
ENDCLASS.
