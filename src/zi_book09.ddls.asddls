@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'view book'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_book09
  as select from zbook09
{


  key book_id               as BookId,
  key author_id             as AuthorId,
      isbn                  as Isbn,
      title                 as Title,
      publisher             as Publisher,
      release_date          as ReleaseDate,
      edition               as Edition,
      genre                 as Genre,
      language              as Language,
      pagess                as Pagess,
      cover_type            as CoverType,
      synopsis              as Synopsis,
      keywords              as Keywords,
      release_year          as ReleaseYear,
      price                 as Price,
      currency              as Currency,
      current_stock         as CurrentStock,
      backorder             as Backorder,

      local_created_by      as Created_by,
      local_created_at      as Created_at,
      local_last_changed_by as Changed_by,
      local_last_changed_at as Changed_at
}
