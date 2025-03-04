CLASS lsc_zi_compo_author DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_compo_author IMPLEMENTATION.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_stock DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR stock RESULT    result.

    METHODS CorrectStock FOR MODIFY
      IMPORTING keys FOR ACTION stock~CorrectStock.

    METHODS CreateOrder FOR MODIFY
      IMPORTING keys FOR ACTION stock~CreateOrder  .

    METHODS ManageDeliveredBooks FOR MODIFY
      IMPORTING keys FOR ACTION stock~ManageDeliveredBooks  .

ENDCLASS.

CLASS lhc_stock IMPLEMENTATION.

  METHOD get_instance_features.

  ENDMETHOD.

  METHOD CorrectStock.
    DATA: lt_update TYPE TABLE  for UPDATE  zi_compo_stock_g2.

    LOOP AT keys INTO DATA(ls_key).
      APPEND VALUE #( %tky = ls_key-%tky
                          CurrentStock = ls_key-%param-Correct_stock
                    %control-CurrentStock =  if_abap_behv=>mk-on


                              ) TO lt_update.
    ENDLOOP.

    MODIFY ENTITIES OF zi_compo_author IN LOCAL MODE
      ENTITY stock
      update
      from lt_update.


*    result  =  CORRESPONDING #( keys ) .
    mapped-stock = CORRESPONDING #( keys ) .
  ENDMETHOD.
*
 METHOD CreateOrder.
  DATA: lt_order_items TYPE TABLE FOR UPDATE  zi_compo_stock_g2.

    LOOP AT keys INTO DATA(ls_key).
      TRY.
          APPEND VALUE #( %tky = ls_key-%tky

                          Backorder = ls_key-%param-Create_order


                          %control-bookid = if_abap_behv=>mk-on
                          %control-Backorder = if_abap_behv=>mk-on

                        ) TO lt_order_items.
        CATCH cx_uuid_error.
          "handle exception
      ENDTRY.
    ENDLOOP.
 MODIFY ENTITIES OF zi_compo_author IN LOCAL MODE
      ENTITY stock
      update
      from lt_order_items.


*    result  =  CORRESPONDING #( keys ) .
    mapped-stock = CORRESPONDING #( keys ) .
ENDMETHOD.




 METHOD ManageDeliveredBooks.
*



   DATA:
      lt_delivered TYPE TABLE FOR UPDATE zi_compo_stock_g2.

    " Check if keys is not initial
    CHECK keys IS NOT INITIAL.

    " Get the delivered quantity
    DATA(lv_delivered_qty) = keys[ 1 ]-%param-Manage_delivered_books.

    " Prepare update for each book
    LOOP AT keys REFERENCE INTO DATA(ls_key).
      " Fetch current stock for each book
      SELECT SINGLE
        CurrentStock,
        Backorder
      FROM zi_compo_stock_g2
      WHERE bookid = @ls_key->bookid
      INTO @DATA(ls_stock).

      IF sy-subrc = 0.
      DATA(lv_new_backorder) = COND int4(
          WHEN ls_stock-backorder >= lv_delivered_qty
          THEN ls_stock-backorder - lv_delivered_qty
          ELSE '0000000000'
        ).

        APPEND VALUE #(
          %tky = ls_key->%tky
          bookid = ls_key->bookid
          CurrentStock = ls_stock-CurrentStock + lv_delivered_qty
          Backorder = lv_new_backorder
          %control-CurrentStock = if_abap_behv=>mk-on
          %control-Backorder = if_abap_behv=>mk-on
        ) TO lt_delivered.
      ENDIF.
    ENDLOOP.

    " Modify entities
    MODIFY ENTITIES OF zi_compo_author IN LOCAL MODE
      ENTITY stock
      UPDATE
      FROM lt_delivered.

    mapped-stock = CORRESPONDING #( keys ).

*
*   DATA:
*      lt_delivered TYPE TABLE FOR UPDATE zi_compo_stock_g2.
*
*    " Check if keys is not initial
*    CHECK keys IS NOT INITIAL.
*
*    " Get the delivered quantity
*    DATA(lv_delivered_qty) = keys[ 1 ]-%param-Manage_delivered_books.
*
*    " Prepare update for each book
*    LOOP AT keys REFERENCE INTO DATA(ls_key).
*      " Fetch current stock for each book
*      SELECT SINGLE
*        CurrentStock,
*        Backorder
*      FROM zi_compo_stock_g2
*      WHERE bookid = @ls_key->bookid
*      INTO @DATA(ls_stock).
*
*      IF sy-subrc = 0.
*
*
*        APPEND VALUE #(
*          %tky = ls_key->%tky
*          bookid = ls_key->bookid
*          CurrentStock = ls_stock-CurrentStock + lv_delivered_qty
*          Backorder = ls_stock-Backorder - lv_delivered_qty
*          %control-CurrentStock = if_abap_behv=>mk-on
*          %control-Backorder = if_abap_behv=>mk-on
*        ) TO lt_delivered.
*      ENDIF.
*    ENDLOOP.
*
*    " Modify entities
*    MODIFY ENTITIES OF zi_compo_author IN LOCAL MODE
*      ENTITY stock
*      UPDATE
*      FROM lt_delivered.
*
*    mapped-stock = CORRESPONDING #( keys ).


ENDMETHOD.


ENDCLASS.

CLASS lhc_author DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR author RESULT result.

    METHODS precheck_delete FOR PRECHECK
      IMPORTING keys FOR DELETE author.

