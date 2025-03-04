CLASS zinsertnationalities DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZINSERTNATIONALITIES IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DELETE FROM znationalities.
    DELETE FROM zgenre.
    DELETE FROM zcovertype.

    DATA: lt_nationalities TYPE TABLE OF znationalities,
          ls_nationalies   TYPE znationalities.

    DATA: lt_genres TYPE TABLE OF zgenre,
          ls_genres TYPE zgenre.

    DATA: lt_covertypes TYPE TABLE OF zcovertype,
          ls_covertypes TYPE zcovertype.

    lt_nationalities = VALUE #(
       ( nationality = 'Belgian' )
       ( nationality = 'Brazilian' )
       ( nationality = 'Canadian' )
       ( nationality = 'Colombian' )
       ( nationality = 'Dutch' )
       ( nationality = 'French' )
       ( nationality = 'German' )
       ( nationality = 'Italian' )
       ( nationality = 'Mexican' )
       ( nationality = 'Palestinian' )
       ( nationality = 'Peruvian' )
       ( nationality = 'Portuguese' )
       ( nationality = 'Spanish' )
       ( nationality = 'Swiss' )
       ( nationality = 'Turkish' )
       ( nationality = 'British' )
       ( nationality = 'Argentine' )
       ( nationality = 'Chilean' )
       ( nationality = 'American' )
       ( nationality = 'Uruguayan' ) ).

    lt_genres = VALUE #(
       ( genre = 'Fiction' )
       ( genre = 'Non-Fiction' )
       ( genre = 'Mystery' )
       ( genre = 'Thriller' )
       ( genre = 'Fantasy' )
       ( genre = 'Science Fiction' )
       ( genre = 'Romance' )
       ( genre = 'Historical Fiction' )
       ( genre = 'Biography' )
       ( genre = 'Young Adult' ) ).


    lt_covertypes = VALUE #(
    ( covertype = 'Hardcover' )
    ( covertype = 'Paperback' )
    ( covertype = 'Mass Market Paperback' )
    ( covertype = 'Trade Paperback' )
    ( covertype = 'Dust Jacket' )
    ( covertype = 'Board Book' )
    ( covertype = 'Spiral Bound' )
    ( covertype = 'Leather Bound' )
    ( covertype = 'Slipcase' ) ).

    INSERT znationalities FROM TABLE @lt_nationalities.
    INSERT zgenre FROM TABLE @lt_genres.
    INSERT zcovertype FROM TABLE @lt_covertypes.

    IF sy-subrc = 0.
      out->write( |The data has been added successfully.| ).
    ELSE.
      out->write( |Error adding data.| ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
