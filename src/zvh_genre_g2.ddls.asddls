@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'value help genre'
@ObjectModel : { resultSet.sizeCategory: #XS }

define view entity ZVH_genre_G2
as select from zgenre

{
    key genre as Genre
    
    }
 