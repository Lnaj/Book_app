 @AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'compoview author'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zi_compo_author
  as select from zi_author as author
  composition [0..*] of ZI_Compo_book as _book
  composition [0..*] of zi_compo_stock_g2 as _stock
{
 

 


  key author.AuthorId,
      author.FirstName,
      author.LastName,
      author.FullName,
      author.DateOfBirth,
      author.Nationality,
      author.Email,
      author.Phone,
      author.Address,
      author.Biography,
      @Semantics.user.createdBy: true
      author.Created_by,
      @Semantics.systemDateTime.createdAt: true
      author.Created_at,
      @Semantics.user.lastChangedBy: true
      author.Changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      author.Changed_at,
      _book,
     _stock
     
     
     
      
}
