tableextension 50001 ErpX_JobTask extends "Job Task"
{
    fields
    {
        field(50000; ErpX_Blocked; Boolean)
        {
            Caption = 'Blocked';
            Description = 'SP07';
            DataClassification = CustomerContent;
        }
        field(50001; "ErpX_Actual progress in %"; Decimal)
        {
            Caption = 'Actual progress in %';
            TableRelation = "Standard Text";
            Description = 'SP08';
            DataClassification = CustomerContent;
        }

    }
}