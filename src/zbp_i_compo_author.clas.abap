CLASS ZBP_I_COMPO_AUTHOR DEFINITION "PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zi_compo_author.

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZBP_I_COMPO_AUTHOR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TRY.
        " Clear all tables
        DELETE FROM zbook09.
        DELETE FROM zauthor09.

        GET TIME STAMP FIELD DATA(lv_timestamp).

        " Create Authors
        DATA lt_authors TYPE TABLE OF zauthor09.
        lt_authors = VALUE #(
          ( author_id         = cl_system_uuid=>create_uuid_x16_static( )
            first_name        = 'John'
            last_name         = 'Doe'
            date_of_birth     = '19800101'
            nationality       = 'US'
            email             = 'john.doe@example.com'
            phone             = '+1234567890'
            address           = '123 Main Street, NY'
            biography         = 'Famous fiction writer'
            local_created_by  = sy-uname
            local_created_at  = lv_timestamp
            local_last_changed_by = sy-uname
            local_last_changed_at = lv_timestamp )
          ( author_id         = cl_system_uuid=>create_uuid_x16_static( )
            first_name        = 'Jane'
            last_name         = 'Smith'
            date_of_birth     = '19900202'
            nationality       = 'UK'
            email             = 'jane.smith@example.com'
            phone             = '+447700900123'
            address           = '456 Elm Street, London'
            biography         = 'Renowned poet'
            local_created_by  = sy-uname
            local_created_at  = lv_timestamp
            local_last_changed_by = sy-uname
            local_last_changed_at = lv_timestamp )
        ).
        INSERT zauthor09 FROM TABLE @lt_authors.
        IF sy-subrc <> 0.
          out->write( |Error inserting authors.| ).
          RETURN. " Exit if author insertion fails
        ENDIF.

        " Create Books
        DATA lt_books TYPE TABLE OF zbook09.
        lt_books = VALUE #(
          ( book_id      = cl_system_uuid=>create_uuid_x16_static( )
            title        = 'The Great Novel'
            isbn         = '978-0-12-345678-9'
            author_id    = lt_authors[ 1 ]-author_id
            publisher    = 'Acme Publishing'
            release_date = '20231010'
            edition      = '1'
            genre        = 'Fiction'
            language     = 'English'
            pagess    = 300
            cover_type   = 'Hardcover'
            synopsis     = 'A captivating story...'
            keywords     = 'novel, fiction, drama'
            price        = '10.99'
            local_created_by  = sy-uname
            local_created_at  = lv_timestamp
            local_last_changed_by = sy-uname
            local_last_changed_at = lv_timestamp )
          ( book_id      = cl_system_uuid=>create_uuid_x16_static( )
            title        = 'Poetry Collection'
            isbn         = '978-1-23-456789-0'
            author_id    = lt_authors[ 2 ]-author_id
            publisher    = 'Poetry Press'
            release_date = '20240315'
            edition      = '1'
            current_stock = 5
            genre        = 'Poetry'
            language     = 'English'
            pagess    = 150
            price        = '12.49'
            cover_type   = 'Paperback'
            synopsis     = 'Beautiful verses...'
            keywords     = 'poetry, verses, nature'
            local_created_by  = sy-uname
            local_created_at  = lv_timestamp
            local_last_changed_by = sy-uname
            local_last_changed_at = lv_timestamp )
        ).
        INSERT zbook09 FROM TABLE @lt_books.
        IF sy-subrc <> 0.
          out->write( |Error inserting books.| ).
          RETURN.
        ENDIF.

        out->write( |Test data created successfully!| ).

      CATCH cx_uuid_error INTO DATA(lx_uuid_error).
        out->write( |Error generating GUID: | && lx_uuid_error->get_text( ) ).
        RETURN.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
