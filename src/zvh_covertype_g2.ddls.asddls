@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'value help covertype'
@ObjectModel : { resultSet.sizeCategory: #XS }

define view entity ZVH_COVERTYPE_G2
as select from zcovertype

{
    key covertype as Covertype
    
    }
 