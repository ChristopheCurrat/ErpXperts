tableextension 50002 ErpX_JobPlanningLine extends "Job Planning Line"
{
    fields
    {
        field(50000; "ErpX_Invoice Period"; DateFormula)
        {
            Caption = 'Invoice Period';
            Description = 'SP04';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key("ErpX_Invoice Period"; "ErpX_Invoice Period")
        {
            Description = 'SP04';
        }
    }

}