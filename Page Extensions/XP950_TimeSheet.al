pageextension 50008 ErpX_TimeSheet extends "Time Sheet"
{
    layout
    {
        addafter(Status)
        {
            field(Posted; Posted)
            {
                ApplicationArea = All;
                Description = 'SP00';
            }
        }
        addafter("Job No.")
        {
            field("Job Description"; GetJobDescription())
            {
                ApplicationArea = All;
                Editable = false;
                QuickEntry = false;
                Description = 'SP00';
            }
        }
        addafter("Job No.")
        {
            field("Bill-to Name"; GetBillToName())
            {
                ApplicationArea = All;
                Editable = false;
                QuickEntry = false;
                Description = 'SP00';
            }
        }
    }
    local procedure GetJobDescription(): Text[50];
    var
        _Job: Record Job;
    begin
        IF _Job.GET("Job No.") THEN
            EXIT(_Job.Description);
    end;

    local procedure GetBillToName(): Text[50];
    var
        _Job: Record Job;
    begin
        IF _Job.GET("Job No.") THEN
            EXIT(_Job."Bill-to Name");
    end;

}