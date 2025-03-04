@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection author'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_proj_author
  provider contract transactional_query
  as projection on zi_compo_author

{
  key AuthorId,
      FirstName,
      LastName,
      FullName,
      DateOfBirth,
      Nationality,
      Email,
      Phone,
      Address,
      Biography,
      Created_by,
      Created_at,
      Changed_by,
      Changed_at,
      /* Associations */
      _book : redirected to composition child zc_proj_book,
  _stock : redirected to composition child zc_proj_stock_g2
}
