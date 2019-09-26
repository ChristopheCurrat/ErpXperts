pageextension 50007 ErpX_JobProjectManagerRC extends "Job Project Manager RC"
{
    layout
    {
        addafter(Control34)
        {
            part("ErpX_Chargeable Time Chart";"ErpX_Chargeable Time Chart")
            {
                ApplicationArea = Jobs;
                Caption = 'Chargeable Time Chart';
                Visible = false;
            }
        }
    }
}