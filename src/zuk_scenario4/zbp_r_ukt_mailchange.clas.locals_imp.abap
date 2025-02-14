CLASS lsc_zr_ukt_mailchange DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.
    METHODS SAVE_MODIFIED REDEFINITION.


ENDCLASS.

CLASS lsc_zr_ukt_mailchange IMPLEMENTATION.

  METHOD SAVE_MODIFIED.
  endmethod.
  METHOD adjust_numbers.
   "buffer daki bütün kayıtlar alınır
    READ ENTITY IN LOCAL MODE zr_ukt_mailchange "" Root view
     ALL FIELDS WITH VALUE #( FOR ls_bp IN mapped-zruktmailchange ( %pky = ls_bp-%pre ) )
     RESULT DATA(lt_partners).

    "prepare the create requests
    LOOP AT mapped-zruktmailchange ASSIGNING FIELD-SYMBOL(<lfs_buspartner>).
*      TRY.
*          "get the record from transaction buffer for this key
          DATA(ls_partner) = REF #( lt_partners[ KEY pid COMPONENTS %pid = <lfs_buspartner>-%pid
                                                                  %key = <lfs_buspartner>-%tmp ] ).
*          "new BAPI request
*          DATA(ls_bapi_request) = VALUE ty_s_bapi_request( pid = lr_bonus->%pid ).
*
*          "fill header
*          fill_header(
*            EXPORTING is_bonus = lr_bonus->*
*            IMPORTING es_header = ls_bapi_request-header ).
*
*          "fill amounts and account information
*          "Every payment is a combination of a debit and credit item
*          fill_amounts(
*             EXPORTING is_bonus_payment = lr_bonus->%data
*                       is_header = ls_bapi_request-header
*             CHANGING  ct_amounts = ls_bapi_request-currency_amount
*                       ct_accounts = ls_bapi_request-accountgl ).
*
*          "call the BAPI
*          DATA(ls_bapi_result) = VALUE ty_s_bapi_result( pid = ls_bapi_request-pid ).
*          CALL FUNCTION 'BAPI_ACC_DOCUMENT_POST'
*            EXPORTING
*              documentheader = ls_bapi_request-header
*            IMPORTING
*              obj_key        = ls_bapi_result-acct_doc_key
*            TABLES
*              accountgl      = ls_bapi_request-accountgl
*              currencyamount = ls_bapi_request-currency_amount
*              return         = ls_bapi_result-msg.
*
*          "handle errors
*          handle_bapi_result(  EXPORTING is_result = ls_bapi_result
*                               CHANGING cs_reported = reported ).
*
*        CATCH zcx_demo_rap_facade_web_api INTO DATA(lx_bapi_error).
*          "log error reason
*          APPEND VALUE #( %pky = <ls_bonus_key>-%pre
*                          %msg = lx_bapi_error ) TO reported-bonuspayment.
*          "BAPI call or preparation failed
*          INSERT VALUE #( %pky = <lfs_buspartner>-%pre
*                          %create = if_abap_behv=>mk-on
*          ) INTO TABLE failed-zruktmailchange.
*      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS LHC_ZR_UKT_MAILCHANGE DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrUktMailchange
        RESULT result.
ENDCLASS.

CLASS LHC_ZR_UKT_MAILCHANGE IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
ENDCLASS.
