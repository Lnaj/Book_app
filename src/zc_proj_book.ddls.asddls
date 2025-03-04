@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection book'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
define view entity zc_proj_book
  as projection on ZI_Compo_book
{

  key BookId,
  key AuthorId,
      Isbn,
      Title,
      Publisher,
      ReleaseDate,
      Edition,
      Genre,
      Language,
      Pagess,
      CoverType,
      Synopsis,
      Keywords,
      ReleaseYear,
      Price,
      Currency,
      Created_by,
      Created_at,
      Changed_by,
      Changed_at,
      /* Associations */
      _auth : redirected to parent zc_proj_author
}
