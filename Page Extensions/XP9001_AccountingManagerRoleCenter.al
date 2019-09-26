pageextension 50006 ErpX_AccountingManRoleCenter extends "Accounting Manager Role Center"
{
    layout
    {
        addafter(Control106)
        {
            part("ErpX_Chargeable Time Chart"; "ErpX_Chargeable Time Chart")
            {
                ApplicationArea = Jobs;
                Caption = 'Chargeable Time Chart';
                Visible = false;
            }
        }
    }
}