page 50002 "ErpX_Time Sheet Line"
{
    // version SP00

    Caption = 'Time Sheet Line';
    PageType = List;
    SourceTable = "Time Sheet Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Time Sheet No."; "Time Sheet No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field("Time Sheet Starting Date"; "Time Sheet Starting Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; "Approver ID")
                {
                    ApplicationArea = All;
                }
                field("Service Order No."; "Service Order No.")
                {
                    ApplicationArea = All;
                }
                field("Service Order Line No."; "Service Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Total Quantity"; "Total Quantity")
                {
                    ApplicationArea = All;
                }
                field(Chargeable; Chargeable)
                {
                    ApplicationArea = All;
                }
                field("Assembly Order No."; "Assembly Order No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly Order Line No."; "Assembly Order Line No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Approved By"; "Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approval Date"; "Approval Date")
                {
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

