pageextension 50001 ErpX_SalesInvoiceSubform extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Allow Item Charge Assignment")
        {
            field("Shipment Date"; "Shipment Date")
            {
                ApplicationArea = All;
                Description = 'SP00';
            }
        }
    }
}