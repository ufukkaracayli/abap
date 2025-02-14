CLASS lhc_TierConfigurationHeader DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS earlynumbering_create               FOR NUMBERING
      IMPORTING entities FOR CREATE TierConfigurationHeader.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR TierConfigurationHeader RESULT result.
ENDCLASS.

CLASS lhc_TierConfigurationHeader IMPLEMENTATION.

  METHOD earlynumbering_create.
    DATA:
      lylpts_tier_hdr  TYPE STRUCTURE FOR CREATE zexes1_lylpts_i_tier_hdr,
      CurrentTierID    TYPE zukd_tierid,
      use_number_range TYPE abap_bool VALUE abap_true.

    "Ensure Travel ID is not set yet (idempotent)- must be checked when BO is draft-enabled
    LOOP AT entities INTO lylpts_tier_hdr WHERE LoyaltyTierID IS NOT INITIAL.
      APPEND CORRESPONDING #( lylpts_tier_hdr ) TO mapped-tierconfigurationheader.
    ENDLOOP.

    DATA(lypts_pgm_hrds_wo_tierid) = entities.
    "Remove the entries with an existing Travel ID
    DELETE lypts_pgm_hrds_wo_tierid WHERE LoyaltyTierID IS NOT INITIAL.

    IF use_number_range = abap_true.
      "Get numbers
      TRY.
          cl_numberrange_runtime=>number_get(
            EXPORTING
              nr_range_nr       = '1'
              object            = 'ZEXES1_TR'
              quantity          = CONV #( lines( lypts_pgm_hrds_wo_TIERid ) )
            IMPORTING
              number            = DATA(number_range_key)
              returncode        = DATA(number_range_return_code)
              returned_quantity = DATA(number_range_returned_quantity)
          ).
        CATCH cx_number_ranges INTO DATA(lx_number_ranges).
          LOOP AT lypts_pgm_hrds_wo_TIERid INTO lylpts_TIER_hdr.
            APPEND VALUE #(  %cid      = lylpts_TIER_hdr-%cid
                             %key      = lylpts_TIER_hdr-%key
                             %is_draft = lylpts_TIER_hdr-%is_draft
                             %msg      = lx_number_ranges
                          ) TO reported-tierconfigurationheader.
            APPEND VALUE #(  %cid      = lylpts_TIER_hdr-%cid
                             %key      = lylpts_TIER_hdr-%key
                             %is_draft = lylpts_TIER_hdr-%is_draft
                          ) TO failed-tierconfigurationheader.
          ENDLOOP.
          EXIT.
      ENDTRY.

      "determine the first free travel ID from the number range
      CurrentTIERID = number_range_key - number_range_returned_quantity.
    ENDIF.

    "Set TIER ID for new instances w/o ID
    LOOP AT lypts_pgm_hrds_wo_TIERid INTO lylpts_TIER_hdr.
      CurrentTIERID += 1.
      lylpts_TIER_hdr-LoyaltyTIERID = CurrentTIERID.

      APPEND VALUE #( %cid      = lylpts_tier_hdr-%cid
                      %key      = lylpts_tier_hdr-%key
                      %is_draft = lylpts_tier_hdr-%is_draft
                    ) TO mapped-tierconfigurationheader.
    ENDLOOP.
  ENDMETHOD.
  METHOD get_instance_features.
  ENDMETHOD.
ENDCLASS.
