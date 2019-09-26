pageextension 50003 ErpX_JobList extends "Job List"
{
    layout
    {
        addafter("Bill-to Customer No.")
        {
            field("Bill-to Name"; "Bill-to Name")
            {
                ApplicationArea = All;
                Description = 'SP00';
            }
        }
    }
}