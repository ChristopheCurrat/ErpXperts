pageextension 50009 ErpX_JobTaskLinesSubform extends "Job Task Lines Subform"
{
    layout
    {
        addafter("Job Task Type")
        {
            field(ErpX_Blocked; ErpX_Blocked)
            {
                ApplicationArea = All;
                Description = 'SP07';
            }
        }
        addafter("End Date")
        {
            field("ErpX_Actual progress in %"; "ErpX_Actual progress in %")
            {
                ApplicationArea = All;
                Description = 'SP08';
            }
        }
    }
}