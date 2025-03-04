@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'compoview book'
@Metadata.ignorePropagatedAnnotations: false
define view entity ZI_Compo_book
  as select from zi_book09
  association to parent zi_compo_author as _auth on $projection.AuthorId = _auth.AuthorId
{



  key zi_book09.BookId,
  key zi_book09.AuthorId,
      zi_book09.Isbn,
      zi_book09.Title,
      zi_book09.Publisher,
      zi_book09.ReleaseDate,
      zi_book09.Edition,
      zi_book09.Genre,
      zi_book09.Language,
      zi_book09.Pagess,
      zi_book09.CoverType,
      zi_book09.Synopsis,
      zi_book09.Keywords,
      zi_book09.ReleaseYear,
      zi_book09.Price,
      zi_book09.Currency,
      @Semantics.user.createdBy: true
      zi_book09.Created_by,
      @Semantics.systemDateTime.createdAt: true
      zi_book09.Created_at,
      @Semantics.user.lastChangedBy: true
      zi_book09.Changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      zi_book09.Changed_at,



      _auth // Make association public


}
