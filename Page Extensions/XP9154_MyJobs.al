pageextension 50000 ErpX_MyJobs extends "My Jobs"
{
    layout
    {
        addafter("Exclude from Business Chart")
        {
            field("ErpX_Qty. to Invoice"; "ErpX_Qty. to Invoice")
            {
                ApplicationArea = All;
                Description = 'SP00';
            }
        }
    }
}