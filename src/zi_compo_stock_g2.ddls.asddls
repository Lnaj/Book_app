@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Compo Stock'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define  view entity zi_compo_stock_g2 as select from zi_book09
 association to parent zi_compo_author as _auth on $projection.AuthorId = _auth.AuthorId

{
    key BookId,
    key AuthorId,
    Isbn,
    _auth.FullName,
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
    CurrentStock,
    Backorder,
    @Semantics.user.createdBy: true
      Created_by,
      @Semantics.systemDateTime.createdAt: true
      Created_at,
      @Semantics.user.lastChangedBy: true
      Changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      Changed_at,
      _auth
 
}
