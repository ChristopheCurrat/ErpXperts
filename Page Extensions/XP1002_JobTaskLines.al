pageextension 50004 ErpX_JobTaskLines extends "Job Task Lines"
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

    actions
    {
        addafter("<Action7>")
        {
            group("ErpXperts")
            {
                action(MakeSalesQuote)
                {
                    Description = 'SP05';
                    ApplicationArea = Jobs;
                    Caption = 'Make Sales Quote';
                    Ellipsis = true;
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction();
                    var
                        _MakeSalesQuote: Report "ErpX_Make Sales Quote";
                    begin
                        _MakeSalesQuote.SetJobNo("Job No.");
                        _MakeSalesQuote.RunModal();;
                    end;
                }
            }
        }
    }

}