*    METHODS CorrectStock FOR MODIFY
*      IMPORTING keys FOR ACTION author~CorrectStock RESULT result.
*
*    METHODS CreateOrder FOR MODIFY
*      IMPORTING keys FOR ACTION author~CreateOrder RESULT result.
*
*    METHODS ManageDeliveredBooks FOR MODIFY
*      IMPORTING keys FOR ACTION author~ManageDeliveredBooks RESULT result.

    METHODS validateBirthdate FOR VALIDATE ON SAVE
      IMPORTING keys FOR  author~validateBirthdate.

*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR author RESULT result.

ENDCLASS.

CLASS lhc_author IMPLEMENTATION.

  " 📌 Precheck Before Deleting an Author
  METHOD precheck_delete.

 LOOP AT keys INTO DATA(ls_author).
    DATA(lv_author_id) = ls_author-AuthorId.
    DATA(lv_block_delete) = abap_false.  " Initialize to false (allow deletion by default)

    SELECT * FROM zbook09 AS b JOIN zauthor09 AS a
      ON b~author_id = a~author_id
      WHERE a~author_id = @lv_author_id
      INTO TABLE @DATA(lt_books).

    " *** KEY CHANGE: Check stock ONLY if books exist ***
    IF lt_books IS NOT INITIAL.  " Author has books
      LOOP AT lt_books INTO DATA(ls_book).
        IF ls_book-b-current_stock > 0.
          lv_block_delete = abap_true.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.

    IF lv_block_delete = abap_true.
      APPEND VALUE #( %tky = ls_author-%tky ) TO failed-author.
      APPEND VALUE #( %tky = ls_author-%tky
                      %element-authorid = if_abap_behv=>mk-on
                      %msg = new_message( id       = 'ZM_MESSAGES_G2'
                                          number   = '002'
                                          severity = if_abap_behv_message=>severity-error )
                    ) TO reported-author.
    ENDIF.

  ENDLOOP.

    ENDMETHOD.


    " Check the orders






*    " 📌 Correct Stock Levels
*    METHOD CorrectStock.
**    DATA: lt_update TYPE TABLE OF zbook09.
**
**    " Read books from database
**    SELECT * FROM zbook09 INTO TABLE @lt_update WHERE book_id IN @keys.
**
**    MODIFY ENTITIES OF zi_compo_author
**      ENTITY stock
**      FIELDS current_stock.
**
**
**    RETURN.
*    ENDMETHOD.
*
*    " 📌 Create an Order for Restocking Books
*    METHOD CreateOrder.
**    DATA: ls_order TYPE zbook09.
**
**    LOOP AT keys INTO DATA(ls_key).
**      ls_order-book_id   = ls_key-book_id.
**      ls_order-release_date = cl_abap_context_info=>get_system_date( ).
**      ls_order-current_stock  = ls_order-current_stock + @ls_key-current_stock.
**
**      INSERT INTO zbook09 VALUES @ls_order.
**    ENDLOOP.
**
**    RETURN.
*    ENDMETHOD.
*
*    " 📌 Manage Delivered Books and Update Stock
*    METHOD ManageDeliveredBooks.
**    DATA: lt_update TYPE TABLE OF zbook09.
**
**    LOOP AT keys INTO DATA(ls_data).
**      UPDATE zbook09
**        SET current_stock = current_stock + @ls_data-backorder
**        WHERE book_id = @ls_data-book_id.
**    ENDLOOP.
**
**    RETURN.
*    ENDMETHOD.

    " 📌 Validate Release Date (Should Not Be in the Future)
    METHOD validateBirthdate.

READ ENTITIES OF zi_compo_author IN LOCAL MODE
      ENTITY Author
      FIELDS ( DateOfBirth )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_authors).

    DATA(today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT lt_authors INTO DATA(ls_author).
      IF ls_author-DateOfBirth > today. "Date of birth is in the future
        APPEND VALUE #( %tky = ls_author-%tky ) TO failed-author.

        APPEND VALUE #( %tky = ls_author-%tky
                        %element-dateofbirth = if_abap_behv=>mk-on
                        %msg = new_message( id       = 'ZM_MESSAGES_G2'
                                            number   = '003'
                                            severity = if_abap_behv_message=>severity-error )
                      ) TO reported-author.
      ENDIF.
    ENDLOOP.

    ENDMETHOD.
*
*  METHOD get_instance_features.
*  ENDMETHOD.

ENDCLASS.





*CLASS lhc_stock DEFINITION INHERITING FROM cl_abap_behavior_handler.
*PRIVATE SECTION.
*
**  METHODS get_instance_features FOR INSTANCE FEATURES
**    IMPORTING keys REQUEST requested_features FOR stock RESULT result.
*
**  METHODS CorrectStock FOR MODIFY
**    IMPORTING keys FOR ACTION stock~CorrectStock RESULT result.
**
**  METHODS CreateOrder FOR MODIFY
**    IMPORTING keys FOR ACTION stock~CreateOrder RESULT result.
*
**  METHODS ManageDeliveredBooks FOR MODIFY
**    IMPORTING keys FOR ACTION stock~ManageDeliveredBooks RESULT result.
*
*ENDCLASS.

*CLASS lhc_stock IMPLEMENTATION.
*
*METHOD get_instance_features.
*ENDMETHOD.
*
*METHOD CorrectStock.
*ENDMETHOD.
*
*METHOD CreateOrder.
*ENDMETHOD.
*
*METHOD ManageDeliveredBooks.
*ENDMETHOD.
*
*ENDCLASS.
