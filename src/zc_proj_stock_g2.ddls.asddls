@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'proj stock'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_proj_stock_g2
    as projection on zi_compo_stock_g2
{
    key BookId,
    key AuthorId,
    Isbn,
    Title,
    FullName,
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
    Created_by,
    Created_at,
    Changed_by,
    Changed_at,
    /* Associations */
    _auth : redirected to parent zc_proj_author
}
