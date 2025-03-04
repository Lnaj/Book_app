@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'view author'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@Search.searchable: true

define view entity zi_author
  as select from zauthor09
{
  key author_id             as AuthorId,
      @Search.defaultSearchElement: true
      first_name            as FirstName,
      @Search.defaultSearchElement: true
      last_name             as LastName,
        @Search.defaultSearchElement: true
     concat_with_space( first_name, last_name, 1 ) as FullName,
  
     
     
      date_of_birth         as DateOfBirth,
      nationality           as Nationality,
      email                 as Email,
      phone                 as Phone,
      address               as Address,
      biography             as Biography,
      local_created_by      as Created_by,
      local_created_at      as Created_at,
      local_last_changed_by as Changed_by,
      local_last_changed_at as Changed_at

}
