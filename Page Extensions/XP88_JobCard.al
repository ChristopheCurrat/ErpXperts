pageextension 50002 ErpX_JobCard extends "Job Card"
{
    actions
    {
        addafter(Action26)
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
                        _MakeSalesQuote.SetJobNo("No.");
                        _MakeSalesQuote.RunModal();;
                    end;
                }
            }
        }
    }
}