pageextension 50005 ErpX_JobPlanningLines extends "Job Planning Lines"
{
    layout
    {
        addafter("Planned Delivery Date")
        {
            field("ErpX_Invoice Period"; "ErpX_Invoice Period")
            {
                ApplicationArea = All;
                Description = 'SP04';
            }
        }
    }
}