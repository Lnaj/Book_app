@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite View for Stock'
@Metadata.ignorePropagatedAnnotations: true

 
@Metadata.allowExtensions: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity zi_compo_stocks as select from zi_stock as stock
    composition [0..*] of zi_compo_orderitems as _order_item

    // Define associations separately (without ON condition in composition)
    association to zi_book09 as _book on $projection.BookId = _book.BookId
    //association to zorder as _order on _order_item.OrderId = _order.order_id

{
     key stock.BookId,
     stock.CurrentStock,
     stock.Backorder,
     @Semantics.user.createdBy: true
     stock.LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      stock.LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
       stock.LocalLastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
     stock.LocalLastChangedAt,
    _book.Title,
     _book,
     _order_item
    
      
}

