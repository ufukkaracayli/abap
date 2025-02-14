*---------------------------------------------------------------------
*                           HEADER
*---------------------------------------------------------------------
CLASS lhc_zexes1_r_lytpgmhdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zexes1_r_lytpgmhdr RESULT result.
    METHODS earlynumbering_create               FOR NUMBERING
      IMPORTING entities FOR CREATE loyaltyprogramheader.
    METHODS earlynumbering_cba_loyaltypgmt      FOR NUMBERING
      IMPORTING entities FOR CREATE loyaltyprogramheader\_loyaltypgmtransactions.
ENDCLASS.

CLASS lhc_zexes1_r_lytpgmhdr IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA:
      lylpts_pgm_hdr      TYPE STRUCTURE FOR CREATE zexes1_r_lytpgmhdr,
      currentmembershipid TYPE zukd_membershipid,
      use_number_range    TYPE abap_bool VALUE abap_true.

    "Ensure Travel ID is not set yet (idempotent)- must be checked when BO is draft-enabled
    LOOP AT entities INTO lylpts_pgm_hdr WHERE loyaltymembershipid IS NOT INITIAL.
      APPEND CORRESPONDING #( lylpts_pgm_hdr ) TO mapped-loyaltyprogramheader.
    ENDLOOP.

    DATA(lypts_pgm_hrds_wo_membershipid) = entities.
    "Remove the entries with an existing Travel ID
    DELETE lypts_pgm_hrds_wo_membershipid WHERE loyaltymembershipid IS NOT INITIAL.

    IF use_number_range = abap_true.
      "Get numbers
      TRY.
          cl_numberrange_runtime=>number_get(
            EXPORTING
              nr_range_nr       = '01'
              object            = 'ZEXES1_MID'
              quantity          = CONV #( lines( lypts_pgm_hrds_wo_membershipid ) )
            IMPORTING
              number            = DATA(number_range_key)
              returncode        = DATA(number_range_return_code)
              returned_quantity = DATA(number_range_returned_quantity)
          ).
        CATCH cx_number_ranges INTO DATA(lx_number_ranges).
          LOOP AT lypts_pgm_hrds_wo_membershipid INTO lylpts_pgm_hdr.
            APPEND VALUE #(  %cid      = lylpts_pgm_hdr-%cid
                             %key      = lylpts_pgm_hdr-%key
                             %is_draft = lylpts_pgm_hdr-%is_draft
                             %msg      = lx_number_ranges
                          ) TO reported-loyaltyprogramheader.
            APPEND VALUE #(  %cid      = lylpts_pgm_hdr-%cid
                             %key      = lylpts_pgm_hdr-%key
                             %is_draft = lylpts_pgm_hdr-%is_draft
                          ) TO failed-loyaltyprogramheader.
          ENDLOOP.
          EXIT.
      ENDTRY.

      "determine the first free travel ID from the number range
      currentmembershipid = number_range_key - number_range_returned_quantity.
    ELSE.
      "determine the first free travel ID without number range
      "Get max travel ID from active table
      SELECT SINGLE FROM zexes1_lytpgmhdr FIELDS MAX( lytmemid ) AS membershipid INTO @currentmembershipid.
      "Get max travel ID from draft table
      SELECT SINGLE FROM zexes1_pgmhdr_d FIELDS MAX( loyaltymembershipid ) INTO @DATA(max_membershipid_draft).
      IF max_membershipid_draft > currentmembershipid.
        currentmembershipid = max_membershipid_draft.
      ENDIF.
    ENDIF.

    "Set Travel ID for new instances w/o ID
    LOOP AT lypts_pgm_hrds_wo_membershipid INTO lylpts_pgm_hdr.
      currentmembershipid += 1.
      lylpts_pgm_hdr-loyaltymembershipid = currentmembershipid.

      APPEND VALUE #( %cid      = lylpts_pgm_hdr-%cid
                      %key      = lylpts_pgm_hdr-%key
                      %is_draft = lylpts_pgm_hdr-%is_draft
                    ) TO mapped-loyaltyprogramheader.
    ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_cba_loyaltypgmt.
    DATA:
      lylpts_pgm_txns1     TYPE STRUCTURE FOR CREATE zexes1_r_lytpgmhdr\_loyaltypgmtransactions,
      currenttransactionid TYPE zukd_transid,
      use_number_range     TYPE abap_bool VALUE abap_true.


    DATA(lypts_pgm_hdr_wo_transactionid) = entities[ 1 ]-%target.
    DELETE lypts_pgm_hdr_wo_transactionid WHERE loyaltypgmtransactionid NE 0.
    DELETE lypts_pgm_hdr_wo_transactionid WHERE %is_draft NE '01' .

    "Remove the entries with an existing Travel ID
    IF lines( lypts_pgm_hdr_wo_transactionid ) GT 0.
      "Get numbers
      TRY.
          cl_numberrange_runtime=>number_get(
            EXPORTING
              nr_range_nr       = '01'
              object            = 'ZEXES1_TX'
              quantity          = CONV #( lines( lypts_pgm_hdr_wo_transactionid ) )
            IMPORTING
              number            = DATA(number_range_key)
              returncode        = DATA(number_range_return_code)
              returned_quantity = DATA(number_range_returned_quantity)
          ).
        CATCH cx_number_ranges INTO DATA(lx_number_ranges).
          LOOP AT lypts_pgm_hdr_wo_transactionid INTO DATA(lylpts_pgm_txns).
            APPEND VALUE #(  %cid      = lylpts_pgm_txns-%cid
                             %key      = lylpts_pgm_txns-%key
                             %is_draft = lylpts_pgm_txns-%is_draft
                             %msg      = lx_number_ranges
                          ) TO reported-loyaltyprogramtransactions.
            APPEND VALUE #(  %cid      = lylpts_pgm_txns-%cid
                             %key      = lylpts_pgm_txns-%key
                             %is_draft = lylpts_pgm_txns-%is_draft
                          ) TO failed-loyaltyprogramtransactions.
          ENDLOOP.
          EXIT.
      ENDTRY.

      "determine the first free travel ID from the number range
      currenttransactionid = number_range_key - number_range_returned_quantity.

      "Set Travel ID for new instances w/o ID
      LOOP AT lypts_pgm_hdr_wo_transactionid INTO lylpts_pgm_txns.
        currenttransactionid += 1.
        lylpts_pgm_txns-loyaltypgmtransactionid = currenttransactionid.

        APPEND VALUE #( %cid      = lylpts_pgm_txns-%cid
                        %key      = lylpts_pgm_txns-%key
                        %is_draft = lylpts_pgm_txns-%is_draft
                      ) TO mapped-loyaltyprogramtransactions.
      ENDLOOP.
**    The else block is entered in the case of save (from draft) where the transactionID already exists and lines( lypts_pgm_hdr_wo_transactionid ) = 0
    ELSE.
      LOOP AT entities[ 1 ]-%target INTO DATA(lylpts_pgm_txn1).
        APPEND VALUE #( %cid  = lylpts_pgm_txn1-%cid
                        %key  = lylpts_pgm_txn1-%key ) TO mapped-loyaltyprogramtransactions.
        mapped-loyaltyprogramtransactions[ sy-tabix ]-%is_draft = lylpts_pgm_txn1-%is_draft.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
